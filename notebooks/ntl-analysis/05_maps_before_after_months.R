# Maps
ihs <- function(x) {
  y <- log(x + sqrt(x ^ 2 + 1))
  return(y)
}

# Load ADM0 --------------------------------------------------------------------
adm0_sp <- readOGR(dsn = file.path(adm_dir, "tur_polbnda_adm0.shp")) 

mi_sp <- readOGR(dsn = file.path(eq_usgs_dir, "USGS Raw Data", "ShakeMap 06 Feb 7.5", "mi.shp"))

# Difference map ---------------------------------------------------------------
b_r <- file.path(ntl_bm_dir, "FinalData", "VNP46A3_rasters", "bm_VNP46A3_2023_01.tif") %>%
  raster()

a_r <- file.path(ntl_bm_dir, "FinalData", "VNP46A3_rasters", "bm_VNP46A3_2023_02.tif") %>%
  raster()

d_r   <- a_r
d_r[] <- a_r[] - b_r[]

THRSH <- 4
d_r[][abs(d_r[]) < THRSH] <- 0
d_r[][d_r[] >= THRSH]     <- 1
d_r[][d_r[] <= -THRSH]    <- -1
d_r[][a_r[] <= THRSH] <- NA

r_df <- rasterToPoints(d_r, spatial = TRUE) %>% as.data.frame()
names(r_df) <- c("value", "x", "y")

r_df <- r_df %>%
  dplyr::mutate(value_name = case_when(
    value == -1 ~ "Decrease",
    value == 0 ~ "No Change",
    value == 1 ~ "Increase"
  ))

mi_sp$v_alpha <- mi_sp$PARAMVALUE^2/max(mi_sp$PARAMVALUE^2)*0.8

mi_sf <- mi_sp %>% st_as_sf()

p <- ggplot() +
  geom_raster(data = r_df, 
              aes(x = x, y = y, 
                  fill = value_name)) +
  geom_sf(data = mi_sf[mi_sf$PARAMVALUE >= 4,],
          fill = "gray20",
          alpha = mi_sf$v_alpha[mi_sf$PARAMVALUE >= 4],
          color = NA) +
  geom_polygon(data = adm0_sp,
               aes(x = long, y = lat, group = group),
               fill = NA,
               color = "black",
               size = 0.1) +
  scale_fill_manual(values = c("firebrick1", 
                               "forestgreen",
                               "lightblue2")) +
  scale_color_manual(values = c("darkorange")) +
  #scale_alpha_manual(values = 0.1) +
  #scale_alpha_continuous(range = c(0.1, 1)) +
  labs(fill = "Nighttime\nLights\nChange",
       title = "Change in Nighttime Lights",
       subtitle = "Earthquake Intensity in Shades of Black (MI > 3)") +
  theme_void() +
  coord_sf()

ggsave(p, filename = file.path(fig_dir, "ntl_change_jan_feb.png"),
       height = 3.5, width = 5)

