# 01_load_rates.R
# Load age-specific assault injury rates from estimates_aggregate XLSX files.
# Run line by line.

source(here::here("02_code", "setup.R"))

# -------------------------------------------------------------------
# Helper: read one sex-specific file and parse "estimate (lcl, ucl)" cells
# -------------------------------------------------------------------
read_parse_rates <- function(path, sheet, sex_label) {
  df_raw <- read_excel(path, sheet = sheet, col_types = "text")

  parse_est_ci <- function(x) {
    x <- str_squish(as.character(x))
    tibble(
      estimate = as.numeric(str_match(x, "^([-0-9.]+)")[, 2]),
      lcl      = as.numeric(str_match(x, "\\(([-0-9.]+),")[, 2]),
      ucl      = as.numeric(str_match(x, ",\\s*([-0-9.]+)\\)")[, 2])
    )
  }

  df_raw %>%
    pivot_longer(cols = -age_output, names_to = "group", values_to = "cell") %>%
    mutate(
      cell   = na_if(str_trim(cell), ""),
      parsed = map(cell, parse_est_ci)
    ) %>%
    unnest(parsed) %>%
    select(-cell) %>%
    mutate(sex = sex_label)
}

# -------------------------------------------------------------------
# Confirm sheet names before parsing (run interactively)
# -------------------------------------------------------------------
excel_sheets(path_rates_women)
excel_sheets(path_rates_men)

# -------------------------------------------------------------------
# Read rates for both sexes
# -------------------------------------------------------------------
sheet_name <- "IPV rates"

df_women <- read_parse_rates(path_rates_women, sheet_name, "Female")
df_men   <- read_parse_rates(path_rates_men,   sheet_name, "Male")

head(df_women)
head(df_men)

# -------------------------------------------------------------------
# Combine, filter to age 50+, attach spelled-out labels
# -------------------------------------------------------------------
df_rates <- bind_rows(df_women, df_men) %>%
  filter(age_output %in% age_levels_50plus) %>%
  mutate(
    age_output  = factor(age_output, levels = age_levels_50plus),
    group_label = factor(re_labels[group], levels = re_groups),
    sex         = factor(sex, levels = c("Female", "Male"))
  ) %>%
  select(sex, group, group_label, age_output, estimate, lcl, ucl)

df_rates
summary(df_rates)

# -------------------------------------------------------------------
# Save for downstream scripts
# -------------------------------------------------------------------
saveRDS(df_rates, here("01_data", "df_rates.rds"))
