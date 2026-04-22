# 03_table1.R
# Build Table 1: age-specific assault injury rates per 100,000 person-years
# (95% CI), by sex and race/ethnicity.
# Run line by line.

source(here::here("02_code", "setup.R"))
library(officer)

df_rates <- readRDS(here("01_data", "df_rates.rds"))

# -------------------------------------------------------------------
# Format cells as "estimate (lcl, ucl)" with 1 decimal place
# -------------------------------------------------------------------
fmt1 <- function(x) formatC(x, digits = 1, format = "f")

df_cells <- df_rates %>%
  filter(group != "TOTAL") %>%
  mutate(
    group_label = droplevels(group_label),
    cell = paste0(fmt1(estimate), "\n(", fmt1(lcl), ", ", fmt1(ucl), ")")
  ) %>%
  select(sex, age_output, group_label, cell)

# -------------------------------------------------------------------
# Pivot wide: one row per sex x age, one column per race/ethnicity group
# -------------------------------------------------------------------
df_wide <- df_cells %>%
  pivot_wider(names_from = group_label, values_from = cell) %>%
  arrange(sex, age_output) %>%
  rename(Age = age_output)

df_wide

# -------------------------------------------------------------------
# Build flextable with sex as a section header row (grouped data)
# -------------------------------------------------------------------
grouped <- df_wide %>%
  as_grouped_data(groups = "sex")

thin <- fp_border(width = 0.5, color = "black")

header_labels <- list(Age = "Age group")

footnote_text <- paste(
  "Abbreviations: AIAN = American Indian or Alaska Native;",
  "API = Asian or Pacific Islander."
)

ft <- as_flextable(grouped, hide_grouplabel = TRUE) %>%
  add_footer_lines(footnote_text) %>%
  font(fontname = "Times New Roman", part = "all") %>%
  fontsize(size = 10, part = "all") %>%
  line_spacing(space = 1, part = "all") %>%
  set_header_labels(values = header_labels) %>%
  bold(part = "header", bold = TRUE) %>%
  bold(i = ~ !is.na(sex), bold = TRUE) %>%
  italic(i = ~ !is.na(sex), italic = TRUE) %>%
  align(align = "center", part = "body") %>%
  align(j = "Age", align = "left", part = "body") %>%
  align(i = ~ !is.na(sex), align = "left", part = "body") %>%
  align(align = "center", part = "header") %>%
  align(align = "left", part = "footer") %>%
  padding(padding.top = 1, padding.bottom = 1,
          padding.left = 4, padding.right = 4, part = "all") %>%
  border_remove() %>%
  hline_top(border = thin, part = "header") %>%
  hline_bottom(border = thin, part = "header") %>%
  hline_bottom(border = thin, part = "body") %>%
  autofit() %>%
  fit_to_width(max_width = 6.5)

ft

# -------------------------------------------------------------------
# Preview: export a standalone .docx you can open in Word and zoom in
# -------------------------------------------------------------------
save_as_docx(ft, path = here("03_results", "tbl1_preview.docx"))

# -------------------------------------------------------------------
# Save for the QMD chunk
# -------------------------------------------------------------------
saveRDS(ft, here("03_results", "tbl_rates.rds"))
