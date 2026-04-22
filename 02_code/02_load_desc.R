# 02_load_desc.R
# Compute total assault injury events among California adults aged 50+
# from the desc_tables "Table 1" sheets (age-stratified).
# Run line by line.

source(here::here("02_code", "setup.R"))

# -------------------------------------------------------------------
# Read Table 1 sheets, cast counts to numeric
# -------------------------------------------------------------------
tbl1_w <- read_excel(path_desc_women, sheet = "Table 1", col_types = "text") %>%
  mutate(sum_n_yr_ipv = as.numeric(sum_n_yr_ipv), sex = "Female")

tbl1_m <- read_excel(path_desc_men, sheet = "Table 1", col_types = "text") %>%
  mutate(sum_n_yr_ipv = as.numeric(sum_n_yr_ipv), sex = "Male")

# -------------------------------------------------------------------
# Keep rows labeled by age (the 'character' column is age when the label
# matches an age band). Age-50+ rows match age_levels_50plus.
# -------------------------------------------------------------------
desc_age_50plus <- bind_rows(tbl1_w, tbl1_m) %>%
  filter(character %in% age_levels_50plus) %>%
  select(sex, age_output = character, n = sum_n_yr_ipv) %>%
  mutate(age_output = factor(age_output, levels = age_levels_50plus),
         sex        = factor(sex, levels = c("Female", "Male")))

desc_age_50plus

# -------------------------------------------------------------------
# Totals
# -------------------------------------------------------------------
total_by_sex <- desc_age_50plus %>%
  group_by(sex) %>%
  summarise(n = sum(n), .groups = "drop")

total_overall <- sum(desc_age_50plus$n)

total_by_sex
total_overall

# -------------------------------------------------------------------
# Save summary
# -------------------------------------------------------------------
saveRDS(list(
  by_age_sex   = desc_age_50plus,
  by_sex       = total_by_sex,
  overall      = total_overall
), here("01_data", "desc_totals_50plus.rds"))
