# Nighttime Lights

Nighttime lights have become a commonly used resource to estimate changes in local economic activity. This section shows changes in nighttime lights in Turkiye from before and after the earthquake.

## Data

We use nighttime lights data from the VIIRS Black Marble dataset. Raw nighttime lights data requires correction due to cloud cover and stray light, such as lunar light. The Black Marble dataset applies advanced algorithms to correct raw nighttime light values and calibrate data so that trends in lights over time can be meaningfully analyzed. We use daily and monthly data from VIIRS Black Marble.

For further information, please refer to {ref}`foundational_datasets`.

## Methodology

We extract average nighttime lights within each administrative unit in Turkiye. We distinguish lights between lights observed in gas flaring locations and lights in other locations. Oil extraction and production involves gas flaring, which produces significant volumes of light. Separately examining lights in gas flaring and other locations allows distinguishing between lights generated due to oil production versus other sources of human activity. We use data on the locations of gas flaring sites from the [Global Gas Flaring Reduction Partnership](https://www.worldbank.org/en/programs/gasflaringreduction); we remove lights within 5km of gas flaring sites.

## Implementation

Code to replicate the analysis can be found [here](https://github.com/datapartnership/turkiye-earthquake-impact/tree/ntl/notebooks/nighttime-lights).

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

The below figure shows nighttime lights from the latest year available. As expected, Turkiye’s largest cities are the most brightly lit – such as Instanbul in the north west.

```{figure} ../../reports/figures/tur_ntl_bm_2021.png
---
scale: 50%
align: center
---
Nighttime lights in 2021
```

The below figures show the change in nighttime lights from the two weeks before the earthquake (February 6, 2023) to two weeks after the earthquake. The figures show that many locations saw an increase in nighttime lights immediately after the earthquake. Increases in nighttime lights could result from lights generated from rescue efforts.

```{figure} ../../reports/figures/ntl_adm2_map_raw.png
---
scale: 75%
align: center
---
Change in nighttime lights from two weeks before the earthquake (February 6, 2023) to two weeks after the earthquake. The figure shows administrative units where the earthquake had a 5 or more magnitude; the black line outlines administrative units where there was a magnitude of 6 or more.
```

```{figure} ../../reports/figures/ntl_adm2_map_cat.png
---
scale: 75%
align: center
---
Change in nighttime lights from two weeks before the earthquake (February 6, 2023) to two weeks after the earthquake. The figure shows administrative units where the earthquake had a 5 or more magnitude; the black line outlines administrative units where there was a magnitude of 6 or more.
```

The below figure shows daily trends in nighttime lights for administrative units where there was the largest earthquake intensity (a magnitude of 9 or higher). In most locations, nighttime lights remains relatively unchanged. However, Antakya---which had the largest nighttime lights---saw a sharp reduction in nighttime lights.

```{figure} ../../reports/figures/ntl_trends_daily_adm2_mi9.png
---
scale: 75%
align: center
---
Trends in nighttime lights for administrative units where there was the largest earthquake intensity (a magnitude of 9 or higher)
```

## Limitations

Nighttime lights are a common data source for measuring local economic activity. However, it is a proxy that is strongly—although imperfectly—correlated with measures of interest, such as population, local GDP, and wealth. Consequently, care must be taken in interpreting reasons for changes in lights.

Caution should also be taken when making conclusions of earthquake impacts based on nighttime lights. Changes in nighttime lights could be driven by multiple factors---such as rescue efforts generating lights, to damages and people leaving high-hit areas causing a reduction in nighttime lights. 

## Next Steps

Next steps can focus on continuing to monitor trends in nighttime lights over time. In particular, it will be useful to examine changes in nighttime lights in the weeks and months after the earthquake---when rescue efforts and the lights they generated are done. Consequently, any persistent changes in nighttime lights observed in the weeks and months after the earthquake would be indicative of damages or people moving away. Analysis of data from other sources could shed insight to whether any reductions in nighttime lights are due to damanges or people moving awawy. 

