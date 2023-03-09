# ADM2 Map

# Load data --------------------------------------------------------------------
adm2_sf <- readOGR(dsn = file.path(adm_dir, "tur_polbna_adm2.shp")) %>% st_as_sf()
ntl_df <- readRDS(file.path(ntl_bm_dir, "FinalData", "aggregated", "adm2_VNP46A2.Rds"))
eq_df  <- read_csv(file.path(eq_usgs_dir, "turkiye_admn2_earthquake_intensity_max.csv"))

# Categorize ADMs --------------------------------------------------------------
ntl_sum_df <- ntl_df %>%
  dplyr::mutate(period = case_when(
    date %in% ymd("2022-01-23"):ymd("2022-02-05") ~ "wk2_before",
    date %in% ymd("2022-02-07"):ymd("2022-02-20") ~ "wk2_after"
  )) %>%
  dplyr::filter(!is.na(period)) %>%
  group_by(pcode, period) %>%
  dplyr::summarise(ntl_bm_mean = mean(ntl_bm_mean)) %>%
  pivot_wider(id_cols = pcode, names_from = period, values_from = ntl_bm_mean) %>%
  mutate(pchange = (wk2_after - wk2_before) / wk2_before) %>%
  left_join(eq_df, by = "pcode") %>%
  mutate(mak=pmax(Sepal.Width,Petal.Length, Petal.Width))

# Map --------------------------------------------------------------------------
adm2_sf <- adm2_sf %>%
  left_join(ntl_sum_df, by = "pcode")

ggplot() +
  geom_sf(data = adm2_sf,
          aes(fill = pchange))







# Annual map -------------------------------------------------------------------
year_i <- 2021
for(year_i in 2012:2021){
  r <- raster(file.path(ntl_bm_dir, "FinalData", "VNP46A4_rasters", paste0("bm_VNP46A4_",year_i,".tif")))
  
  #### Prep data
  r <- r %>% crop(adm0_sf) %>% mask(adm0_sf) 
  
  r_df <- rasterToPoints(r, spatial = TRUE) %>% as.data.frame()
  names(r_df) <- c("value", "x", "y")
  
  ## Remove very low values of NTL; can be considered noise 
  r_df$value[r_df$value <= 2] <- 0
  
  ## Distribution is skewed, so log
  r_df$value_adj <- log(r_df$value+1)
  
  ##### Map 
  p <- ggplot() +
    geom_raster(data = r_df, 
                aes(x = x, y = y, 
                    fill = value_adj)) +
    scale_fill_gradient2(low = "black",
                         mid = "yellow",
                         high = "red",
                         midpoint = 4.5) +
    labs(title = paste0("Nighttime Lights ", year_i)) +
    coord_quickmap() + 
    theme_void() +
    theme(plot.title = element_text(face = "bold", hjust = 0.5),
          legend.position = "none")
  
  ggsave(p, filename = file.path(fig_dir, paste0("tur_ntl_bm_",year_i,".png")),
         height = 3, width = 5)
}
