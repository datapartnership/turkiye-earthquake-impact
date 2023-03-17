# Trends in Nighttime Lights

# Load data --------------------------------------------------------------------
ntl_df <- readRDS(file.path(ntl_bm_dir, "FinalData", "aggregated", "adm2_VNP46A3.Rds"))
eq_df <- read_csv(file.path(eq_usgs_dir, "turkiye_admn2_earthquake_intensity_max.csv"))

df <- ntl_df %>%
  left_join(eq_df, by = "pcode")

mi_u <- df$mmi_feb06_7p8 %>% floor() %>% unique() %>% sort()
for(mi in mi_u){
  
  p <- df %>%
    dplyr::filter(date >= ymd("2022-01-01"),
                  floor(mmi_feb06_7p8) == mi) %>%
    ggplot() +
    geom_vline(xintercept = ymd("2023-02-06"),
               color = "red") +
    geom_col(aes(x = date, y = ntl_bm_mean)) +
    labs(x = "Date", y = "NTL",
         title = "Trends in Nighttime Lights Across ADM2",
         subtitle = paste0("MI: ", mi)) +
    facet_wrap(~adm2_en,
               scales = "free_y") 
  
  ggsave(p, filename = file.path(fig_dir, 
                                 paste0("ntl_trends_monthly_adm2_mi", mi, ".png")),
         height = 13, width = 13)
}