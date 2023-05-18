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
ntl_df <- readRDS(file.path(ntl_bm_dir, "FinalData", "aggregated", "adm2_VNP46A2.Rds"))

## Earthquake intensity data
eq_df <- read_csv(file.path(eq_usgs_dir, "turkiye_admn2_earthquake_intensity_max.csv"))

# Prep data --------------------------------------------------------------------
ntl_sum_df <- ntl_df %>%

  group_by(pcode) %>%
  summarise(ntl_base = mean(ntl_bm_mean[date %in% ymd("2023-01-23"):ymd("2023-02-05")]),
            ntl_3day = mean(ntl_bm_mean[date %in% ymd("2023-02-07"):ymd("2023-02-09")]),
            ntl_2week = mean(ntl_bm_mean[date %in% ymd("2023-02-07"):ymd("2023-02-20")]),
            ntl_march = mean(ntl_bm_mean[date %in% ymd("2023-03-01"):ymd("2023-03-31")])) %>%
  ungroup() %>%
  mutate(ntl_3day_pc = (ntl_3day - ntl_base)/ntl_base * 100,
         ntl_2week_pc = (ntl_2week - ntl_base)/ntl_base * 100,
         ntl_march_pc = (ntl_march - ntl_base)/ntl_base * 100) %>%
  
  dplyr::mutate(ntl_3day_chng_bin = case_when(
    ntl_3day_pc >= 10 ~ "> 10% Increase",
    ntl_3day_pc <= -10 ~ "> 10% Decrease",
    TRUE ~ "Small change"
  )) %>%
  
  dplyr::mutate(ntl_2week_chng_bin = case_when(
    ntl_2week_pc >= 10 ~ "> 10% Increase",
    ntl_2week_pc <= -10 ~ "> 10% Decrease",
    TRUE ~ "Small change"
  )) %>%
  
  dplyr::mutate(ntl_march_chng_bin = case_when(
    ntl_march_pc >= 10 ~ "> 10% Increase",
    ntl_march_pc <= -10 ~ "> 10% Decrease",
    TRUE ~ "Small change"
  )) %>%
  

  ## Merge in earthquake data and determine max intensity
  left_join(eq_df, by = "pcode") %>%
  mutate(mi_max = pmax(mmi_feb06_6p3, mmi_feb06_6p7,
                       mmi_feb06_7p5, mmi_feb20_6p3,
                       mmi_feb06_7p8, mmi_feb06_6p0))

## Merge in percent change data to ADM2 spatial file
adm2_sf <- adm2_sf %>%
  left_join(ntl_sum_df, by = "pcode")

## Deal with outliers

adm2_sf$ntl_march_pc[adm2_sf$ntl_march_pc > 50] <- 50
adm2_sf$ntl_2week_pc[adm2_sf$ntl_2week_pc > 50] <- 50
adm2_sf$ntl_3day_pc[adm2_sf$ntl_3day_pc > 50] <- 50

# [Map] % Change ---------------------------------------------------------------

for(var in c("ntl_2week", "ntl_march", "ntl_3day")){
  
  adm2_sf$var_pc       <- adm2_sf[[paste0(var, "_pc")]]
  adm2_sf$var_chng_bin <- adm2_sf[[paste0(var, "_chng_bin")]]
  
  if(var == "ntl_3day") subtitle <- "Change from 2 Weeks Before Earthquake to 3 Days After Earthquake"
  if(var == "ntl_2week") subtitle <- "Change from 2 Weeks Before Earthquake to 2 Weeks After Earthquake"
  if(var == "ntl_march") subtitle <- "Change from 2 Weeks Before Earthquake to March"
  
  #### % Change
  p <- ggplot() +
    geom_sf(data = adm0_sf,
            fill = "gray50") +
    geom_sf(data = adm2_sf[adm2_sf$mi_max >= 5,],
            aes(fill = var_pc)) +
    geom_sf(data = adm2_sf[adm2_sf$mi_max >= 6,] %>% st_union(),
            color = "black",
            size = 0.75,
            fill = NA) +
    theme_void() +
    theme(plot.title = element_text(face = "bold", hjust = 0.5),
          plot.subtitle = element_text(face = "bold", hjust = 0.5)) +
    labs(fill = "Change in\nNighttime\nLights",
         title = "Percent Change in Nighttime Lights",
         subtitle = subtitle) +
    scale_fill_gradient2(low = "red",
                         mid = "white",
                         high = "forestgreen",
                         midpoint = 0,
                         limits = c(-50, 50))
  
  ggsave(p, filename = file.path(fig_dir, paste0("ntl_adm2_map_",var,"_pc.png")),
         height = 6, width = 10)
  
  ## Change Bin
  p <- ggplot() +
    geom_sf(data = adm0_sf,
            fill = "gray50") +
    geom_sf(data = adm2_sf[adm2_sf$mi_max >= 5,],
            aes(fill = factor(var_chng_bin))) +
    geom_sf(data = adm2_sf[adm2_sf$mi_max >= 6,] %>% st_union(),
            color = "black",
            size = 0.75,
            fill = NA) +
    theme_void() +
    theme(plot.title = element_text(face = "bold", hjust = 0.5),
          plot.subtitle = element_text(face = "bold", hjust = 0.5)) +
    labs(fill = "Change in\nNighttime\nLights",
         title = "Change in Nighttime Lights",
         subtitle = subtitle) +
    scale_fill_manual(values = c("dodgerblue", "darkorange", "gray"))
  
  ggsave(p, filename = file.path(fig_dir, paste0("ntl_adm2_map_",var,"_chng_bin.png")),
         height = 6, width = 10)
  
}


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

