# Nighttime Lights

Nighttime lights have become a commonly used resource to estimate changes in local economic activity. This section shows changes in nighttime lights in Turkiye from before and after the earthquake.

## Data

We use nighttime lights data from the VIIRS Black Marble dataset. Raw nighttime lights data requires correction due to cloud cover and stray light, such as lunar light. The Black Marble dataset applies advanced algorithms to correct raw nighttime light values and calibrate data so that trends in lights over time can be meaningfully analyzed. We use daily and monthly data from VIIRS Black Marble.

## Methodology

We extract average nighttime lights within each administrative unit in Turkiye. We distinguish lights between lights observed in gas flaring locations and lights in other locations. Oil extraction and production involves gas flaring, which produces significant volumes of light. Separately examining lights in gas flaring and other locations allows distinguishing between lights generated due to oil production versus other sources of human activity. We use data on the locations of gas flaring sites from the [Global Gas Flaring Reduction Partnership](https://www.worldbank.org/en/programs/gasflaringreduction); we remove lights within 5km of gas flaring sites.

## Implementation

Code to replicate the analysis can be found [here](https://github.com/datapartnership/turkiye-earthquake-impact/tree/ntl/notebooks/nighttime-lights). 

The code largely relies on an R package (`blackmarbler`) that is currently being created to faciliate downloading and processing Black Marble nighttime lights data. The package [documentation](https://ramarty.github.io/blackmarbler/) provides some generic examples for how to download data, make a map of nighttime lights, and show trends in nighttime lights. The below code leverages the package to produce analytics for Turkiye. 

The main script ([_main.R](https://github.com/datapartnership/turkiye-earthquake-impact/tree/main/notebooks/nighttime-lights/_main.R)) loads all packages and runs all scripts for the analysis. There are separate scripts for processing the data (e.g., [downloading and cleaning Black Marble data](https://github.com/datapartnership/turkiye-earthquake-impact/tree/main/notebooks/nighttime-lights/02_download_black_marble.R)). The scripts download rasters of nighttime lights, then create datasets of average nighttime lights within different units (e.g., administrative level 2 dataset). The following code generates figures and analysis of the data:

* [05_map_ntl_annual.R](https://github.com/datapartnership/turkiye-earthquake-impact/tree/main/notebooks/nighttime-lights/05_map_ntl_annual.R): Produce annual maps of nighttime lights
* [05_maps_ntl_changes.R](https://github.com/datapartnership/turkiye-earthquake-impact/tree/main/notebooks/nighttime-lights/05_maps_ntl_changes.R): Produce maps of changes in nighttime lights from before and after the earthquake.
* [05_ntl_trends_daily.R](https://github.com/datapartnership/turkiye-earthquake-impact/tree/main/notebooks/nighttime-lights/05_ntl_trends_daily.R): Produce daily trends in daily nighttime lights for each administrative unit. Administrative units are group by earthquake intensity.
* [05_ntl_trends_monthly.R](https://github.com/datapartnership/turkiye-earthquake-impact/tree/main/notebooks/nighttime-lights/05_ntl_trends_monthly.R): Produce daily trends in daily nighttime lights for each administrative unit. Administrative units are group by earthquake intensity.
* [05_avg_ntl_by_period.R](https://github.com/datapartnership/turkiye-earthquake-impact/tree/main/notebooks/nighttime-lights/05_avg_ntl_by_period.R): Create a dataset of average nighttime lights for each administrative unit for different time periods.

The data for the analysis can be accessed from:

* [Gas Flaring Location Data](https://datacatalog.worldbank.org/search/dataset/0037743)

* __Black Marble Nighttime Lights:__ There are two options to access the data:

  * The code [here](https://github.com/datapartnership/syria-economic-monitor/blob/main/notebooks/ntl-analysis/01_download_black_marble.R) downloads raw data from the [NASA archive](https://ladsweb.modaps.eosdis.nasa.gov/missions-and-measurements/products/VNP46A3/) and processes the data for Turkiye---mosaicing raster tiles together to cover Turkiye. Running the code requires a NASA bearer token; the documentation [here](https://github.com/ramarty/blackmarbler) describes how to obtain a token.

  * Pre-processed data can be downloaded from [here](URL), using the __Night Time Lights BlackMarble Data__

## Findings

### Map of Nighttime Lights

The below figure shows nighttime lights from the latest year available. As expected, Turkiye’s largest cities are the most brightly lit – such as Instanbul in the north west.

[This script](https://github.com/datapartnership/turkiye-earthquake-impact/tree/main/notebooks/nighttime-lights/05_map_ntl_annual.R) produces the below figure, where the relevant code is also documented below. Befor running the below code, the code from [here](https://github.com/datapartnership/turkiye-earthquake-impact/blob/ntl/notebooks/nighttime-lights/_main.R) needs to be run to load packages and define file paths.

```{r}
#### Load Turkiye polygon
adm2_sf <- read_sf(dsn = file.path(adm_dir, "tur_polbna_adm2.shp")) 

#### Load and prep NTL raster
## Load raster
r <- raster(file.path(ntl_bm_dir, "FinalData", "VNP46A4_rasters", "VNP46A4_t2021.tif")

## Crop/mask to Turkiye polygon
r <- r %>% crop(adm2_sf) %>% mask(adm2_sf) 

## Convert to dataframe for plotting with ggplot
r_df <- rasterToPoints(r, spatial = TRUE) %>% as.data.frame()
names(r_df) <- c("value", "x", "y")

## Remove very low values of NTL; can be considered noise 
r_df$value[r_df$value <= 2] <- 0

## Distribution is skewed, so log
r_df$value_adj <- log(r_df$value+1)

#### Make map
ggplot() +
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
```

```{figure} ../../reports/figures/tur_ntl_bm_2021.png
---
scale: 50%
align: center
---
Nighttime lights in 2021
```

### Changes in Nighttime Lights

The below figures show the change in nighttime lights from the two weeks before the earthquake (February 6, 2023) to two weeks after the earthquake. The figures show that many locations saw an increase in nighttime lights immediately after the earthquake. Increases in nighttime lights could result from lights generated from rescue efforts.

[This script](https://github.com/datapartnership/turkiye-earthquake-impact/tree/main/notebooks/nighttime-lights/05_maps_ntl_changes.R) produces the below two figures, where the relevant code is also documented below. The code relies on daily nighttime lights data that has been aggregated to the ADM2 level; this dataset is produced using [this script](https://github.com/datapartnership/turkiye-earthquake-impact/blob/ntl/notebooks/nighttime-lights/05_maps_ntl_changes.R). Befor running the below code, the code from [here](https://github.com/datapartnership/turkiye-earthquake-impact/blob/ntl/notebooks/nighttime-lights/_main.R) needs to be run to load packages and define file paths.

```{r}
#### Load data
## Daily NTL at ADM2
ntl_df <- readRDS(file.path(ntl_bm_dir, "FinalData", "aggregated", "adm2_VNP46A2.Rds"))

## Earthquake intensity data
eq_df <- read_csv(file.path(eq_usgs_dir, "turkiye_admn2_earthquake_intensity_max.csv"))

#### Prep data
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
  mutate(mi_max = pmax(mmi_feb06_6p3, mmi_feb06_6p7, 
                       mmi_feb06_7p5, mmi_feb20_6p3, 
                       mmi_feb06_7p8, mmi_feb06_6p0)) 

## Merge in percent change data to ADM2 spatial file
adm2_sf <- adm2_sf %>%
  left_join(ntl_sum_df, by = "pcode")

## Deal with outliers
adm2_sf$ntl_pchange[adm2_sf$ntl_pchange > 50] <- 50

#### Make map of % changes
ggplot() +
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
                       
#### Make map of ADM2s with >10% increase/decrease
ggplot() +
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
```

```{figure} ../../reports/figures/ntl_adm2_map_raw.png
---
align: center
---
Change in nighttime lights from two weeks before the earthquake (February 6, 2023) to two weeks after the earthquake. The figure shows administrative units where the earthquake had a 5 or more magnitude; the black line outlines administrative units where there was a magnitude of 6 or more.
```

```{figure} ../../reports/figures/ntl_adm2_map_cat.png
---
align: center
---
Change in nighttime lights from two weeks before the earthquake (February 6, 2023) to two weeks after the earthquake. The figure shows administrative units where the earthquake had a 5 or more magnitude; the black line outlines administrative units where there was a magnitude of 6 or more.
```

### Trends in Nighttime Lights

The below figure shows daily trends in nighttime lights for administrative units where there was the largest earthquake intensity (a magnitude of 9 or higher). In most locations, nighttime lights remains relatively unchanged. However, Antakya---which had the largest nighttime lights---saw a sharp reduction in nighttime lights.

[This script](https://github.com/datapartnership/turkiye-earthquake-impact/blob/ntl/notebooks/nighttime-lights/05_ntl_trends_daily.R) produces the below figure, where the relevant code is also documented below. The code relies on daily nighttime lights data that has been aggregated to the ADM2 level; this dataset is produced using [this script](https://github.com/datapartnership/turkiye-earthquake-impact/blob/ntl/notebooks/nighttime-lights/05_maps_ntl_changes.R). Before running the below code, the code from [here](https://github.com/datapartnership/turkiye-earthquake-impact/blob/ntl/notebooks/nighttime-lights/_main.R) needs to be run to load packages and define file paths.

```{r}
#### Load and prepare data
## Daily NTL at ADM2 Level
ntl_df <- readRDS(file.path(ntl_bm_dir, "FinalData", "aggregated", "adm2_VNP46A2.Rds"))
eq_df <- read_csv(file.path(eq_usgs_dir, "turkiye_admn2_earthquake_intensity_max.csv"))

## Merge data
df <- ntl_df %>%
  left_join(eq_df, by = "pcode")
  
  
#### Make figure
df %>%
    dplyr::filter(date >= ymd("2023-01-01"),
                  floor(mmi_feb06_7p8) == 9) %>%
    ggplot() +
    geom_col(aes(x = date, y = ntl_bm_mean)) +
    geom_vline(xintercept = ymd("2023-02-06"),
               color = "red") +
    labs(x = "Date", y = "NTL",
         title = "Trends in Nighttime Lights Across ADM2",
         subtitle = paste0("MI: ", mi)) +
    facet_wrap(~adm2_en,
               scales = "free_y") 
```

```{figure} ../../reports/figures/ntl_trends_daily_adm2_mi9.png
---
align: center
---
Trends in nighttime lights for administrative units where there was the largest earthquake intensity (a magnitude of 9 or higher)
```

## Limitations

Nighttime lights are a common data source for measuring local economic activity. However, it is a proxy that is strongly—although imperfectly—correlated with measures of interest, such as population, local GDP, and wealth. Consequently, care must be taken in interpreting reasons for changes in lights.

Caution should also be taken when making conclusions of earthquake impacts based on nighttime lights. Changes in nighttime lights could be driven by multiple factors---such as rescue efforts generating lights, to damages and people leaving high-hit areas causing a reduction in nighttime lights.

## Next Steps

Next steps can focus on continuing to monitor trends in nighttime lights over time. In particular, it will be useful to examine changes in nighttime lights in the weeks and months after the earthquake---when rescue efforts and the lights they generated are done. Consequently, any persistent changes in nighttime lights observed in the weeks and months after the earthquake would be indicative of damages or people moving away. Analysis of data from other sources could shed insight to whether any reductions in nighttime lights are due to damanges or people moving awawy.
