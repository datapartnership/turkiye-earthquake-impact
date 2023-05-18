# Trends in Nighttime Lights

# Load data --------------------------------------------------------------------
ntl_df <- readRDS(file.path(ntl_bm_dir, "FinalData", "aggregated", "adm2_VNP46A2.Rds"))
eq_df <- read_csv(file.path(eq_usgs_dir, "turkiye_admn2_earthquake_intensity_max.csv"))

df <- ntl_df %>%
  left_join(eq_df, by = "pcode") %>%
  distinct(date, adm2_en, .keep_all = T)

# Calculate moving average within groups
df <- df %>%
  arrange(date) %>%
  group_by(adm2_en) %>%
  mutate(ntl_bm_mean_ma7 = rollmean(ntl_bm_mean, 
                                    k = 7, align = "right", fill = NA)) %>%
  ungroup()

# Individual ADMs --------------------------------------------------------------
mi_u <- df$mmi_feb06_7p8 %>% floor() %>% unique() %>% sort()
for(mi in mi_u){
  
  p <- df %>%
    dplyr::filter(date >= ymd("2022-11-01"),
                  floor(mmi_feb06_7p8) == mi) %>%
    ggplot(aes(x = date)) +
    geom_col(aes(y = ntl_bm_mean), fill = "gray70") +
    geom_line(aes(y = ntl_bm_mean_ma7), color = "black") +
    geom_vline(xintercept = ymd("2023-02-06"),
               color = "red") +
    labs(x = NULL, y = "NTL",
         title = "Trends in Nighttime Lights Across ADM2",
         subtitle = paste0("MI: ", mi)) +
    theme_classic2() +
    theme(strip.text = element_text(face = "bold"),
          strip.background = element_blank(),
          plot.title = element_text(face = "bold", hjust = 0.5)) +
    facet_wrap(~adm2_en,
               scales = "free_y") 
  
  ggsave(p, filename = file.path(fig_dir, 
                                 paste0("ntl_trends_daily_adm2_mi", mi, ".png")),
         height = 13, width = 13)
}

# Average ----------------------------------------------------------------------
mi_df <- df %>%
  dplyr::filter(date >= ymd("2022-11-01")) %>%
  mutate(mi = floor(mmi_feb06_7p8)) %>%
  group_by(date, mi) %>%
  summarise(ntl_bm_mean = mean(ntl_bm_mean),
            ntl_bm_mean_ma7 = mean(ntl_bm_mean_ma7)) %>%
  ungroup() %>%
  mutate(mi = paste0("MI = ", mi))

mi_df %>%
  ggplot(aes(x = date)) +
  geom_col(aes(y = ntl_bm_mean), fill = "gray70") +
  geom_line(aes(y = ntl_bm_mean_ma7), color = "black") +
  geom_vline(xintercept = ymd("2023-02-06"),
             color = "red") +
  labs(x = NULL, y = "NTL",
       title = "Trends in Nighttime Lights Across MI") +
  theme_classic2() +
  theme(strip.text = element_text(face = "bold"),
        strip.background = element_blank(),
        plot.title = element_text(face = "bold", hjust = 0.5)) +
  facet_wrap(~mi,
             scales = "free_y") 

ggsave(filename = file.path(fig_dir, 
                               paste0("ntl_trends_daily_adm2_mi", "all_column", ".png")),
       height = 4, width = 6)

mi_df %>%
  ggplot(aes(x = date)) +
  geom_line(aes(y = ntl_bm_mean_ma7), color = "black") +
  geom_vline(xintercept = ymd("2023-02-06"),
             color = "red") +
  labs(x = NULL, y = "NTL",
       title = "Trends in Nighttime Lights Across MI") +
  theme_classic2() +
  theme(strip.text = element_text(face = "bold"),
        strip.background = element_blank(),
        plot.title = element_text(face = "bold", hjust = 0.5)) +
  facet_wrap(~mi,
             scales = "free_y") 

ggsave(filename = file.path(fig_dir, 
                               paste0("ntl_trends_daily_adm2_mi", "all_line", ".png")),
       height = 4, width = 6)

