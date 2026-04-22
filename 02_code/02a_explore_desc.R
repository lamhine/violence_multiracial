# 02a_explore_desc.R
# Peek at the desc_tables XLSX files to figure out their structure.
# Run line by line and report back what you see.

source(here::here("02_code", "setup.R"))

# -------------------------------------------------------------------
# Sheet names
# -------------------------------------------------------------------
excel_sheets(path_desc_women)
excel_sheets(path_desc_men)

# -------------------------------------------------------------------
# Read each sheet with column-type = "text" so nothing coerces silently,
# and look at the first few rows. Replace the sheet name below with each
# sheet returned above if there are multiple.
# -------------------------------------------------------------------
sheets_w <- excel_sheets(path_desc_women)
sheets_m <- excel_sheets(path_desc_men)

# Preview first sheet from women's file
read_excel(path_desc_women, sheet = sheets_w[1], col_types = "text")

# Preview first sheet from men's file
read_excel(path_desc_men, sheet = sheets_m[1], col_types = "text")
