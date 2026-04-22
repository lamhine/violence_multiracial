# setup.R
# Project: Violent victimization of older Multiracial adults in California, 2005-2022
# Source this at the top of each analysis script:  source(here::here("02_code", "setup.R"))

library(here)
library(tidyverse)
library(readxl)
library(epitools)
library(flextable)

# -------------------------------------------------------------------
# Age levels (5-year bands, 50 and older)
# -------------------------------------------------------------------
age_levels_50plus <- c(
  "50-54", "55-59", "60-64", "65-69",
  "70-74", "75-79", "80-84", "85+"
)

# -------------------------------------------------------------------
# Race and ethnicity
# Convention: Hispanic of any race; all other groups strictly non-Hispanic.
# Source data columns use abbreviations (AI, API, BAA, HISP, MULT, WHITE, TOTAL);
# manuscript output uses spelled-out labels.
# -------------------------------------------------------------------
re_abbrev <- c("AI", "API", "BAA", "HISP", "MULT", "WHITE", "TOTAL")

re_labels <- c(
  "AI"    = "AIAN",
  "API"   = "API",
  "BAA"   = "Black",
  "HISP"  = "Hispanic",
  "MULT"  = "Multiracial",
  "WHITE" = "White",
  "TOTAL" = "Total"
)

re_groups <- unname(re_labels)

# -------------------------------------------------------------------
# Line widths: Multiracial thicker for emphasis; colors use ggplot default
# -------------------------------------------------------------------
re_linewidth <- c(
  "AIAN"        = 0.7,
  "API"         = 0.7,
  "Black"       = 0.7,
  "Hispanic"    = 0.7,
  "Multiracial" = 1.3,
  "White"       = 0.7,
  "Total"       = 0.7
)

# -------------------------------------------------------------------
# Data paths (Box sync folder)
# -------------------------------------------------------------------
box_dir <- "/Users/lamhine/Library/CloudStorage/Box-Box/Trends_Violence_Men"

path_rates_women <- file.path(box_dir, "women_estimates_aggregate20251029.xlsx")
path_rates_men   <- file.path(box_dir, "men_estimates_aggregate20251215.xlsx")
path_desc_women  <- file.path(box_dir, "women_desc_tables20251029.xlsx")
path_desc_men    <- file.path(box_dir, "men_desc_tables20251215.xlsx")
path_std_pop     <- file.path(box_dir, "STD_POP.xlsx")
