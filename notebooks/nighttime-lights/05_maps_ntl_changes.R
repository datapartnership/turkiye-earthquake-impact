# Nighttime Lights Change Map at ADM2 Level

# Show changes in NTL at the ADM2 level. Show:
# 1. Percent change in NTL
# 2. Map showing ADM2s with large increase/decrease in NTL
# 3. Figures showing trends in NTL for example ADM2s with large increase/decrease in NTL

# Load data --------------------------------------------------------------------
## ADM0 Boundary
adm0_sf <- readOGR(dsn = file.path(adm_dir, "tur_polbnda_adm0.shp")) %>% 
  st_as_sf()

## ADM2 Boundary
adm2_sf <- readOGR(dsn = file.path(adm_dir, "tur_polbna_adm2.shp")) %>% 
  st_as_sf() %>%
  dplyr::select(pcode)

## Daily NTL at ADM2
ntl_df <- readRDS(file.path(ntl_bm_dir, "FinalData", "aggregated", paste0("adm2_VNP46A2.Rds")))

## Earthquake intensity data
eq_df <- read_csv(file.path(eq_usgs_dir, "turkiye_admn2_earthquake_intensity_max.csv"))

# Prep data --------------------------------------------------------------------
ntl_sum_df <- ntl_df %>%
  
  ## Classify time as two weeks before/after
  dplyr::mutate(period = case_when(
    date %in% ymd("2023-01-23"):ymd("2023-02-05") ~ "ntl_before",
    date %in% ymd("2023-02-07"):ymd("2023-02-20") ~ "ntl_after"
  )) %>%
  
  ## Average NTL by ADM2 and time period (two weeks before / after)
  group_by(period, pcode) %>%
  dplyr::summarise(ntl_bm_mean = mean(ntl_bm_mean)) %>%
  
  ## Reshape from long to wide
  ungroup() %>%
  pivot_wider(id_cols = pcode, names_from = period, values_from = ntl_bm_mean) %>%
  
  ## Determine % change and classify as large increase/decrease
  mutate(ntl_pchange = (ntl_after - ntl_before) / ntl_before * 100) %>%
  
  dplyr::mutate(change_type = case_when(
    ntl_pchange >= 10 ~ "> 10% Increase",
    ntl_pchange <= -10 ~ "> 10% Decrease",
    TRUE ~ "Small change"
  )) %>%
  
  ## Merge in earthquake data and determine max intensity
  left_join(eq_df, by = "pcode") %>%
  mutate(mi_max = pmax(mmi_feb06_6p3, mmi_feb06_6p7, mmi_feb06_7p5, mmi_feb20_6p3, 
                       mmi_feb06_7p8, mmi_feb06_6p0)) 

## Merge in percent change data to ADM2 spatial file
adm2_sf <- adm2_sf %>%
  left_join(ntl_sum_df, by = "pcode")

## Deal with outliers
adm2_sf$ntl_pchange[adm2_sf$ntl_pchange > 50] <- 50

# [Map] % Change ---------------------------------------------------------------
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

# [Map] 10% Increase/Decrease --------------------------------------------------
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

# Trends of ADM2 with large increase/decrease ----------------------------------
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
