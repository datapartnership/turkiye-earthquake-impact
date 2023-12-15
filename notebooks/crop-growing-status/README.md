# Monitoring crop growing status

In Türkiye, a country with diverse climatic zones ranging from Mediterranean to continental climates, monitoring crop growth is crucial. The nation's varied topography, including coastal plains, high mountains, and fertile plateaus, greatly influences its agricultural practices. Regular observation of crop growth in Türkiye is vital for informed agricultural management, adaptation to environmental changes, and understanding the impact of climatic diversity on agriculture [^1][^2]. This monitoring is key to sustaining Türkiye's rich biodiversity, supporting its agricultural economy, which is a significant contributor to the national GDP, and managing land resources effectively.

![Boundary](./images/tur_bnd_administrative.png)

**Figure 1.** Administrative boundary.

Remote sensing techniques are integral to vegetation monitoring in Türkiye. Tools like the Moderate Resolution Imaging Spectroradiometer ([MODIS](https://modis.gsfc.nasa.gov/about/)) Terra ([MOD13Q1](https://lpdaac.usgs.gov/products/mod13q1v061/)) and Aqua ([MYD13Q1](https://lpdaac.usgs.gov/products/myd13q1v061/)) Vegetation Indices 16-day L3 Global 250m time series data are indispensable for comprehensive analysis of vegetation conditions. Variables such as standardized anomaly and vegetation condition index, derived from these tools, enable quantification of vegetation changes over time and across Türkiye's different agricultural regions [^3][^4][^5].

Consistent monitoring of crop growth in Türkiye brings numerous benefits. It enables the early identification and management of agricultural challenges like land degradation and pests, as well as tracking of crop health, crucial for informed decision-making in agriculture [^6]. This process assists policymakers in developing strategies and environmental policies tailored to Türkiye's unique agricultural landscape, promoting sustainable practices and food security [^6][^7].

Agriculture is an essential sector in Türkiye, contributing significantly to the economy and providing food security. Understanding crop growth patterns through phenological analysis with data from sources like MODIS MOD13Q1 and MYD13Q1 is critical. Such insights are vital for improving agricultural management, optimizing resource distribution, and enhancing the resilience of the agricultural sector against climate change and other environmental factors [^8][^9][^10].

To achieve detailed phenological analysis, the [TIMESAT](https://web.nateko.lu.se/timesat/timesat.asp) software is utilized for time series data analysis, extracting vital phenological parameters like Start of Season (SOS) and End of Season (EOS) from Vegetation Index (VI) data. Focusing this analysis on Türkiye's diverse crop-growing regions ensures the relevance and applicability of the insights to the local agricultural conditions [^11][^12][^13][^14][^15].

This comprehensive phenological data is instrumental for Turkish farmers and agricultural stakeholders in making informed decisions about critical farming activities such as planting, irrigation, and harvesting. It also aids in anticipating and addressing potential risks to crop health and yield, contributing to the sustainability and productivity of Türkiye’s agricultural sector.

## Data

In this exercise, we utilize various high-quality datasets to analyze vegetation conditions and phenology within Türkiye's cropland areas. The Data section introduces the sources of information used, setting the stage for the methodologies and results discussed later in the exercise. Our analysis incorporates VI data from the MOD13Q1 and MYD13Q1 products, and the cropland extent is identified using relevant datasets that reflect Türkiye's agricultural landscape, enhancing our understanding of the factors influencing agricultural productivity and sustainability in the country.

### Crop extent

Agriculture is a vital part of Türkiye's economy, with significant portions (24.42%) of land dedicated to diverse types of cultivation, ranging from cereal crops to fruit orchards and vegetables. 

![WorldCover](./images/tur_worldcover.png)

**Figure 2.** Land cover.

Effective monitoring and management of these croplands are paramount to ensure maximum productivity and sustainable practices. Focused attention on these areas is essential for optimizing land utilization, contributing significantly to national food security and the agricultural economy. Such dedicated management is key to maintaining a balance between achieving high agricultural yields and preserving Türkiye's natural ecosystems and biodiversity.

![Cropland](./images/tur_phy_cropland.png)

**Figure 3.** Cropland

We used the new [ESA World Cover](https://esa-worldcover.org/en) map 10m LULC to mask out areas which aren't of interest in computing the EVI, i.e. built-up, water, forest, etc. The cropland class has value equal to 40, which will be used within Google Earth Engine ([GEE](https://earthengine.google.com/)) to generate the mask [^16]. 

There are many ways to download the WorldCover, as explained in the WorldCover [Data Access](https://esa-worldcover.org/en/data-access) page.

### Vegetation Indices

The EVI from both MOD13Q1 [^17] and MYD13Q1 [^18] downloaded using GEE which involves some process:

 * Combine the two 16-day composites into a synthethic 8-day composite containing data from both Aqua and Terra.

 * Applying Quality Control Bitmask, keep only pixels with good quality.

 * Applying cropland mask, keep only pixels identified as a cropland based on ESA WorldCover.

 * Clipped for Lebanon and batch export the collection to Google Drive.

![VI](./images/tur_evi_202310.png)

**Figure 4.** Vegetation indices, October 2023.

### Climate

Understanding the dynamics of crop growth and development in Lebanon requires a comprehensive approach that includes the analysis of climate data. Monthly temperature and rainfall patterns are pivotal factors influencing agricultural cycles. By integrating time-series data of these climate parameters into our analysis, we can gain deeper insights into how environmental conditions affect crop growth [^19][^20].

Temperature and rainfall are key drivers of phenological stages such as germination, flowering, and maturation. For instance, variations in monthly temperatures can significantly impact the growth rate and health of crops [^21]. Warmer temperatures may accelerate growth in certain crops but can also increase evapotranspiration and water demand. On the other hand, cooler temperatures might slow down growth or even damage sensitive crops.

![Temperature](./images/tur_cli_temperature_202310.png)

**Figure 5.** Mean temperature, October 2023.

Similarly, rainfall patterns play a crucial role in determining water availability for crops. Adequate rainfall is essential for crop survival and productivity, but excessive or insufficient rainfall can lead to adverse conditions like flooding or drought, respectively [8].

![Rainfall](./images/tur_cli_rainfall_202310.png)

**Figure 6.** Accumulated rainfall, October 2023.

By analyzing these climate data alongside vegetation indices and phenological information, we can correlate climate trends with vegetation dynamics. 

Monthly temperature derived from [ERA5-Land](https://confluence.ecmwf.int/display/CKB/ERA5-Land+data+documentation)[^22], and rainfall data come from [CHRIPS](https://www.chc.ucsb.edu/data/chirps)[^23].

## Limitations and Assumptions

Getting VI data with good quality for all period are challenging (pixels covered with cloud, snow/ice, aerosol quantity, shadow) for optic data (MODIS). Cultivated area year by year are varies, due to MODIS data quality and crop type is not described, so the seasonal parameters are for general cropland. 

At this point, the analysis is also limited to seasonal crops due to difficulty to capture the dynamics of perennial crops within a year. The value may not represent for smaller cropland and presented result are only based upon the most current available remote sensing data. As the climate phenomena is a dynamic situation, the current realities may differ from what is depicted in this document.

Ground check is necessary to ensure if satellite and field situation data are corresponding.

## General approach

We present a summary of the key derived variables employed in our analysis to monitor vegetation conditions and crop growing stages within Lebanon's cropland areas. These variables, which are derived from the EVI data and the cropland extent, enable a comprehensive understanding of the factors influencing agricultural productivity and environmental sustainability in the region.

### Vegetation-derived anomaly

We focuses on analyzing various EVI derived products, such as the standardized anomaly and Vegetation Condition Index (VCI). These derived products provide valuable insights into vegetation health, vigor, and responses to environmental factors like climate change and land-use practices. By examining the EVI-derived products, we can assess vegetation dynamics and identify patterns and trends that may impact ecosystems and human livelihoods [^24][^25].

**Standardized Anomaly**

The standardized anomaly is a dimensionless measure that accounts for variations in the mean and standard deviation of the time series data, allowing for a more robust comparison of anomalies across different regions or time periods. This variable can help identify abnormal vegetation conditions that may warrant further analysis or management action.

The anomaly is calculated based on difference from the average and standard deviation

`"anomaly (%)" = ("evi" - "mean_evi") / "std_evi"`

where `evi` is current EVI and `mean_evi` and `std_evi` is the long-term average and standard deviation of EVI.

**Vegetation Condition Index (VCI)**

The Vegetation Condition Index (VCI) is a normalized index calculated from the Enhanced Vegetation Index (EVI) data, which ranges from 0 to 100, with higher values indicating better vegetation health. By providing a concise measure of the overall vegetation condition, the VCI enables the identification of trends and patterns in vegetation dynamics and the evaluation of the effectiveness of management interventions [^26].

To calculate the VCI, the current EVI value is compared to its long-term minimum and maximum values using the following equation:

`"vci" = 100 * ("evi" - "min_evi") / ("max_evi" - "min_evi")`

where `evi` is current EVI and `min_evi` and `max_evi` is the long-term minimum and maximum of EVI.

### Phenological Metrics

A working example to detect seasonality parameters in Lebanon has been developed based on areas where the majority is a cropland. This approach requires a crop type mask and moderate resolution time series Vegetation Indices (VI). 

State of planting and harvesting estimates are determined by importing Vegetation Indices (VI) data into TIMESAT – an open-source program to analyze time-series satellite sensor data. TIMESAT conducts pixel-by-pixel classification of satellite images to determine whether planting has started or not. This process is followed for all areas over multiple years to evaluate current planting vis-à-vis historical values from 2003 - 2023.

![TIMESAT](./images/tur_timesat_parameters.png)

**Figure 7.** TIMESAT Parameters

The main seasonality parameters generated in TIMESAT are (a) beginning of season, (b) end of season, (c) length of season, (d) base value, (e) time of middle of season, (f) maximum value, (g) amplitude, (h) small integrated value, (h+i) large integrated value. The blue line in Figure 11 shows the raw EVI time series, while the red line shows the EVI values after applying a Savitsky-Golay smoothing algorithm. The phenological parameters detected describe key aspects of the timing of agricultural production and are closely related to the amount of available biomass.

The image below shows a fluctuating trend in the Vegetation Index over time. Green and red dots are used to mark the start and end of the growing seasons, respectively which can be useful for understanding patterns in vegetation growth.

![GS1](./images/tur_crop_growing_stages1.png)

**Figure 8.** Fluctuating trend in the VI values over time

The next image is a heatmap that provides a visual representation of the Vegetation Index (VI) values over time and still related with above image. Each cell in the heatmap corresponds to a specific date, and the color of the cell represents the VI value on that date, with lighter colors indicating lower VI values and darker colors indicating higher VI values. This heatmap, along with the line graph, can be used to monitor the growing stages of cropland. By comparing the two images, one can observe how the VI values change over time and identify the start and end of the growing seasons. This information can be crucial for farmers and agricultural scientists for planning and optimizing crop growth. 

![GS2](./images/tur_crop_growing_stages2.png)

**Figure 9.** Heatmap that provides a visual representation of the VI values over time

The Start of Season (SOS) and End of Season (EOS) are typically derived from VI data. These metrics are calculated using various methods that identify critical points or thresholds in the vegetation index time series data. One common approach is the Timesat software, which fits functions (e.g., logistic, asymmetric Gaussian, Savitsky-Golay, Whittaker) to the time series data to identify these points. Here's a general overview of the approach:

1. **Preprocessing:** Detrend and smooth the vegetation index time series data to reduce noise.

2. **Model Fitting:** Fit a function (e.g., logistic, asymmetric Gaussian) to the smoothed time series data. The chosen function should adequately represent the seasonal pattern of vegetation growth and senescence.

3. **Threshold Determination:** Define thresholds for SOS and EOS. These thresholds may be absolute values, or they may be based on a percentage of the maximum vegetation index value for the season (e.g., 20% for SOS and EOS).

4. **Metric Calculation:** Identify the points in the fitted function where the thresholds are met. These points correspond to the SOS and EOS.

	* **SOS:** The time step where the fitted function first exceeds the lower threshold, marking the start of significant vegetation growth.

	* **EOS:** The time step where the fitted function falls below the lower threshold again, signifying the end of significant vegetation growth.

Note that these metrics will depend on the choice of function, thresholds, and other methodological details. The equations for calculating SOS and EOS may vary depending on the specific technique employed.

## Result

We present a summary of the key derived variables employed in our analysis to monitor vegetation conditions and dynamics within Lebanon's cropland areas. 

### Anomaly and Vegetation Condition

These variables, which are derived from the EVI data and the cropland extent, enable a comprehensive understanding of the factors influencing agricultural productivity and environmental sustainability in the region.

::::{tab-set}
:::{tab-item} Standardized Anomaly, October 2023
![StdAnom1](./images/tur_evi_stdanom_202310.png)

**Figure 10.** Standardized anomaly, October 2023, compared to the reference 2003-2022
:::

:::{tab-item} Standardized Anomaly, Jul-Sep 2023
![StdAnom2](./images/tur_evi_stdanom_jas_2023.png)

**Figure 11.** Standardized anomaly, July-September 2023, compared to the reference 2003-2022
:::

:::{tab-item} Vegetation Condition Index, October 2023
![VCI1](./images/tur_evi_vci_202309.png)

**Figure 12.** Vegetation Condition Index, October 2023, compared to the reference 2003-2022
:::

:::{tab-item} Vegetation Condition Index, Jul-Sep 2023
![VCI2](./images/tur_evi_vci_jas_2023.png)

**Figure 13.** Vegetation Condition Index, July-September 2023, compared to the reference 2003-2022
:::
::::

And below is the vegetation condition for the last 3 quarter.

::::{tab-set}
:::{tab-item} Standardized Anomaly, Q1-Q3 2023
![StdAnom3](./images/tur_evi_stdanom_quarter_2023.png)

**Figure 14.** Standardized anomaly, Q1-Q3, compared to the reference 2003-2022
:::

:::{tab-item} Vegetation Condition Index, Q1-Q3 2023
![VCI3](./images/tur_evi_vci_quarter_2023.png)

**Figure 15.** Vegetation Condition Index, Q1-Q3 2023, compared to the reference 2003-2022
:::
::::

### Crop Growing Stages

In addition to the previously mentioned vegetation indices and derived products, this study also focuses on analyzing key phenological metrics, such as the Start of Season (SOS), Mid of Season (MOS), and End of Season (EOS). These metrics provide essential information on the timing and progression of the growing season, offering valuable insights into plant growth and development. By examining SOS, MOS, and EOS, we can assess the impacts of environmental factors, such as climate change and land-use practices, on vegetation dynamics. Furthermore, understanding these phenological patterns can help inform agricultural management strategies, conservation efforts, and policies for sustainable resource management.

**Start of Season (SOS)**

The SOS is a critical phenological metric that represents the onset of the growing season. By analyzing the timing of SOS, we can gain insights into how environmental factors, such as temperature and precipitation, impact vegetation growth and development. Understanding the SOS is vital for agricultural planning, as it can inform planting and harvesting schedules, irrigation management, and help predict potential yield outcomes.

![SOS1](./images/tur_pheno_sos1_2023.png)

**Figure 16.** Start of Season 1, Jan - Oct 2023

![SOS2](./images/tur_pheno_sos2_2023.png)

**Figure 17.** Start of Season 2, Jan - Oct 2023

**End of Season (EOS)**

The EOS is an important phenological marker signifying the conclusion of the growing season. Investigating the timing of EOS can reveal valuable information about the duration of the growing season and the overall performance of vegetation. EOS trends can help us understand how factors such as temperature, precipitation, and human-induced land-use changes impact ecosystems and their productivity. Information on EOS is also crucial for agricultural management, as it aids in planning harvest schedules and post-harvest activities, and supports the development of informed land management and conservation policies.

![EOS1](./images/tur_pheno_eos1_2023.png)

**Figure 18.** End of Season, Jan - Oct 2023

![EOS2](./images/tur_pheno_eos2_2023.png)

**Figure 19.** End of Season, Jan - Oct 2023

## Supporting Evidence and Visual Insights

This section offers a comprehensive visual exploration of agricultural activities, emphasizing the spatial and temporal dynamics of cultivation in Lebanon. This chapter presents a series of maps and charts that elucidate the extent of cultivated areas in comparison to historical crop extents, as well as the patterns and timelines of crop planting and harvesting on both monthly and annual scales.

Our analysis includes a historical perspective, showcasing the changes in agricultural practices over three distinct periods: 2011-2015, 2016-2020, and 2021-2023. This temporal segmentation allows us to observe trends and shifts in agricultural activities, providing insights into how external factors like climate change, policy shifts, and economic conditions may have influenced farming practices over the last decade.

The visualizations are presented at both the national level and the administrative level 1 (admin1), offering a broad overview as well as more localized insights. While our data extends to admin3 level, allowing for detailed, granular analysis, the focus on higher administrative levels ensures clarity and accessibility in understanding the broader trends and patterns.

Key features of this section include:

1. **Comparative Maps of Cultivation Extent:** These maps compare the actual cultivated areas with the historical extents of crops, highlighting regions of expansion or reduction in agricultural land use.

2. **Visualization of Agricultural Changes:** The use of maps to visualize agricultural data across different time periods, aiding in the identification of spatial patterns and regional differences in agricultural activities.

3. **Temporal Aggregation of Crop Cycles and Climate:** Charts that aggregate planting and harvesting data on monthly and annual bases and the trend of rainfall and temperature over the area, providing a clear view of the agricultural calendar and its variations over the years.

4. **Analysis of Planting and Harvesting Trends:** An examination of how the timing of planting and harvesting deviates from historical averages, offering insights into the evolving nature of agricultural practices in response to various influencing factors.

This section serves as a valuable supplement to the primary results, offering an enriched perspective on the state and evolution of agriculture in Lebanon. It is intended to support researchers, policymakers, and stakeholders in understanding the complex dynamics of agricultural land use and management.

### Comparative Maps of Cultivation Extent

The analysis encompasses a detailed examination of the annual cultivated land in Lebanon over three distinct periods: 2011-2015, 2016-2020, and 2021-2023. These comparative maps provide a visual representation of the temporal changes in agricultural practices, focusing on both planting and harvest phases.

**Planting Phase Analysis (2011-2023):** The map for this period reveals the spatial distribution and extent of land preparation and planting activities. It helps in understanding the initial stages of agricultural cycles and how they have evolved over time.

::::{tab-set}
:::{tab-item} 2011-2015
:sync: key1
![CL1](./images/tur_sos_historical_2011_2015.png)

**Figure 20.** Cultivated land, 2011-2015
:::

:::{tab-item} 2016-2020
:sync: key2
![CL2](./images/tur_sos_historical_2016_2020.png)

**Figure 21.** Cultivated land, 2016-2020
:::

:::{tab-item} 2021-2023
:sync: key3
![CL3](./images/tur_sos_historical_2021_2023.png)

**Figure 22.** Cultivated land, 2021-2023
:::
::::

**Harvest Phase Analysis (2011-2023):** This map illustrates the areas where harvesting activities were predominant, offering insights into the culmination of agricultural cycles. It aids in assessing the productivity and end results of farming practices during this period.

::::{tab-set}
:::{tab-item} 2011-2015
:sync: key1
![CL1](./images/tur_eos_historical_2011_2015.png)

**Figure 23.** Cultivated land, 2011-2015
:::

:::{tab-item} 2016-2020
:sync: key2
![CL2](./images/tur_eos_historical_2016_2020.png)

**Figure 24.** Cultivated land, 2016-2020
:::

:::{tab-item} 2021-2023
:sync: key3
![CL3](./images/tur_eos_historical_2021_2023.png)

**Figure 25.** Cultivated land, 2021-2023
:::
::::

### Visualization of Agricultural Changes: Trends and Anomalies in Planting and Harvest

This section delves into the annual trends and anomalies in planting and harvest areas across Lebanon for the periods 2011-2015, 2016-2020, and 2021-2023, with a particular focus on the admin3 level. By examining these trends, we gain a nuanced understanding of how agricultural activities have evolved over time in specific regions.

**Annual Trends in Planting and Harvest Areas:** These visualizations showcase the yearly fluctuations in the extent of cultivated lands during the planting and harvesting phases. They reveal patterns, consistencies, or irregularities in agricultural practices across different regions, providing insights into the stability and adaptability of the agricultural sector.

* Planting areas

	::::{tab-set}
	:::{tab-item} 2011-2015
	:sync: key1
	![PA1](./images/tur_sos_historical_2011_2015_areas.png)

	**Figure 26.** Planting areas, 2011-2015
	:::

	:::{tab-item} 2016-2020
	:sync: key2
	![PA2](./images/tur_sos_historical_2016_2020_areas.png)

	**Figure 27.** Planting areas, 2016-2020
	:::

	:::{tab-item} 2021-2023
	:sync: key3
	![PA3](./images/tur_sos_historical_2021_2023_areas.png)

	**Figure 28.** Planting areas, 2021-2023
	:::

* Harvest areas

	::::{tab-set}
	:::{tab-item} 2011-2015
	:sync: key1
	![HA1](./images/tur_eos_historical_2011_2015_areas.png)

	**Figure 29.** Harvest areas, 2011-2015
	:::

	:::{tab-item} 2016-2020
	:sync: key2
	![HA2](./images/tur_eos_historical_2016_2020_areas.png)

	**Figure 30.** Harvest areas, 2016-2020
	:::

	:::{tab-item} 2021-2023
	:sync: key3
	![HA3](./images/tur_eos_historical_2021_2023_areas.png)

	**Figure 31.** Harvest areas, 2021-2023
	:::
	::::

**Percent Anomalies in Planting and Harvest Areas:** The analysis of anomalies offers a deeper perspective on the deviations from expected or average agricultural activities. By highlighting regions with significant deviations, these charts help in identifying areas that may be experiencing changes due to environmental factors, policy shifts, or other influences.

* Planting anomaly

	::::{tab-set}
	:::{tab-item} 2011-2015
	:sync: key1
	![PA1](./images/tur_sos_historical_2011_2015_anomaly.png)

	**Figure 32.** Planting anomaly, 2011-2015
	:::

	:::{tab-item} 2016-2020
	:sync: key2
	![PA2](./images/tur_sos_historical_2016_2020_anomaly.png)

	**Figure 33.** Planting anomaly, 2016-2020
	:::

	:::{tab-item} 2021-2023
	:sync: key3
	![PA3](./images/tur_sos_historical_2021_2023_anomaly.png)

	**Figure 34.** Planting anomaly, 2021-2023
	:::

* Harvest anomaly

	::::{tab-set}
	:::{tab-item} 2011-2015
	:sync: key1
	![HA1](./images/tur_eos_historical_2011_2015_anomaly.png)

	**Figure 35.** Harvest anomaly, 2011-2015
	:::

	:::{tab-item} 2016-2020
	:sync: key2
	![HA2](./images/tur_eos_historical_2016_2020_anomaly.png)

	**Figure 36.** Harvest anomaly, 2016-2020
	:::

	:::{tab-item} 2021-2023
	:sync: key3
	![HA3](./images/tur_eos_historical_2021_2023_anomaly.png)

	**Figure 37.** Harvest anomaly, 2021-2023
	:::
	::::

### Temporal Aggregation of Crop Cycles and Climate: A Multi-Level Analysis

This section presents a comprehensive analysis of planting and harvest cycles in conjunction with climate data, spanning from 2003 to 2023. The focus is on both national (admin0) and governorate (admin1) levels, offering a layered understanding of agricultural patterns in relation to environmental factors.

**Annual and Monthly Planting and Harvest Trends:** Line plots illustrate the fluctuations in the areas of planting and harvest throughout the years. These visualizations trace the seasonal and annual variations, providing a clear picture of the agricultural calendar and its evolution over the past two decades.

* National aggregate

	::::{tab-set}
	:::{tab-item} Annual Harvest and Planting
	![AA0](./images/plot_tur_adm0_annual_pheno.png)

	**Figure 38.** Annual Harvest and Planting, 2003-2023
	:::

	:::{tab-item} Monthly Harvest and Planting
	![MA0](./images/plot_tur_adm0_monthly_pheno.png)

	**Figure 39.** Monthly Harvest and Planting, 2003-2023
	:::
	::::

* Governorate aggregate

	* Annual Harvest and Planning

		::::{tab-set}
		:::{tab-item} Adana
		![AA1](./images/plot_tur_adm1_Adana_annual_pheno.png)

		**Figure 40.** Adana, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Afyonkarahisar
		![AA2](./images/plot_tur_adm1_Afyonkarahisar_annual_pheno.png)

		**Figure 41.** Afyonkarahisar, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Agri
		![AA3](./images/plot_tur_adm1_Agri_Lebanon_annual_pheno.png)

		**Figure 42.** Agri, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Amasya
		![AA4](./images/plot_tur_adm1_El_Amasya_annual_pheno.png)

		**Figure 43.** Amasya, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Ankara
		![AA5](./images/plot_tur_adm1_Ankara_annual_pheno.png)

		**Figure 44.** Ankara, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Antalya
		![AA6](./images/plot_tur_adm1_Antalya_annual_pheno.png)

		**Figure 45.** Antalya, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Artvin
		![AA7](./images/plot_tur_adm1_Artvin_annual_pheno.png)

		**Figure 46.** Artvin, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Aydin
		![AA8](./images/plot_tur_adm1_Aydin_annual_pheno.png)

		**Figure 47.** Aydin, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Balikesir
		![AA9](./images/plot_tur_adm1_Balikesir_annual_pheno.png)

		**Figure 48.** Balikesir, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Bilecik
		![AA10](./images/plot_tur_adm1_Bilecik_annual_pheno.png)

		**Figure 49.** Bilecik, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Bingol
		![AA11](./images/plot_tur_adm1_Bingol_annual_pheno.png)

		**Figure 50.** Bingol, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Bitlis
		![AA12](./images/plot_tur_adm1_Bitlis_annual_pheno.png)

		**Figure 51.** Bitlis, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Bolu
		![AA13](./images/plot_tur_adm1_Bolu_annual_pheno.png)

		**Figure 52.** Bolu, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Burdur
		![AA14](./images/plot_tur_adm1_Burdur_annual_pheno.png)

		**Figure 53.** Burdur, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Bursa
		![AA15](./images/plot_tur_adm1_Bursa_annual_pheno.png)

		**Figure 54.** Bursa, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Canakkale
		![AA16](./images/plot_tur_adm1_Canakkale_annual_pheno.png)

		**Figure 55.** Canakkale, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Cankiri
		![AA17](./images/plot_tur_adm1_Cankiri_annual_pheno.png)

		**Figure 56.** Cankiri, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Corum
		![AA18](./images/plot_tur_adm1_Corum_annual_pheno.png)

		**Figure 57.** Corum, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Denizli
		![AA19](./images/plot_tur_adm1_Denizli_annual_pheno.png)

		**Figure 58.** Denizli, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Diyarbakir
		![AA20](./images/plot_tur_adm1_Diyarbakir_annual_pheno.png)

		**Figure 59.** Diyarbakir, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Edirne
		![AA21](./images/plot_tur_adm1_Edirne_annual_pheno.png)

		**Figure 60.** Edirne, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Elazig
		![AA22](./images/plot_tur_adm1_Elazig_annual_pheno.png)

		**Figure 61.** Elazig, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Erzincan
		![AA23](./images/plot_tur_adm1_Erzincan_annual_pheno.png)

		**Figure 62.** Erzincan, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Erzurum
		![AA24](./images/plot_tur_adm1_Erzurum_annual_pheno.png)

		**Figure 63.** Erzurum, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Eskisehir
		![AA25](./images/plot_tur_adm1_Eskisehir_annual_pheno.png)

		**Figure 64.** Eskisehir, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Gaziantep
		![AA26](./images/plot_tur_adm1_Gaziantep_annual_pheno.png)

		**Figure 65.** Gaziantep, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Giresun
		![AA27](./images/plot_tur_adm1_Giresun_annual_pheno.png)

		**Figure 66.** Giresun, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Gumushane
		![AA28](./images/plot_tur_adm1_Gumushane_annual_pheno.png)

		**Figure 67.** Gumushane, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Hakkari
		![AA29](./images/plot_tur_adm1_Hakkari_annual_pheno.png)

		**Figure 68.** Hakkari, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Hatay
		![AA30](./images/plot_tur_adm1_Hatay_annual_pheno.png)

		**Figure 69.** Hatay, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Isparta
		![AA31](./images/plot_tur_adm1_Isparta_annual_pheno.png)

		**Figure 70.** Isparta, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Mersin
		![AA32](./images/plot_tur_adm1_Mersin_annual_pheno.png)

		**Figure 71.** Mersin, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Istanbul
		![AA33](./images/plot_tur_adm1_Istanbul_annual_pheno.png)

		**Figure 72.** Istanbul, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Izmir
		![AA34](./images/plot_tur_adm1_Izmir_annual_pheno.png)

		**Figure 73.** Izmir, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Kars
		![AA35](./images/plot_tur_adm1_Kars_annual_pheno.png)

		**Figure 74.** Kars, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Kastamonu
		![AA36](./images/plot_tur_adm1_Kastamonu_annual_pheno.png)

		**Figure 75.** Kastamonu, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Kayseri
		![AA37](./images/plot_tur_adm1_Kayseri_annual_pheno.png)

		**Figure 76.** Kayseri, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Kirklareli
		![AA38](./images/plot_tur_adm1_Kirklareli_annual_pheno.png)

		**Figure 77.** Kirklareli, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Kirsehir
		![AA39](./images/plot_tur_adm1_Kirsehir_annual_pheno.png)

		**Figure 78.** Kirsehir, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Kocaeli
		![AA40](./images/plot_tur_adm1_Kocaeli_annual_pheno.png)

		**Figure 79.** Kocaeli, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Konya
		![AA41](./images/plot_tur_adm1_Konya_annual_pheno.png)

		**Figure 80.** Konya, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Kutahya
		![AA42](./images/plot_tur_adm1_Kutahya_annual_pheno.png)

		**Figure 81.** Kutahya, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Malatya
		![AA43](./images/plot_tur_adm1_Malatya_annual_pheno.png)

		**Figure 82.** Malatya, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Manisa
		![AA44](./images/plot_tur_adm1_Manisa_annual_pheno.png)

		**Figure 83.** Manisa, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Kahramanmaras
		![AA45](./images/plot_tur_adm1_Kahramanmaras_annual_pheno.png)

		**Figure 84.** Kahramanmaras, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Mardin
		![AA46](./images/plot_tur_adm1_Mardin_annual_pheno.png)

		**Figure 85.** Mardin, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Mugla
		![AA47](./images/plot_tur_adm1_Mugla_annual_pheno.png)

		**Figure 86.** Mugla, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Mus
		![AA48](./images/plot_tur_adm1_Mus_annual_pheno.png)

		**Figure 87.** Mus, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Nevsehir
		![AA49](./images/plot_tur_adm1_Nevsehir_annual_pheno.png)

		**Figure 88.** Nevsehir, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Nigde
		![AA50](./images/plot_tur_adm1_Nigde_annual_pheno.png)

		**Figure 89.** Nigde, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Ordu
		![AA51](./images/plot_tur_adm1_Ordu_annual_pheno.png)

		**Figure 90.** Ordu, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Rize
		![AA52](./images/plot_tur_adm1_Rize_annual_pheno.png)

		**Figure 91.** Rize, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Sakarya
		![AA53](./images/plot_tur_adm1_Sakarya_annual_pheno.png)

		**Figure 92.** Sakarya, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Samsun
		![AA54](./images/plot_tur_adm1_Samsun_annual_pheno.png)

		**Figure 93.** Samsun, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Siirt
		![AA55](./images/plot_tur_adm1_Siirt_annual_pheno.png)

		**Figure 94.** Siirt, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Sinop
		![AA56](./images/plot_tur_adm1_Sinop_annual_pheno.png)

		**Figure 95.** Sinop, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Sivas
		![AA57](./images/plot_tur_adm1_Sivas_annual_pheno.png)

		**Figure 96.** Sivas, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Tekirdag
		![AA58](./images/plot_tur_adm1_Tekirdag_annual_pheno.png)

		**Figure 97.** Tekirdag, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Tokat
		![AA59](./images/plot_tur_adm1_Tokat_annual_pheno.png)

		**Figure 98.** Tokat, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Trabzon
		![AA60](./images/plot_tur_adm1_Trabzon_annual_pheno.png)

		**Figure 99.** Trabzon, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Tunceli
		![AA61](./images/plot_tur_adm1_Tunceli_annual_pheno.png)

		**Figure 100.** Tunceli, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Sanliurfa
		![AA62](./images/plot_tur_adm1_Sanliurfa_annual_pheno.png)

		**Figure 101.** Sanliurfa, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Usak
		![AA63](./images/plot_tur_adm1_Usak_annual_pheno.png)

		**Figure 102.** Usak, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Van
		![AA64](./images/plot_tur_adm1_Van_annual_pheno.png)

		**Figure 103.** Van, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Yozgat
		![AA65](./images/plot_tur_adm1_Yozgat_annual_pheno.png)

		**Figure 104.** Yozgat, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Zonguldak
		![AA66](./images/plot_tur_adm1_Zonguldak_annual_pheno.png)

		**Figure 105.** Zonguldak, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Aksaray
		![AA67](./images/plot_tur_adm1_Aksaray_annual_pheno.png)

		**Figure 106.** Aksaray, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Bayburt
		![AA68](./images/plot_tur_adm1_Bayburt_annual_pheno.png)

		**Figure 107.** Bayburt, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Karaman
		![AA69](./images/plot_tur_adm1_Karaman_annual_pheno.png)

		**Figure 108.** Karaman, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Kirikkale
		![AA70](./images/plot_tur_adm1_Kirikkale_annual_pheno.png)

		**Figure 109.** Kirikkale, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Batman
		![AA71](./images/plot_tur_adm1_Batman_annual_pheno.png)

		**Figure 110.** Batman, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Sirnak
		![AA72](./images/plot_tur_adm1_Sirnak_annual_pheno.png)

		**Figure 111.** Sirnak, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Bartin
		![AA73](./images/plot_tur_adm1_Bartin_annual_pheno.png)

		**Figure 112.** Bartin, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Ardahan
		![AA74](./images/plot_tur_adm1_Ardahan_annual_pheno.png)

		**Figure 113.** Ardahan, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Igdir
		![AA75](./images/plot_tur_adm1_Igdir_annual_pheno.png)

		**Figure 114.** Igdir, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Yalova
		![AA76](./images/plot_tur_adm1_Yalova_annual_pheno.png)

		**Figure 115.** Yalova, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Karabuk
		![AA77](./images/plot_tur_adm1_Karabuk_annual_pheno.png)

		**Figure 116.** Karabuk, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Kilis
		![AA78](./images/plot_tur_adm1_Kilis_annual_pheno.png)

		**Figure 117.** Kilis, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Osmaniye
		![AA79](./images/plot_tur_adm1_Osmaniye_annual_pheno.png)

		**Figure 118.** Osmaniye, Annual Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Duzce
		![AA80](./images/plot_tur_adm1_Duzce_annual_pheno.png)

		**Figure 119.** Duzce, Annual Harvest and Planting Anomaly, 2003-2023
		:::
		::::

	* Monthly Harvest and Planning

		::::{tab-set}
		:::{tab-item} Adana
		![MA1](./images/plot_tur_adm1_Adana_monthly_pheno.png)

		**Figure 120.** Adana, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Afyonkarahisar
		![MA2](./images/plot_tur_adm1_Afyonkarahisar_monthly_pheno.png)

		**Figure 121.** Afyonkarahisar, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Agri
		![MA3](./images/plot_tur_adm1_Agri_Lebanon_monthly_pheno.png)

		**Figure 122.** Agri, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Amasya
		![MA4](./images/plot_tur_adm1_El_Amasya_monthly_pheno.png)

		**Figure 123.** Amasya, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Ankara
		![MA5](./images/plot_tur_adm1_Ankara_monthly_pheno.png)

		**Figure 124.** Ankara, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Antalya
		![MA6](./images/plot_tur_adm1_Antalya_monthly_pheno.png)

		**Figure 125.** Antalya, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Artvin
		![MA7](./images/plot_tur_adm1_Artvin_monthly_pheno.png)

		**Figure 126.** Artvin, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Aydin
		![MA8](./images/plot_tur_adm1_Aydin_monthly_pheno.png)

		**Figure 127.** Aydin, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Balikesir
		![MA9](./images/plot_tur_adm1_Balikesir_monthly_pheno.png)

		**Figure 128.** Balikesir, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Bilecik
		![MA10](./images/plot_tur_adm1_Bilecik_monthly_pheno.png)

		**Figure 129.** Bilecik, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Bingol
		![MA11](./images/plot_tur_adm1_Bingol_monthly_pheno.png)

		**Figure 130.** Bingol, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Bitlis
		![MA12](./images/plot_tur_adm1_Bitlis_monthly_pheno.png)

		**Figure 131.** Bitlis, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Bolu
		![MA13](./images/plot_tur_adm1_Bolu_monthly_pheno.png)

		**Figure 132.** Bolu, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Burdur
		![MA14](./images/plot_tur_adm1_Burdur_monthly_pheno.png)

		**Figure 133.** Burdur, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Bursa
		![MA15](./images/plot_tur_adm1_Bursa_monthly_pheno.png)

		**Figure 134.** Bursa, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Canakkale
		![MA16](./images/plot_tur_adm1_Canakkale_monthly_pheno.png)

		**Figure 135.** Canakkale, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Cankiri
		![MA17](./images/plot_tur_adm1_Cankiri_monthly_pheno.png)

		**Figure 136.** Cankiri, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Corum
		![MA18](./images/plot_tur_adm1_Corum_monthly_pheno.png)

		**Figure 137.** Corum, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Denizli
		![MA19](./images/plot_tur_adm1_Denizli_monthly_pheno.png)

		**Figure 138.** Denizli, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Diyarbakir
		![MA20](./images/plot_tur_adm1_Diyarbakir_monthly_pheno.png)

		**Figure 139.** Diyarbakir, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Edirne
		![MA21](./images/plot_tur_adm1_Edirne_monthly_pheno.png)

		**Figure 140.** Edirne, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Elazig
		![MA22](./images/plot_tur_adm1_Elazig_monthly_pheno.png)

		**Figure 141.** Elazig, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Erzincan
		![MA23](./images/plot_tur_adm1_Erzincan_monthly_pheno.png)

		**Figure 142.** Erzincan, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Erzurum
		![MA24](./images/plot_tur_adm1_Erzurum_monthly_pheno.png)

		**Figure 143.** Erzurum, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Eskisehir
		![MA25](./images/plot_tur_adm1_Eskisehir_monthly_pheno.png)

		**Figure 144.** Eskisehir, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Gaziantep
		![MA26](./images/plot_tur_adm1_Gaziantep_monthly_pheno.png)

		**Figure 145.** Gaziantep, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Giresun
		![MA27](./images/plot_tur_adm1_Giresun_monthly_pheno.png)

		**Figure 146.** Giresun, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Gumushane
		![MA28](./images/plot_tur_adm1_Gumushane_monthly_pheno.png)

		**Figure 147.** Gumushane, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Hakkari
		![MA29](./images/plot_tur_adm1_Hakkari_monthly_pheno.png)

		**Figure 148.** Hakkari, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Hatay
		![MA30](./images/plot_tur_adm1_Hatay_monthly_pheno.png)

		**Figure 149.** Hatay, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Isparta
		![MA31](./images/plot_tur_adm1_Isparta_monthly_pheno.png)

		**Figure 150.** Isparta, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Mersin
		![MA32](./images/plot_tur_adm1_Mersin_monthly_pheno.png)

		**Figure 151.** Mersin, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Istanbul
		![MA33](./images/plot_tur_adm1_Istanbul_monthly_pheno.png)

		**Figure 152.** Istanbul, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Izmir
		![MA34](./images/plot_tur_adm1_Izmir_monthly_pheno.png)

		**Figure 153.** Izmir, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Kars
		![MA35](./images/plot_tur_adm1_Kars_monthly_pheno.png)

		**Figure 154.** Kars, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Kastamonu
		![MA36](./images/plot_tur_adm1_Kastamonu_monthly_pheno.png)

		**Figure 155.** Kastamonu, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Kayseri
		![MA37](./images/plot_tur_adm1_Kayseri_monthly_pheno.png)

		**Figure 156.** Kayseri, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Kirklareli
		![MA38](./images/plot_tur_adm1_Kirklareli_monthly_pheno.png)

		**Figure 157.** Kirklareli, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Kirsehir
		![MA39](./images/plot_tur_adm1_Kirsehir_monthly_pheno.png)

		**Figure 158.** Kirsehir, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Kocaeli
		![MA40](./images/plot_tur_adm1_Kocaeli_monthly_pheno.png)

		**Figure 159.** Kocaeli, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Konya
		![MA41](./images/plot_tur_adm1_Konya_monthly_pheno.png)

		**Figure 160.** Konya, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Kutahya
		![MA42](./images/plot_tur_adm1_Kutahya_monthly_pheno.png)

		**Figure 161.** Kutahya, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Malatya
		![MA43](./images/plot_tur_adm1_Malatya_monthly_pheno.png)

		**Figure 162.** Malatya, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Manisa
		![MA44](./images/plot_tur_adm1_Manisa_monthly_pheno.png)

		**Figure 163.** Manisa, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Kahramanmaras
		![MA45](./images/plot_tur_adm1_Kahramanmaras_monthly_pheno.png)

		**Figure 164.** Kahramanmaras, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Mardin
		![MA46](./images/plot_tur_adm1_Mardin_monthly_pheno.png)

		**Figure 165.** Mardin, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Mugla
		![MA47](./images/plot_tur_adm1_Mugla_monthly_pheno.png)

		**Figure 166.** Mugla, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Mus
		![MA48](./images/plot_tur_adm1_Mus_monthly_pheno.png)

		**Figure 167.** Mus, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Nevsehir
		![MA49](./images/plot_tur_adm1_Nevsehir_monthly_pheno.png)

		**Figure 168.** Nevsehir, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Nigde
		![MA50](./images/plot_tur_adm1_Nigde_monthly_pheno.png)

		**Figure 169.** Nigde, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Ordu
		![MA51](./images/plot_tur_adm1_Ordu_monthly_pheno.png)

		**Figure 170.** Ordu, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Rize
		![MA52](./images/plot_tur_adm1_Rize_monthly_pheno.png)

		**Figure 171.** Rize, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Sakarya
		![MA53](./images/plot_tur_adm1_Sakarya_monthly_pheno.png)

		**Figure 172.** Sakarya, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Samsun
		![MA54](./images/plot_tur_adm1_Samsun_monthly_pheno.png)

		**Figure 173.** Samsun, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Siirt
		![MA55](./images/plot_tur_adm1_Siirt_monthly_pheno.png)

		**Figure 174.** Siirt, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Sinop
		![MA56](./images/plot_tur_adm1_Sinop_monthly_pheno.png)

		**Figure 175.** Sinop, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Sivas
		![MA57](./images/plot_tur_adm1_Sivas_monthly_pheno.png)

		**Figure 176.** Sivas, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Tekirdag
		![MA58](./images/plot_tur_adm1_Tekirdag_monthly_pheno.png)

		**Figure 177.** Tekirdag, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Tokat
		![MA59](./images/plot_tur_adm1_Tokat_monthly_pheno.png)

		**Figure 178.** Tokat, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Trabzon
		![MA60](./images/plot_tur_adm1_Trabzon_monthly_pheno.png)

		**Figure 179.** Trabzon, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Tunceli
		![MA61](./images/plot_tur_adm1_Tunceli_monthly_pheno.png)

		**Figure 180.** Tunceli, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Sanliurfa
		![MA62](./images/plot_tur_adm1_Sanliurfa_monthly_pheno.png)

		**Figure 181.** Sanliurfa, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Usak
		![MA63](./images/plot_tur_adm1_Usak_monthly_pheno.png)

		**Figure 182.** Usak, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Van
		![MA64](./images/plot_tur_adm1_Van_monthly_pheno.png)

		**Figure 183.** Van, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Yozgat
		![MA65](./images/plot_tur_adm1_Yozgat_monthly_pheno.png)

		**Figure 184.** Yozgat, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Zonguldak
		![MA66](./images/plot_tur_adm1_Zonguldak_monthly_pheno.png)

		**Figure 185.** Zonguldak, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Aksaray
		![MA67](./images/plot_tur_adm1_Aksaray_monthly_pheno.png)

		**Figure 186.** Aksaray, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Bayburt
		![MA68](./images/plot_tur_adm1_Bayburt_monthly_pheno.png)

		**Figure 187.** Bayburt, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Karaman
		![MA69](./images/plot_tur_adm1_Karaman_monthly_pheno.png)

		**Figure 188.** Karaman, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Kirikkale
		![MA70](./images/plot_tur_adm1_Kirikkale_monthly_pheno.png)

		**Figure 189.** Kirikkale, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Batman
		![MA71](./images/plot_tur_adm1_Batman_monthly_pheno.png)

		**Figure 190.** Batman, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Sirnak
		![MA72](./images/plot_tur_adm1_Sirnak_monthly_pheno.png)

		**Figure 191.** Sirnak, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Bartin
		![MA73](./images/plot_tur_adm1_Bartin_monthly_pheno.png)

		**Figure 192.** Bartin, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Ardahan
		![MA74](./images/plot_tur_adm1_Ardahan_monthly_pheno.png)

		**Figure 193.** Ardahan, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Igdir
		![MA75](./images/plot_tur_adm1_Igdir_monthly_pheno.png)

		**Figure 194.** Igdir, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Yalova
		![MA76](./images/plot_tur_adm1_Yalova_monthly_pheno.png)

		**Figure 195.** Yalova, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Karabuk
		![MA77](./images/plot_tur_adm1_Karabuk_monthly_pheno.png)

		**Figure 196.** Karabuk, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Kilis
		![MA78](./images/plot_tur_adm1_Kilis_monthly_pheno.png)

		**Figure 197.** Kilis, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Osmaniye
		![MA79](./images/plot_tur_adm1_Osmaniye_monthly_pheno.png)

		**Figure 198.** Osmaniye, Monthly Harvest and Planting Anomaly, 2003-2023
		:::

		:::{tab-item} Duzce
		![MA80](./images/plot_tur_adm1_Duzce_monthly_pheno.png)

		**Figure 199.** Duzce, Monthly Harvest and Planting Anomaly, 2003-2023
		:::
		::::

**Correlation with Precipitation and Temperature:** By integrating climate data, specifically monthly and annual records of precipitation and temperature, the analysis draws connections between climatic conditions and agricultural activities. This aspect is crucial in understanding how changing weather patterns impact the timing and success of crop cycles.

* National aggregate

	::::{tab-set}
	:::{tab-item} Annual Rainfall and Temperature
	![RTA0](./images/plot_tur_adm0_annual_preciptavg.png)

	**Figure 200.** Annual Rainfall and Temperature, 2003-2023
	:::

	:::{tab-item} Monthly Rainfall and Temperature
	![RTM0](./images/plot_tur_adm0_monthly_preciptavg.png)

	**Figure 201.** Monthly Rainfall and Temperature, 2003-2023
	:::
	::::

* Governorate aggregate

	* Annual Rainfall and Temperature

		::::{tab-set}
		:::{tab-item} Adana
		![RTA1](./images/plot_tur_adm1_Adana_annual_preciptavg.png)

		**Figure 202.** Adana, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Afyonkarahisar
		![RTA2](./images/plot_tur_adm1_Afyonkarahisar_annual_preciptavg.png)

		**Figure 203.** Afyonkarahisar, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Agri
		![RTA3](./images/plot_tur_adm1_Agri_Lebanon_annual_preciptavg.png)

		**Figure 204.** Agri, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Amasya
		![RTA4](./images/plot_tur_adm1_El_Amasya_annual_preciptavg.png)

		**Figure 205.** Amasya, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Ankara
		![RTA5](./images/plot_tur_adm1_Ankara_annual_preciptavg.png)

		**Figure 206.** Ankara, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Antalya
		![RTA6](./images/plot_tur_adm1_Antalya_annual_preciptavg.png)

		**Figure 207.** Antalya, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Artvin
		![RTA7](./images/plot_tur_adm1_Artvin_annual_preciptavg.png)

		**Figure 208.** Artvin, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Aydin
		![RTA8](./images/plot_tur_adm1_Aydin_annual_preciptavg.png)

		**Figure 209.** Aydin, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Balikesir
		![RTA9](./images/plot_tur_adm1_Balikesir_annual_preciptavg.png)

		**Figure 210.** Balikesir, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Bilecik
		![RTA10](./images/plot_tur_adm1_Bilecik_annual_preciptavg.png)

		**Figure 211.** Bilecik, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Bingol
		![RTA11](./images/plot_tur_adm1_Bingol_annual_preciptavg.png)

		**Figure 212.** Bingol, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Bitlis
		![RTA12](./images/plot_tur_adm1_Bitlis_annual_preciptavg.png)

		**Figure 213.** Bitlis, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Bolu
		![RTA13](./images/plot_tur_adm1_Bolu_annual_preciptavg.png)

		**Figure 214.** Bolu, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Burdur
		![RTA14](./images/plot_tur_adm1_Burdur_annual_preciptavg.png)

		**Figure 215.** Burdur, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Bursa
		![RTA15](./images/plot_tur_adm1_Bursa_annual_preciptavg.png)

		**Figure 216.** Bursa, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Canakkale
		![RTA16](./images/plot_tur_adm1_Canakkale_annual_preciptavg.png)

		**Figure 217.** Canakkale, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Cankiri
		![RTA17](./images/plot_tur_adm1_Cankiri_annual_preciptavg.png)

		**Figure 218.** Cankiri, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Corum
		![RTA18](./images/plot_tur_adm1_Corum_annual_preciptavg.png)

		**Figure 219.** Corum, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Denizli
		![RTA19](./images/plot_tur_adm1_Denizli_annual_preciptavg.png)

		**Figure 220.** Denizli, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Diyarbakir
		![RTA20](./images/plot_tur_adm1_Diyarbakir_annual_preciptavg.png)

		**Figure 221.** Diyarbakir, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Edirne
		![RTA21](./images/plot_tur_adm1_Edirne_annual_preciptavg.png)

		**Figure 222.** Edirne, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Elazig
		![RTA22](./images/plot_tur_adm1_Elazig_annual_preciptavg.png)

		**Figure 223.** Elazig, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Erzincan
		![RTA23](./images/plot_tur_adm1_Erzincan_annual_preciptavg.png)

		**Figure 224.** Erzincan, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Erzurum
		![RTA24](./images/plot_tur_adm1_Erzurum_annual_preciptavg.png)

		**Figure 225.** Erzurum, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Eskisehir
		![RTA25](./images/plot_tur_adm1_Eskisehir_annual_preciptavg.png)

		**Figure 226.** Eskisehir, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Gaziantep
		![RTA26](./images/plot_tur_adm1_Gaziantep_annual_preciptavg.png)

		**Figure 227.** Gaziantep, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Giresun
		![RTA27](./images/plot_tur_adm1_Giresun_annual_preciptavg.png)

		**Figure 228.** Giresun, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Gumushane
		![RTA28](./images/plot_tur_adm1_Gumushane_annual_preciptavg.png)

		**Figure 229.** Gumushane, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Hakkari
		![RTA29](./images/plot_tur_adm1_Hakkari_annual_preciptavg.png)

		**Figure 230.** Hakkari, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Hatay
		![RTA30](./images/plot_tur_adm1_Hatay_annual_preciptavg.png)

		**Figure 231.** Hatay, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Isparta
		![RTA31](./images/plot_tur_adm1_Isparta_annual_preciptavg.png)

		**Figure 232.** Isparta, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Mersin
		![RTA32](./images/plot_tur_adm1_Mersin_annual_preciptavg.png)

		**Figure 233.** Mersin, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Istanbul
		![RTA33](./images/plot_tur_adm1_Istanbul_annual_preciptavg.png)

		**Figure 234.** Istanbul, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Izmir
		![RTA34](./images/plot_tur_adm1_Izmir_annual_preciptavg.png)

		**Figure 235.** Izmir, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Kars
		![RTA35](./images/plot_tur_adm1_Kars_annual_preciptavg.png)

		**Figure 236.** Kars, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Kastamonu
		![RTA36](./images/plot_tur_adm1_Kastamonu_annual_preciptavg.png)

		**Figure 237.** Kastamonu, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Kayseri
		![RTA37](./images/plot_tur_adm1_Kayseri_annual_preciptavg.png)

		**Figure 238.** Kayseri, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Kirklareli
		![RTA38](./images/plot_tur_adm1_Kirklareli_annual_preciptavg.png)

		**Figure 239.** Kirklareli, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Kirsehir
		![RTA39](./images/plot_tur_adm1_Kirsehir_annual_preciptavg.png)

		**Figure 240.** Kirsehir, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Kocaeli
		![RTA40](./images/plot_tur_adm1_Kocaeli_annual_preciptavg.png)

		**Figure 241.** Kocaeli, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Konya
		![RTA41](./images/plot_tur_adm1_Konya_annual_preciptavg.png)

		**Figure 242.** Konya, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Kutahya
		![RTA42](./images/plot_tur_adm1_Kutahya_annual_preciptavg.png)

		**Figure 243.** Kutahya, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Malatya
		![RTA43](./images/plot_tur_adm1_Malatya_annual_preciptavg.png)

		**Figure 244.** Malatya, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Manisa
		![RTA44](./images/plot_tur_adm1_Manisa_annual_preciptavg.png)

		**Figure 245.** Manisa, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Kahramanmaras
		![RTA45](./images/plot_tur_adm1_Kahramanmaras_annual_preciptavg.png)

		**Figure 246.** Kahramanmaras, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Mardin
		![RTA46](./images/plot_tur_adm1_Mardin_annual_preciptavg.png)

		**Figure 247.** Mardin, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Mugla
		![RTA47](./images/plot_tur_adm1_Mugla_annual_preciptavg.png)

		**Figure 248.** Mugla, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Mus
		![RTA48](./images/plot_tur_adm1_Mus_annual_preciptavg.png)

		**Figure 249.** Mus, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Nevsehir
		![RTA49](./images/plot_tur_adm1_Nevsehir_annual_preciptavg.png)

		**Figure 250.** Nevsehir, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Nigde
		![RTA50](./images/plot_tur_adm1_Nigde_annual_preciptavg.png)

		**Figure 251.** Nigde, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Ordu
		![RTA51](./images/plot_tur_adm1_Ordu_annual_preciptavg.png)

		**Figure 252.** Ordu, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Rize
		![RTA52](./images/plot_tur_adm1_Rize_annual_preciptavg.png)

		**Figure 253.** Rize, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Sakarya
		![RTA53](./images/plot_tur_adm1_Sakarya_annual_preciptavg.png)

		**Figure 254.** Sakarya, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Samsun
		![RTA54](./images/plot_tur_adm1_Samsun_annual_preciptavg.png)

		**Figure 255.** Samsun, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Siirt
		![RTA55](./images/plot_tur_adm1_Siirt_annual_preciptavg.png)

		**Figure 256.** Siirt, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Sinop
		![RTA56](./images/plot_tur_adm1_Sinop_annual_preciptavg.png)

		**Figure 257.** Sinop, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Sivas
		![RTA57](./images/plot_tur_adm1_Sivas_annual_preciptavg.png)

		**Figure 258.** Sivas, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Tekirdag
		![RTA58](./images/plot_tur_adm1_Tekirdag_annual_preciptavg.png)

		**Figure 259.** Tekirdag, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Tokat
		![RTA59](./images/plot_tur_adm1_Tokat_annual_preciptavg.png)

		**Figure 260.** Tokat, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Trabzon
		![RTA60](./images/plot_tur_adm1_Trabzon_annual_preciptavg.png)

		**Figure 261.** Trabzon, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Tunceli
		![RTA61](./images/plot_tur_adm1_Tunceli_annual_preciptavg.png)

		**Figure 262.** Tunceli, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Sanliurfa
		![RTA62](./images/plot_tur_adm1_Sanliurfa_annual_preciptavg.png)

		**Figure 263.** Sanliurfa, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Usak
		![RTA63](./images/plot_tur_adm1_Usak_annual_preciptavg.png)

		**Figure 264.** Usak, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Van
		![RTA64](./images/plot_tur_adm1_Van_annual_preciptavg.png)

		**Figure 265.** Van, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Yozgat
		![RTA65](./images/plot_tur_adm1_Yozgat_annual_preciptavg.png)

		**Figure 266.** Yozgat, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Zonguldak
		![RTA66](./images/plot_tur_adm1_Zonguldak_annual_preciptavg.png)

		**Figure 267.** Zonguldak, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Aksaray
		![RTA67](./images/plot_tur_adm1_Aksaray_annual_preciptavg.png)

		**Figure 268.** Aksaray, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Bayburt
		![RTA68](./images/plot_tur_adm1_Bayburt_annual_preciptavg.png)

		**Figure 269.** Bayburt, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Karaman
		![RTA69](./images/plot_tur_adm1_Karaman_annual_preciptavg.png)

		**Figure 270.** Karaman, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Kirikkale
		![RTA70](./images/plot_tur_adm1_Kirikkale_annual_preciptavg.png)

		**Figure 271.** Kirikkale, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Batman
		![RTA71](./images/plot_tur_adm1_Batman_annual_preciptavg.png)

		**Figure 272.** Batman, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Sirnak
		![RTA72](./images/plot_tur_adm1_Sirnak_annual_preciptavg.png)

		**Figure 273.** Sirnak, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Bartin
		![RTA73](./images/plot_tur_adm1_Bartin_annual_preciptavg.png)

		**Figure 274.** Bartin, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Ardahan
		![RTA74](./images/plot_tur_adm1_Ardahan_annual_preciptavg.png)

		**Figure 275.** Ardahan, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Igdir
		![RTA75](./images/plot_tur_adm1_Igdir_annual_preciptavg.png)

		**Figure 276.** Igdir, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Yalova
		![RTA76](./images/plot_tur_adm1_Yalova_annual_preciptavg.png)

		**Figure 277.** Yalova, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Karabuk
		![RTA77](./images/plot_tur_adm1_Karabuk_annual_preciptavg.png)

		**Figure 278.** Karabuk, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Kilis
		![RTA78](./images/plot_tur_adm1_Kilis_annual_preciptavg.png)

		**Figure 279.** Kilis, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Osmaniye
		![RTA79](./images/plot_tur_adm1_Osmaniye_annual_preciptavg.png)

		**Figure 280.** Osmaniye, Annual Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Duzce
		![RTA80](./images/plot_tur_adm1_Duzce_annual_preciptavg.png)

		**Figure 281.** Duzce, Annual Rainfall and Temperature, 2003-2023
		:::
		::::

	* Monthly Rainfall and Temperature

		::::{tab-set}
		:::{tab-item} Adana
		![RTM1](./images/plot_tur_adm1_Adana_monthly_preciptavg.png)

		**Figure 282.** Adana, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Afyonkarahisar
		![RTM2](./images/plot_tur_adm1_Afyonkarahisar_monthly_preciptavg.png)

		**Figure 283.** Afyonkarahisar, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Agri
		![RTM3](./images/plot_tur_adm1_Agri_Lebanon_monthly_preciptavg.png)

		**Figure 284.** Agri, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Amasya
		![RTM4](./images/plot_tur_adm1_El_Amasya_monthly_preciptavg.png)

		**Figure 285.** Amasya, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Ankara
		![RTM5](./images/plot_tur_adm1_Ankara_monthly_preciptavg.png)

		**Figure 286.** Ankara, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Antalya
		![RTM6](./images/plot_tur_adm1_Antalya_monthly_preciptavg.png)

		**Figure 287.** Antalya, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Artvin
		![RTM7](./images/plot_tur_adm1_Artvin_monthly_preciptavg.png)

		**Figure 288.** Artvin, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Aydin
		![RTM8](./images/plot_tur_adm1_Aydin_monthly_preciptavg.png)

		**Figure 289.** Aydin, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Balikesir
		![RTM9](./images/plot_tur_adm1_Balikesir_monthly_preciptavg.png)

		**Figure 290.** Balikesir, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Bilecik
		![RTM10](./images/plot_tur_adm1_Bilecik_monthly_preciptavg.png)

		**Figure 291.** Bilecik, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Bingol
		![RTM11](./images/plot_tur_adm1_Bingol_monthly_preciptavg.png)

		**Figure 292.** Bingol, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Bitlis
		![RTM12](./images/plot_tur_adm1_Bitlis_monthly_preciptavg.png)

		**Figure 293.** Bitlis, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Bolu
		![RTM13](./images/plot_tur_adm1_Bolu_monthly_preciptavg.png)

		**Figure 294.** Bolu, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Burdur
		![RTM14](./images/plot_tur_adm1_Burdur_monthly_preciptavg.png)

		**Figure 295.** Burdur, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Bursa
		![RTM15](./images/plot_tur_adm1_Bursa_monthly_preciptavg.png)

		**Figure 296.** Bursa, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Canakkale
		![RTM16](./images/plot_tur_adm1_Canakkale_monthly_preciptavg.png)

		**Figure 297.** Canakkale, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Cankiri
		![RTM17](./images/plot_tur_adm1_Cankiri_monthly_preciptavg.png)

		**Figure 298.** Cankiri, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Corum
		![RTM18](./images/plot_tur_adm1_Corum_monthly_preciptavg.png)

		**Figure 299.** Corum, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Denizli
		![RTM19](./images/plot_tur_adm1_Denizli_monthly_preciptavg.png)

		**Figure 300.** Denizli, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Diyarbakir
		![RTM20](./images/plot_tur_adm1_Diyarbakir_monthly_preciptavg.png)

		**Figure 301.** Diyarbakir, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Edirne
		![RTM21](./images/plot_tur_adm1_Edirne_monthly_preciptavg.png)

		**Figure 302.** Edirne, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Elazig
		![RTM22](./images/plot_tur_adm1_Elazig_monthly_preciptavg.png)

		**Figure 303.** Elazig, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Erzincan
		![RTM23](./images/plot_tur_adm1_Erzincan_monthly_preciptavg.png)

		**Figure 304.** Erzincan, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Erzurum
		![RTM24](./images/plot_tur_adm1_Erzurum_monthly_preciptavg.png)

		**Figure 305.** Erzurum, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Eskisehir
		![RTM25](./images/plot_tur_adm1_Eskisehir_monthly_preciptavg.png)

		**Figure 306.** Eskisehir, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Gaziantep
		![RTM26](./images/plot_tur_adm1_Gaziantep_monthly_preciptavg.png)

		**Figure 307.** Gaziantep, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Giresun
		![RTM27](./images/plot_tur_adm1_Giresun_monthly_preciptavg.png)

		**Figure 308.** Giresun, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Gumushane
		![RTM28](./images/plot_tur_adm1_Gumushane_monthly_preciptavg.png)

		**Figure 309.** Gumushane, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Hakkari
		![RTM29](./images/plot_tur_adm1_Hakkari_monthly_preciptavg.png)

		**Figure 310.** Hakkari, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Hatay
		![RTM30](./images/plot_tur_adm1_Hatay_monthly_preciptavg.png)

		**Figure 311.** Hatay, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Isparta
		![RTM31](./images/plot_tur_adm1_Isparta_monthly_preciptavg.png)

		**Figure 312.** Isparta, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Mersin
		![RTM32](./images/plot_tur_adm1_Mersin_monthly_preciptavg.png)

		**Figure 313.** Mersin, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Istanbul
		![RTM33](./images/plot_tur_adm1_Istanbul_monthly_preciptavg.png)

		**Figure 314.** Istanbul, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Izmir
		![RTM34](./images/plot_tur_adm1_Izmir_monthly_preciptavg.png)

		**Figure 315.** Izmir, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Kars
		![RTM35](./images/plot_tur_adm1_Kars_monthly_preciptavg.png)

		**Figure 316.** Kars, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Kastamonu
		![RTM36](./images/plot_tur_adm1_Kastamonu_monthly_preciptavg.png)

		**Figure 317.** Kastamonu, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Kayseri
		![RTM37](./images/plot_tur_adm1_Kayseri_monthly_preciptavg.png)

		**Figure 318.** Kayseri, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Kirklareli
		![RTM38](./images/plot_tur_adm1_Kirklareli_monthly_preciptavg.png)

		**Figure 319.** Kirklareli, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Kirsehir
		![RTM39](./images/plot_tur_adm1_Kirsehir_monthly_preciptavg.png)

		**Figure 320.** Kirsehir, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Kocaeli
		![RTM40](./images/plot_tur_adm1_Kocaeli_monthly_preciptavg.png)

		**Figure 321.** Kocaeli, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Konya
		![RTM41](./images/plot_tur_adm1_Konya_monthly_preciptavg.png)

		**Figure 322.** Konya, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Kutahya
		![RTM42](./images/plot_tur_adm1_Kutahya_monthly_preciptavg.png)

		**Figure 323.** Kutahya, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Malatya
		![RTM43](./images/plot_tur_adm1_Malatya_monthly_preciptavg.png)

		**Figure 324.** Malatya, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Manisa
		![RTM44](./images/plot_tur_adm1_Manisa_monthly_preciptavg.png)

		**Figure 325.** Manisa, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Kahramanmaras
		![RTM45](./images/plot_tur_adm1_Kahramanmaras_monthly_preciptavg.png)

		**Figure 326.** Kahramanmaras, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Mardin
		![RTM46](./images/plot_tur_adm1_Mardin_monthly_preciptavg.png)

		**Figure 327.** Mardin, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Mugla
		![RTM47](./images/plot_tur_adm1_Mugla_monthly_preciptavg.png)

		**Figure 328.** Mugla, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Mus
		![RTM48](./images/plot_tur_adm1_Mus_monthly_preciptavg.png)

		**Figure 329.** Mus, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Nevsehir
		![RTM49](./images/plot_tur_adm1_Nevsehir_monthly_preciptavg.png)

		**Figure 330.** Nevsehir, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Nigde
		![RTM50](./images/plot_tur_adm1_Nigde_monthly_preciptavg.png)

		**Figure 331.** Nigde, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Ordu
		![RTM51](./images/plot_tur_adm1_Ordu_monthly_preciptavg.png)

		**Figure 332.** Ordu, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Rize
		![RTM52](./images/plot_tur_adm1_Rize_monthly_preciptavg.png)

		**Figure 333.** Rize, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Sakarya
		![RTM53](./images/plot_tur_adm1_Sakarya_monthly_preciptavg.png)

		**Figure 334.** Sakarya, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Samsun
		![RTM54](./images/plot_tur_adm1_Samsun_monthly_preciptavg.png)

		**Figure 335.** Samsun, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Siirt
		![RTM55](./images/plot_tur_adm1_Siirt_monthly_preciptavg.png)

		**Figure 336.** Siirt, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Sinop
		![RTM56](./images/plot_tur_adm1_Sinop_monthly_preciptavg.png)

		**Figure 337.** Sinop, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Sivas
		![RTM57](./images/plot_tur_adm1_Sivas_monthly_preciptavg.png)

		**Figure 338.** Sivas, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Tekirdag
		![RTM58](./images/plot_tur_adm1_Tekirdag_monthly_preciptavg.png)

		**Figure 339.** Tekirdag, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Tokat
		![RTM59](./images/plot_tur_adm1_Tokat_monthly_preciptavg.png)

		**Figure 340.** Tokat, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Trabzon
		![RTM60](./images/plot_tur_adm1_Trabzon_monthly_preciptavg.png)

		**Figure 341.** Trabzon, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Tunceli
		![RTM61](./images/plot_tur_adm1_Tunceli_monthly_preciptavg.png)

		**Figure 342.** Tunceli, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Sanliurfa
		![RTM62](./images/plot_tur_adm1_Sanliurfa_monthly_preciptavg.png)

		**Figure 343.** Sanliurfa, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Usak
		![RTM63](./images/plot_tur_adm1_Usak_monthly_preciptavg.png)

		**Figure 344.** Usak, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Van
		![RTM64](./images/plot_tur_adm1_Van_monthly_preciptavg.png)

		**Figure 345.** Van, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Yozgat
		![RTM65](./images/plot_tur_adm1_Yozgat_monthly_preciptavg.png)

		**Figure 346.** Yozgat, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Zonguldak
		![RTM66](./images/plot_tur_adm1_Zonguldak_monthly_preciptavg.png)

		**Figure 347.** Zonguldak, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Aksaray
		![RTM67](./images/plot_tur_adm1_Aksaray_monthly_preciptavg.png)

		**Figure 348.** Aksaray, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Bayburt
		![RTM68](./images/plot_tur_adm1_Bayburt_monthly_preciptavg.png)

		**Figure 349.** Bayburt, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Karaman
		![RTM69](./images/plot_tur_adm1_Karaman_monthly_preciptavg.png)

		**Figure 350.** Karaman, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Kirikkale
		![RTM70](./images/plot_tur_adm1_Kirikkale_monthly_preciptavg.png)

		**Figure 351.** Kirikkale, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Batman
		![RTM71](./images/plot_tur_adm1_Batman_monthly_preciptavg.png)

		**Figure 352.** Batman, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Sirnak
		![RTM72](./images/plot_tur_adm1_Sirnak_monthly_preciptavg.png)

		**Figure 353.** Sirnak, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Bartin
		![RTM73](./images/plot_tur_adm1_Bartin_monthly_preciptavg.png)

		**Figure 354.** Bartin, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Ardahan
		![RTM74](./images/plot_tur_adm1_Ardahan_monthly_preciptavg.png)

		**Figure 355.** Ardahan, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Igdir
		![RTM75](./images/plot_tur_adm1_Igdir_monthly_preciptavg.png)

		**Figure 356.** Igdir, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Yalova
		![RTM76](./images/plot_tur_adm1_Yalova_monthly_preciptavg.png)

		**Figure 357.** Yalova, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Karabuk
		![RTM77](./images/plot_tur_adm1_Karabuk_monthly_preciptavg.png)

		**Figure 358.** Karabuk, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Kilis
		![RTM78](./images/plot_tur_adm1_Kilis_monthly_preciptavg.png)

		**Figure 359.** Kilis, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Osmaniye
		![RTM79](./images/plot_tur_adm1_Osmaniye_monthly_preciptavg.png)

		**Figure 360.** Osmaniye, Monthly Rainfall and Temperature, 2003-2023
		:::

		:::{tab-item} Duzce
		![RTM80](./images/plot_tur_adm1_Duzce_monthly_preciptavg.png)

		**Figure 361.** Duzce, Monthly Rainfall and Temperature, 2003-2023
		:::
		::::

### Planting and Harvesting Trends: National-Regional Perspectives and Anomalies

This section delves into the analysis of annual and monthly trends in planting and harvesting across Lebanon from 2003 to 2023. It employs a dual approach of bar plots and heatmaps to convey the nuances of agricultural activities over two decades.

* National aggregate

	::::{tab-set}
	:::{tab-item} Annual Anomaly
	![AHPA0](./images/plot_tur_adm0_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 362.** Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Monthly Anomaly
	![MHPA0](./images/plot_tur_adm0_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 363.** Monthly Harvest and Planting Anomaly, 2003-2023
	:::
	::::

**Annual Trends in Planting and Harvesting:** Bar plots are utilized to illustrate the year-on-year variations in planting and harvesting areas. These visual representations offer a clear, comparative view of the annual changes, highlighting any significant increases or decreases in agricultural activities.


* Governorate aggregate

	::::{tab-set}
	:::{tab-item} Adana
	![AHPA1](./images/plot_tur_adm1_Adana_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 364.** Adana, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Afyonkarahisar
	![AHPA2](./images/plot_tur_adm1_Afyonkarahisar_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 365.** Afyonkarahisar, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Agri
	![AHPA3](./images/plot_tur_adm1_Agri_Lebanon_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 366.** Agri, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Amasya
	![AHPA4](./images/plot_tur_adm1_El_Amasya_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 367.** Amasya, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Ankara
	![AHPA5](./images/plot_tur_adm1_Ankara_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 368.** Ankara, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Antalya
	![AHPA6](./images/plot_tur_adm1_Antalya_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 369.** Antalya, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Artvin
	![AHPA7](./images/plot_tur_adm1_Artvin_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 370.** Artvin, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Aydin
	![AHPA8](./images/plot_tur_adm1_Aydin_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 371.** Aydin, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Balikesir
	![AHPA9](./images/plot_tur_adm1_Balikesir_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 372.** Balikesir, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Bilecik
	![AHPA10](./images/plot_tur_adm1_Bilecik_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 373.** Bilecik, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Bingol
	![AHPA11](./images/plot_tur_adm1_Bingol_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 374.** Bingol, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Bitlis
	![AHPA12](./images/plot_tur_adm1_Bitlis_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 375.** Bitlis, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Bolu
	![AHPA13](./images/plot_tur_adm1_Bolu_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 376.** Bolu, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Burdur
	![AHPA14](./images/plot_tur_adm1_Burdur_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 377.** Burdur, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Bursa
	![AHPA15](./images/plot_tur_adm1_Bursa_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 378.** Bursa, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Canakkale
	![AHPA16](./images/plot_tur_adm1_Canakkale_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 379.** Canakkale, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Cankiri
	![AHPA17](./images/plot_tur_adm1_Cankiri_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 380.** Cankiri, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Corum
	![AHPA18](./images/plot_tur_adm1_Corum_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 381.** Corum, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Denizli
	![AHPA19](./images/plot_tur_adm1_Denizli_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 382.** Denizli, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Diyarbakir
	![AHPA20](./images/plot_tur_adm1_Diyarbakir_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 383.** Diyarbakir, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Edirne
	![AHPA21](./images/plot_tur_adm1_Edirne_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 384.** Edirne, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Elazig
	![AHPA22](./images/plot_tur_adm1_Elazig_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 385.** Elazig, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Erzincan
	![AHPA23](./images/plot_tur_adm1_Erzincan_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 386.** Erzincan, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Erzurum
	![AHPA24](./images/plot_tur_adm1_Erzurum_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 387.** Erzurum, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Eskisehir
	![AHPA25](./images/plot_tur_adm1_Eskisehir_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 388.** Eskisehir, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Gaziantep
	![AHPA26](./images/plot_tur_adm1_Gaziantep_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 389.** Gaziantep, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Giresun
	![AHPA27](./images/plot_tur_adm1_Giresun_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 390.** Giresun, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Gumushane
	![AHPA28](./images/plot_tur_adm1_Gumushane_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 391.** Gumushane, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Hakkari
	![AHPA29](./images/plot_tur_adm1_Hakkari_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 392.** Hakkari, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Hatay
	![AHPA30](./images/plot_tur_adm1_Hatay_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 393.** Hatay, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Isparta
	![AHPA31](./images/plot_tur_adm1_Isparta_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 394.** Isparta, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Mersin
	![AHPA32](./images/plot_tur_adm1_Mersin_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 395.** Mersin, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Istanbul
	![AHPA33](./images/plot_tur_adm1_Istanbul_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 396.** Istanbul, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Izmir
	![AHPA34](./images/plot_tur_adm1_Izmir_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 397.** Izmir, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Kars
	![AHPA35](./images/plot_tur_adm1_Kars_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 398.** Kars, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Kastamonu
	![AHPA36](./images/plot_tur_adm1_Kastamonu_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 399.** Kastamonu, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Kayseri
	![AHPA37](./images/plot_tur_adm1_Kayseri_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 400.** Kayseri, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Kirklareli
	![AHPA38](./images/plot_tur_adm1_Kirklareli_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 401.** Kirklareli, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Kirsehir
	![AHPA39](./images/plot_tur_adm1_Kirsehir_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 402.** Kirsehir, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Kocaeli
	![AHPA40](./images/plot_tur_adm1_Kocaeli_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 403.** Kocaeli, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Konya
	![AHPA41](./images/plot_tur_adm1_Konya_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 404.** Konya, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Kutahya
	![AHPA42](./images/plot_tur_adm1_Kutahya_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 405.** Kutahya, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Malatya
	![AHPA43](./images/plot_tur_adm1_Malatya_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 406.** Malatya, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Manisa
	![AHPA44](./images/plot_tur_adm1_Manisa_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 407.** Manisa, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Kahramanmaras
	![AHPA45](./images/plot_tur_adm1_Kahramanmaras_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 408.** Kahramanmaras, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Mardin
	![AHPA46](./images/plot_tur_adm1_Mardin_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 409.** Mardin, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Mugla
	![AHPA47](./images/plot_tur_adm1_Mugla_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 410.** Mugla, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Mus
	![AHPA48](./images/plot_tur_adm1_Mus_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 411.** Mus, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Nevsehir
	![AHPA49](./images/plot_tur_adm1_Nevsehir_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 412.** Nevsehir, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Nigde
	![AHPA50](./images/plot_tur_adm1_Nigde_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 413.** Nigde, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Ordu
	![AHPA51](./images/plot_tur_adm1_Ordu_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 414.** Ordu, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Rize
	![AHPA52](./images/plot_tur_adm1_Rize_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 415.** Rize, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Sakarya
	![AHPA53](./images/plot_tur_adm1_Sakarya_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 416.** Sakarya, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Samsun
	![AHPA54](./images/plot_tur_adm1_Samsun_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 417.** Samsun, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Siirt
	![AHPA55](./images/plot_tur_adm1_Siirt_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 418.** Siirt, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Sinop
	![AHPA56](./images/plot_tur_adm1_Sinop_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 419.** Sinop, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Sivas
	![AHPA57](./images/plot_tur_adm1_Sivas_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 420.** Sivas, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Tekirdag
	![AHPA58](./images/plot_tur_adm1_Tekirdag_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 421.** Tekirdag, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Tokat
	![AHPA59](./images/plot_tur_adm1_Tokat_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 422.** Tokat, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Trabzon
	![AHPA60](./images/plot_tur_adm1_Trabzon_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 423.** Trabzon, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Tunceli
	![AHPA61](./images/plot_tur_adm1_Tunceli_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 424.** Tunceli, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Sanliurfa
	![AHPA62](./images/plot_tur_adm1_Sanliurfa_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 425.** Sanliurfa, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Usak
	![AHPA63](./images/plot_tur_adm1_Usak_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 426.** Usak, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Van
	![AHPA64](./images/plot_tur_adm1_Van_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 427.** Van, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Yozgat
	![AHPA65](./images/plot_tur_adm1_Yozgat_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 428.** Yozgat, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Zonguldak
	![AHPA66](./images/plot_tur_adm1_Zonguldak_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 429.** Zonguldak, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Aksaray
	![AHPA67](./images/plot_tur_adm1_Aksaray_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 430.** Aksaray, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Bayburt
	![AHPA68](./images/plot_tur_adm1_Bayburt_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 431.** Bayburt, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Karaman
	![AHPA69](./images/plot_tur_adm1_Karaman_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 432.** Karaman, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Kirikkale
	![AHPA70](./images/plot_tur_adm1_Kirikkale_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 433.** Kirikkale, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Batman
	![AHPA71](./images/plot_tur_adm1_Batman_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 434.** Batman, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Sirnak
	![AHPA72](./images/plot_tur_adm1_Sirnak_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 435.** Sirnak, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Bartin
	![AHPA73](./images/plot_tur_adm1_Bartin_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 436.** Bartin, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Ardahan
	![AHPA74](./images/plot_tur_adm1_Ardahan_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 437.** Ardahan, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Igdir
	![AHPA75](./images/plot_tur_adm1_Igdir_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 438.** Igdir, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Yalova
	![AHPA76](./images/plot_tur_adm1_Yalova_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 439.** Yalova, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Karabuk
	![AHPA77](./images/plot_tur_adm1_Karabuk_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 440.** Karabuk, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Kilis
	![AHPA78](./images/plot_tur_adm1_Kilis_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 441.** Kilis, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Osmaniye
	![AHPA79](./images/plot_tur_adm1_Osmaniye_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 442.** Osmaniye, Annual Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Duzce
	![AHPA80](./images/plot_tur_adm1_Duzce_annual_pheno_anomaly_with_LTA_2003_2022.png)

	**Figure 443.** Duzce, Annual Harvest and Planting Anomaly, 2003-2023
	:::
	::::

**Monthly Anomaly Heatmaps:** To capture the subtleties of monthly fluctuations, heatmaps are presented, showcasing the anomalies in planting and harvesting areas. These heatmaps provide a visual representation of the deviations from the average, making it easier to spot patterns, irregularities, or shifts in the agricultural calendar.

* Governorate aggregate

	::::{tab-set}
	:::{tab-item} Adana
	![MHPA1](./images/plot_tur_adm1_Adana_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 444.** Adana, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Afyonkarahisar
	![MHPA2](./images/plot_tur_adm1_Afyonkarahisar_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 445.** Afyonkarahisar, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Agri
	![MHPA3](./images/plot_tur_adm1_Agri_Lebanon_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 446.** Agri, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Amasya
	![MHPA4](./images/plot_tur_adm1_El_Amasya_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 447.** Amasya, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Ankara
	![MHPA5](./images/plot_tur_adm1_Ankara_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 448.** Ankara, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Antalya
	![MHPA6](./images/plot_tur_adm1_Antalya_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 449.** Antalya, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Artvin
	![MHPA7](./images/plot_tur_adm1_Artvin_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 450.** Artvin, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Aydin
	![MHPA8](./images/plot_tur_adm1_Aydin_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 451.** Aydin, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Balikesir
	![MHPA9](./images/plot_tur_adm1_Balikesir_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 452.** Balikesir, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Bilecik
	![MHPA10](./images/plot_tur_adm1_Bilecik_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 453.** Bilecik, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Bingol
	![MHPA11](./images/plot_tur_adm1_Bingol_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 454.** Bingol, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Bitlis
	![MHPA12](./images/plot_tur_adm1_Bitlis_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 455.** Bitlis, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Bolu
	![MHPA13](./images/plot_tur_adm1_Bolu_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 456.** Bolu, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Burdur
	![MHPA14](./images/plot_tur_adm1_Burdur_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 457.** Burdur, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Bursa
	![MHPA15](./images/plot_tur_adm1_Bursa_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 458.** Bursa, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Canakkale
	![MHPA16](./images/plot_tur_adm1_Canakkale_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 459.** Canakkale, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Cankiri
	![MHPA17](./images/plot_tur_adm1_Cankiri_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 460.** Cankiri, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Corum
	![MHPA18](./images/plot_tur_adm1_Corum_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 461.** Corum, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Denizli
	![MHPA19](./images/plot_tur_adm1_Denizli_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 462.** Denizli, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Diyarbakir
	![MHPA20](./images/plot_tur_adm1_Diyarbakir_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 463.** Diyarbakir, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Edirne
	![MHPA21](./images/plot_tur_adm1_Edirne_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 464.** Edirne, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Elazig
	![MHPA22](./images/plot_tur_adm1_Elazig_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 465.** Elazig, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Erzincan
	![MHPA23](./images/plot_tur_adm1_Erzincan_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 466.** Erzincan, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Erzurum
	![MHPA24](./images/plot_tur_adm1_Erzurum_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 467.** Erzurum, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Eskisehir
	![MHPA25](./images/plot_tur_adm1_Eskisehir_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 468.** Eskisehir, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Gaziantep
	![MHPA26](./images/plot_tur_adm1_Gaziantep_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 469.** Gaziantep, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Giresun
	![MHPA27](./images/plot_tur_adm1_Giresun_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 470.** Giresun, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Gumushane
	![MHPA28](./images/plot_tur_adm1_Gumushane_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 471.** Gumushane, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Hakkari
	![MHPA29](./images/plot_tur_adm1_Hakkari_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 472.** Hakkari, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Hatay
	![MHPA30](./images/plot_tur_adm1_Hatay_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 473.** Hatay, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Isparta
	![MHPA31](./images/plot_tur_adm1_Isparta_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 474.** Isparta, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Mersin
	![MHPA32](./images/plot_tur_adm1_Mersin_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 475.** Mersin, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Istanbul
	![MHPA33](./images/plot_tur_adm1_Istanbul_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 476.** Istanbul, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Izmir
	![MHPA34](./images/plot_tur_adm1_Izmir_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 477.** Izmir, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Kars
	![MHPA35](./images/plot_tur_adm1_Kars_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 478.** Kars, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Kastamonu
	![MHPA36](./images/plot_tur_adm1_Kastamonu_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 479.** Kastamonu, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Kayseri
	![MHPA37](./images/plot_tur_adm1_Kayseri_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 480.** Kayseri, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Kirklareli
	![MHPA38](./images/plot_tur_adm1_Kirklareli_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 481.** Kirklareli, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Kirsehir
	![MHPA39](./images/plot_tur_adm1_Kirsehir_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 482.** Kirsehir, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Kocaeli
	![MHPA40](./images/plot_tur_adm1_Kocaeli_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 483.** Kocaeli, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Konya
	![MHPA41](./images/plot_tur_adm1_Konya_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 484.** Konya, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Kutahya
	![MHPA42](./images/plot_tur_adm1_Kutahya_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 485.** Kutahya, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Malatya
	![MHPA43](./images/plot_tur_adm1_Malatya_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 486.** Malatya, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Manisa
	![MHPA44](./images/plot_tur_adm1_Manisa_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 487.** Manisa, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Kahramanmaras
	![MHPA45](./images/plot_tur_adm1_Kahramanmaras_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 488.** Kahramanmaras, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Mardin
	![MHPA46](./images/plot_tur_adm1_Mardin_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 489.** Mardin, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Mugla
	![MHPA47](./images/plot_tur_adm1_Mugla_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 490.** Mugla, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Mus
	![MHPA48](./images/plot_tur_adm1_Mus_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 491.** Mus, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Nevsehir
	![MHPA49](./images/plot_tur_adm1_Nevsehir_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 492.** Nevsehir, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Nigde
	![MHPA50](./images/plot_tur_adm1_Nigde_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 493.** Nigde, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Ordu
	![MHPA51](./images/plot_tur_adm1_Ordu_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 494.** Ordu, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Rize
	![MHPA52](./images/plot_tur_adm1_Rize_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 495.** Rize, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Sakarya
	![MHPA53](./images/plot_tur_adm1_Sakarya_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 496.** Sakarya, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Samsun
	![MHPA54](./images/plot_tur_adm1_Samsun_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 497.** Samsun, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Siirt
	![MHPA55](./images/plot_tur_adm1_Siirt_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 498.** Siirt, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Sinop
	![MHPA56](./images/plot_tur_adm1_Sinop_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 499.** Sinop, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Sivas
	![MHPA57](./images/plot_tur_adm1_Sivas_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 500.** Sivas, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Tekirdag
	![MHPA58](./images/plot_tur_adm1_Tekirdag_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 501.** Tekirdag, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Tokat
	![MHPA59](./images/plot_tur_adm1_Tokat_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 502.** Tokat, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Trabzon
	![MHPA60](./images/plot_tur_adm1_Trabzon_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 503.** Trabzon, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Tunceli
	![MHPA61](./images/plot_tur_adm1_Tunceli_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 504.** Tunceli, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Sanliurfa
	![MHPA62](./images/plot_tur_adm1_Sanliurfa_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 505.** Sanliurfa, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Usak
	![MHPA63](./images/plot_tur_adm1_Usak_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 506.** Usak, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Van
	![MHPA64](./images/plot_tur_adm1_Van_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 507.** Van, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Yozgat
	![MHPA65](./images/plot_tur_adm1_Yozgat_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 508.** Yozgat, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Zonguldak
	![MHPA66](./images/plot_tur_adm1_Zonguldak_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 509.** Zonguldak, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Aksaray
	![MHPA67](./images/plot_tur_adm1_Aksaray_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 510.** Aksaray, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Bayburt
	![MHPA68](./images/plot_tur_adm1_Bayburt_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 511.** Bayburt, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Karaman
	![MHPA69](./images/plot_tur_adm1_Karaman_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 512.** Karaman, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Kirikkale
	![MHPA70](./images/plot_tur_adm1_Kirikkale_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 513.** Kirikkale, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Batman
	![MHPA71](./images/plot_tur_adm1_Batman_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 514.** Batman, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Sirnak
	![MHPA72](./images/plot_tur_adm1_Sirnak_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 515.** Sirnak, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Bartin
	![MHPA73](./images/plot_tur_adm1_Bartin_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 516.** Bartin, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Ardahan
	![MHPA74](./images/plot_tur_adm1_Ardahan_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 517.** Ardahan, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Igdir
	![MHPA75](./images/plot_tur_adm1_Igdir_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 518.** Igdir, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Yalova
	![MHPA76](./images/plot_tur_adm1_Yalova_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 519.** Yalova, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Karabuk
	![MHPA77](./images/plot_tur_adm1_Karabuk_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 520.** Karabuk, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Kilis
	![MHPA78](./images/plot_tur_adm1_Kilis_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 521.** Kilis, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Osmaniye
	![MHPA79](./images/plot_tur_adm1_Osmaniye_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 522.** Osmaniye, Monthly Harvest and Planting Anomaly, 2003-2023
	:::

	:::{tab-item} Duzce
	![MHPA80](./images/plot_tur_adm1_Duzce_monthly_pheno_anomaly_heatmap_with_LTA_2003_2022.png)

	**Figure 523.** Duzce, Monthly Harvest and Planting Anomaly, 2003-2023
	:::
	::::

## Sharepoint Data

The aggregate data in admin0, 1, 2 and 3 level, along with the maps and charts are available in the Sharepoint: [tbd] - accessible from internal network.

And in the Github directory: [https://github.com/datapartnership/turkiye-earthquake-impact/tree/main/notebooks/crop-growing-status/csv](https://github.com/datapartnership/turkiye-earthquake-impact/tree/main/notebooks/crop-growing-status/csv)

## Potential Application 

Above products provides an important starting point for continuous monitoring of the crop planting status. Continuous monitoring could inform the following assessments:

1. How many districts are behind in planting? If there is a delay in some districts, and is planting acceleration necessary?
2. How many hectares are available for the next season?
3. Is the current harvest enough for domestic consumption?

Decision makers also need phonological data to decide on resource allocation issues or policy design:

1. Planting potential for the next months: assigning the distribution of agricultural inputs.
2. Mobilization of extension workers to monitor and implement mitigation strategies: adjustment of irrigation system in anticipation of drought or flood, pest control of infestation/disease to avoid crop failure, reservoir readiness for planting season.
3. Preparation of policy recommendations: assess ongoing situation, harvest estimate, price protection.

This information is necessary for both policy makers, farmers, and other agricultural actors (cooperatives, rural businesses). Negative consequences can be anticipated months ahead and resources can be prioritized on areas with higher risk or greater potential.

## References

[^1]: M. Ozdogan, C. E. Woodcock and G. D. Salvucci, "Monitoring changes in irrigated lands in Southeastern Turkey with remote sensing," IGARSS 2003. 2003 IEEE International Geoscience and Remote Sensing Symposium. Proceedings (IEEE Cat. No.03CH37477), Toulouse, France, 2003, pp. 1570-1572, https://doi.org/10.1109/IGARSS.2003.1294178
[^2]: Kurucu, Y., Chiristina, N.K. Monitoring the impacts of urbanization and industrialization on the agricultural land and environment of the Torbali, Izmir region, Turkey. Environ Monit Assess 136, 289–297 (2008). https://doi.org/10.1007/s10661-007-9684-4
[^3]: Lobell, D. B., & Asner, G. P. (2004). Cropland distributions from temporal unmixing of MODIS data. Remote Sensing of Environment, 93(3), 412–422. https://doi.org/10.1016/j.rse.2004.08.002
[^4]: W. Xu, Y. Zhang, Y. Tian, J. Huang and B. He, "Crop Growth Monitoring Based on the MODIS Data," 2006 IEEE International Symposium on Geoscience and Remote Sensing, Denver, CO, USA, 2006, pp. 1362-1365, https://doi.org/10.1109/IGARSS.2006.352
[^5]: Evrendilek, F.; Gulbeyaz, O. Deriving Vegetation Dynamics of Natural Terrestrial Ecosystems from MODIS NDVI/EVI Data over Turkey. Sensors 2008, 8, 5270-5302. https://doi.org/10.3390/s8095270
[^6]: Yucer, A. A., Kan, M., Demirtas, M., & Kalanlar, S. (2016). The importance of creating new inheritance policies and laws that reduce agricultural land fragmentation and its negative impacts in Turkey. Land Use Policy, 56, 1–7. https://doi.org/10.1016/J.LANDUSEPOL.2016.04.029
[^7]: Tanrivermis, H. (2003). Agricultural land use change and sustainable use of land resources in the mediterranean region of Turkey. Journal of Arid Environments, 54(3), 553–564. https://doi.org/10.1006/JARE.2002.1078
[^8]: WU, W., YANG, P., TANG, H., ZHOU, Q., CHEN, Z., & Shibasaki, R. (2010). Characterizing Spatial Patterns of Phenology in Cropland of China Based on Remotely Sensed Data. Agricultural Sciences in China, 9(1), 101–112. https://doi.org/10.1016/S1671-2927(09)60073-0
[^9]: Rathcke, B., & Lacey, E. P. (1985). Phenological Patterns of Terrestrial Plants. Annual Review of Ecology and Systematics, 16(1), 179–214. https://doi.org/10.1146/ANNUREV.ES.16.110185.001143
[^10]: Canisius, F., Shang, J., Liu, J., Huang, X., Ma, B., Jiao, X., Geng, X., Kovacs, J.M., Walters, D. (2018). Tracking crop phenological development using multi-temporal polarimetric Radarsat-2 data. Remote Sensing of Environment, 210, 508–518. https://doi.org/10.1016/J.RSE.2017.07.031
[^11]: Eyduran, S.P., Akın, M., Eyduran, E. et al. Forecasting Banana Harvest Area and Production in Turkey Using Time Series Analysis. Erwerbs-Obstbau 62, 281–291 (2020). https://doi.org/10.1007/s10341-020-00490-1
[^12]: Eklundh, L., Jönsson, P. (2016). TIMESAT for Processing Time-Series Data from Satellite Sensors for Land Surface Monitoring. In: Ban, Y. (eds) Multitemporal Remote Sensing. Remote Sensing and Digital Image Processing, vol 20. Springer, Cham. https://doi.org/10.1007/978-3-319-47037-5_9
[^13]: Eklundh, L., Jönsson, P. (2015). TIMESAT: A Software Package for Time-Series Processing and Assessment of Vegetation Dynamics. In: Kuenzer, C., Dech, S., Wagner, W. (eds) Remote Sensing Time Series. Remote Sensing and Digital Image Processing, vol 22. Springer, Cham. https://doi.org/10.1007/978-3-319-15967-6_7
[^14]: Jönsson, P., & Eklundh, L. (2004). TIMESAT—a program for analyzing time-series of satellite sensor data. Computers & Geosciences, 30(8), 833–845. https://doi.org/10.1016/j.cageo.2004.05.006
[^15]: B. Tan et al., "An Enhanced TIMESAT Algorithm for Estimating Vegetation Phenology Metrics From MODIS Data," in IEEE Journal of Selected Topics in Applied Earth Observations and Remote Sensing, vol. 4, no. 2, pp. 361-371, June 2011, https://doi.org/10.1109/JSTARS.2010.2075916.
[^16]: Zanaga, D., Van De Kerchove, R., Daems, D., De Keersmaecker, W., Brockmann, C., Kirches, G., Wevers, J., Cartus, O., Santoro, M., Fritz, S., Lesiv, M., Herold, M., Tsendbazar, N.E., Xu, P., Ramoino, F., Arino, O., 2022. ESA WorldCover 10 m 2021 v200. https://doi.org/10.5281/zenodo.7254221
[^17]: Didan, K. MODIS/Aqua Vegetation Indices 16-Day L3 Global 250m SIN Grid V061. 2021, distributed by NASA EOSDIS Land Processes Distributed Active Archive Center, https://doi.org/10.5067/MODIS/MYD13Q1.061
[^18]: Didan, K. MODIS/Aqua Vegetation Indices 16-Day L3 Global 250m SIN Grid V061. 2021, distributed by NASA EOSDIS Land Processes Distributed Active Archive Center, https://doi.org/10.5067/MODIS/MYD13Q1.061
[^19]: Peel, M. C., Finlayson, B. L., and McMahon, T. A.: Updated world map of the Köppen-Geiger climate classification, Hydrol. Earth Syst. Sci., 11, 1633–1644, https://doi.org/10.5194/hess-11-1633-2007, 2007
[^20]: Irmak, S., and M. Kukal, 2022: Temporal Trends in Agriculturally Relevant Climate Indicators across Nine Agroecosystems of Turkey. J. Appl. Meteor. Climatol., 61, 631–649, https://doi.org/10.1175/JAMC-D-21-0209.1.
[^21]: Porter, J. R., & Semenov, M. A. (2005). Crop responses to climatic variation. Philosophical Transactions of the Royal Society B: Biological Sciences, 360(1463), 2021–2035. http://doi.org/10.1098/rstb.2005.1752
[^22]: Muñoz Sabater, J. (2019): ERA5-Land monthly averaged data from 1950 to present. Copernicus Climate Change Service (C3S) Climate Data Store (CDS). https://doi.org/10.24381/cds.68d2bb30
[^23]: Funk, C., Peterson, P., Landsfeld, M. et al. The climate hazards infrared precipitation with stations—a new environmental record for monitoring extremes. Sci Data 2, 150066 (2015). https://doi.org/10.1038/sdata.2015.66
[^24]: Wu, Zhuoting, Miguel Velasco, Jason C. McVay, Barry R. Middleton, John M. Vogel and Dennis G. Dye. “MODIS Derived Vegetation Index for Drought Detection on the San Carlos Apache Reservation.” International Journal of Advanced Remote Sensing and GIS 5 (2016): 1524-1538. https://doi.org/10.23953/CLOUD.IJARSG.44
[^25]: Peters, Albert J., Elizabeth A. Walter-Shea, Lei Ji, Andrés Viña, Michael J. Hayes and Mark Svoboda. “Drought Monitoring with NDVI-Based Standardized Vegetation Index.” Photogrammetric Engineering and Remote Sensing 68 (2002): 71-75.
[^26]: Kogan, F. N., 1997: Global Drought Watch from Space. Bull. Amer. Meteor. Soc., 78, 621–636, https://doi.org/10.1175/1520-0477(1997)078%3C0621:GDWFS%3E2.0.CO;2