# 02b_explore_desc.R
# Look at the "Table 1" sheet in both desc_tables files to find age-stratified counts.

source(here::here("02_code", "setup.R"))

# Women's Table 1 — print full tibble
tbl1_w <- read_excel(path_desc_women, sheet = "Table 1", col_types = "text")
print(tbl1_w, n = Inf, width = Inf)

# Men's Table 1 — print full tibble
tbl1_m <- read_excel(path_desc_men, sheet = "Table 1", col_types = "text")
print(tbl1_m, n = Inf, width = Inf)
