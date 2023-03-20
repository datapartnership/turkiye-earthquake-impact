# Nighttime Lights Change Map: ADM2

# Load data --------------------------------------------------------------------
adm0_sf <- readOGR(dsn = file.path(adm_dir, "tur_polbnda_adm0.shp")) %>% 
  st_as_sf()

adm2_sf <- readOGR(dsn = file.path(adm_dir, "tur_polbna_adm2.shp")) %>% 
  st_as_sf() %>%
  dplyr::select(pcode)

ntl_df <- readRDS(file.path(ntl_bm_dir, "FinalData", "aggregated", paste0("adm2", "_", "VNP46A2", ".Rds")))

eq_df <- read_csv(file.path(eq_usgs_dir, "turkiye_admn2_earthquake_intensity_max.csv"))

# Prep data --------------------------------------------------------------------
ntl_sum_df <- ntl_df %>%
  dplyr::mutate(period_2wk = case_when(
    date %in% ymd("2023-01-23"):ymd("2023-02-05") ~ "ntl_before",
    date %in% ymd("2023-02-07"):ymd("2023-02-20") ~ "ntl_after"
  )) %>%
  dplyr::mutate(period_1wk = case_when(
    date %in% ymd("2023-01-30"):ymd("2023-02-05") ~ "ntl_before",
    date %in% ymd("2023-02-07"):ymd("2023-02-13") ~ "ntl_after"
  )) %>%
  dplyr::mutate(period = period_2wk) %>%
  group_by(period, pcode) %>%
  dplyr::summarise(ntl_bm_mean = mean(ntl_bm_mean)) %>%
  ungroup() %>%
  pivot_wider(id_cols = pcode, names_from = period, values_from = ntl_bm_mean) %>%
  mutate(ntl_pchange = (ntl_after - ntl_before) / ntl_before * 100) %>%
  left_join(eq_df, by = "pcode") %>%
  mutate(mi_max = pmax(mmi_feb06_6p3, mmi_feb06_6p7, mmi_feb06_7p5, mmi_feb20_6p3, mmi_feb06_7p8, mmi_feb06_6p0)) %>%
  dplyr::mutate(change_type = case_when(
    ntl_pchange >= 10 ~ "> 10% Increase",
    ntl_pchange <= -10 ~ "> 10% Decrease",
    TRUE ~ "Small change"
  ))

adm2_sf <- adm2_sf %>%
  left_join(ntl_sum_df, by = "pcode")

adm2_sf$ntl_pchange[adm2_sf$ntl_pchange > 50] <- 50

# P Change ---------------------------------------------------------------------
p <- ggplot() +
  geom_sf(data = adm0_sf,
          fill = "gray50") +
  geom_sf(data = adm2_sf[adm2_sf$mi_max >= 5,],
          aes(fill = ntl_pchange)) +
  geom_sf(data = adm2_sf[adm2_sf$mi_max >= 6,] %>% st_union(),
          color = "black",
          size = 0.75,
          fill = NA) +
  theme_void() +
  labs(fill = "Change in\nNighttime\nLights") +
  scale_fill_distiller(palette = "Spectral",
                       breaks = c(-25, 0, 25, 50),
                       labels = c("-25", "0", "25", ">50"),
                       limits = c(-26, 51))

ggsave(p, filename = file.path(fig_dir, "ntl_adm2_map_raw.png"),
       height = 6, width = 10)

# Categories -------------------------------------------------------------------
p <- ggplot() +
  geom_sf(data = adm0_sf,
          fill = "gray50") +
  geom_sf(data = adm2_sf[adm2_sf$mi_max >= 5,],
          aes(fill = factor(change_type))) +
  geom_sf(data = adm2_sf[adm2_sf$mi_max >= 6,] %>% st_union(),
          color = "black",
          size = 0.75,
          fill = NA) +
  theme_void() +
  labs(fill = "Change in\nNighttime\nLights") +
  scale_fill_manual(values = c("dodgerblue", "darkorange", "gray"))

ggsave(p, filename = file.path(fig_dir, "ntl_adm2_map_cat.png"),
       height = 6, width = 10)

# Trends -----------------------------------------------------------------------
p <- ntl_df %>%
  left_join(eq_df, by = "pcode") %>%
  dplyr::filter(adm2_en == "ANTAKYA",
                date >= ymd("2023-01-01")) %>%
  ggplot() +
  geom_col(aes(x = date, y = ntl_bm_mean),
           fill = "dodgerblue") +
  geom_vline(xintercept = ymd("2023-02-06"),
             color = "red") +
  labs(x = NULL,
       y = "NTL") +
  theme_classic2()

ggsave(p, filename = file.path(fig_dir, "ntl_adm2_dec_ex.png"),
       height = 2, width = 3.5)

p <- ntl_df %>%
  left_join(eq_df, by = "pcode") %>%
  dplyr::filter(adm2_en == "GUROYMAK",
                date >= ymd("2023-01-01")) %>%
  ggplot() +
  geom_col(aes(x = date, y = ntl_bm_mean),
           fill = "darkorange") +
  geom_vline(xintercept = ymd("2023-02-06"),
             color = "red") +
  labs(x = NULL,
       y = "NTL") +
  theme_classic2()

ggsave(p, filename = file.path(fig_dir, "ntl_adm2_inc_ex.png"),
       height = 2, width = 3.5)
