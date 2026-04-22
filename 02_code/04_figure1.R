# 04_figure1.R
# Build Figure 1: two-panel line plot of age-specific assault injury rates
# by race/ethnicity, faceted by sex. Multiracial visually emphasized via
# thicker line. Total excluded from the figure (shown in Table 1 only).
# Run line by line.

source(here::here("02_code", "setup.R"))

df_rates <- readRDS(here("01_data", "df_rates.rds"))

# -------------------------------------------------------------------
# Drop Total from the figure; drop unused factor levels
# -------------------------------------------------------------------
df_plot <- df_rates %>%
  filter(group != "TOTAL") %>%
  mutate(group_label = droplevels(group_label))

# Named linewidth values restricted to the groups we plot
lw_values <- re_linewidth[levels(df_plot$group_label)]

# -------------------------------------------------------------------
# Build plot
# -------------------------------------------------------------------
fig1 <- ggplot(df_plot,
               aes(x = age_output, y = estimate,
                   color = group_label, fill = group_label,
                   group = group_label)) +
  geom_ribbon(aes(ymin = lcl, ymax = ucl),
              alpha = 0.15, color = NA) +
  geom_line(aes(linewidth = group_label)) +
  geom_point(size = 1.2) +
  scale_linewidth_manual(values = lw_values, guide = "none") +
  facet_wrap(~ sex, nrow = 1) +
  labs(
    x     = "Age group",
    y     = "Rate per 100,000 person-years",
    color = NULL,
    fill  = NULL
  ) +
  theme_bw(base_family = "serif", base_size = 9) +
  theme(
    legend.position  = "bottom",
    legend.text      = element_text(size = 9),
    legend.key.width = unit(0.6, "cm"),
    axis.text.x      = element_text(angle = 45, hjust = 1),
    strip.background = element_rect(fill = "gray95"),
    strip.text       = element_text(face = "bold")
  ) +
  guides(
    color = guide_legend(nrow = 2, byrow = TRUE),
    fill  = guide_legend(nrow = 2, byrow = TRUE)
  )

fig1

# -------------------------------------------------------------------
# Preview export (PNG at 300 dpi; open to zoom in)
# -------------------------------------------------------------------
ggsave(
  here("03_results", "fig1_preview.png"),
  plot = fig1, width = 6.5, height = 3.5, dpi = 300, bg = "white"
)

# PDF at 600 dpi — JAGS-preferred format for line art
ggsave(
  here("03_results", "fig1_submission.pdf"),
  plot = fig1, width = 6.5, height = 3.5, device = cairo_pdf, bg = "white"
)

# -------------------------------------------------------------------
# Save for the QMD chunk
# -------------------------------------------------------------------
saveRDS(fig1, here("03_results", "fig_rates.rds"))
