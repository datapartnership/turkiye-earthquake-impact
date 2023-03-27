# Business Activity Trends

Business Activity Trends During Crisis uses data about posting activity on Facebook to measure how local businesses are affected by and recover from crisis events. Given the broad presence of small businesses on the Facebook platform, this dataset aims to provide timely estimates of global business activity without the common limitations of traditional data collection methods, such as scale, speed and nonstandardization. This is a crisis-triggered dataset i.e., it has been created by Meta to support humanitarian relief for the earthquake in Turkiye. Details about this dataset can be found on [Meta's Data For Good page](https://dataforgood.facebook.com/dfg/tools/business-activity-trends). 

## Data

The Business Activity Trends dataset was provided by [Meta](https://dataforgood.facebook.com/dfg/tools/business-activity-trends) through the proposal [Türkiye Rapid Damage Needs Assessment](https://portal.datapartnership.org/readableproposal/427) of the [Development Data Partnership](https://datapartnership.org). The data consisted of daily business activity quantile information at a GADM 2 level broken down by business vertical from the 5th of February, 2023. Each cell (row) of the dataset contains data on the daily activity within a polygon-vertical combination. 


## Methodology

This method for understanding local economic activity was first described by the University of Bristol team and published in [Nature Communications](https://www.nature.com/articles/s41467-020-15405-7). Business activity is measured by the volume of posts made by business Pages on Facebook on a daily basis, where a post is defined broadly to include posts, stories and reels created by the business Page anywhere on Facebook. In practice, almost all posts are either made on the business Page itself or in Facebook Groups.

For each crisis event, a baseline posting pattern is established using the 90 days prior to the event start date. Meta then measures the daily posting activity relative to the expected posting activity based on the baseline period. Individual business Page activity is then aggregated by business vertical (proxy for economic sector) and by GADM administrative polygons geographically. 

The business activity is measured through activity quantiles. This is equivalent to the 7-day average of what University of Bristol researchers call the [aggregated probability integral transform metric](https://www.nature.com/articles/s41467-020-15405-7). It is calculated by first computing the approximate quantiles (the midquantiles in the article) of each Page’s daily activity relative to their baseline activity. The quantiles are summed and the sum is then shifted, rescaled and variance-adjusted to follow a standard normal distribution. The adjusted sum is then probability transformed through a standard normal cumulative distribution function to get a value between 0 and 1. Following this, the average of this value over the last 7 days is obtained to smooth out daily fluctuations. This metric is given a quantile interpretation since it compares the daily activity to the distribution of daily activity within the baseline period, where a value around 0.5 is considered normal activity. *This is a one-vote-per-Page metric that gives equal weight to all businesses and is not heavily influenced by businesses that post a lot.*


## Implementation

Once the data was obtained from the Meta Data For Good portal, the polygons were transformed to align with the shapefiles provided by UNOCHA. More details can be found in the attached notebook. 

<!-- ## Findings

1. There was a significant drop in business activity across the country immediately after the earthquake. 

```{figure} ../../reports/figures/ntl_trends_daily_adm2_mi9.png
---
align: center
---
Trends in nighttime lights for administrative units where there was the largest earthquake intensity (a magnitude of 9 or higher)
```

2.  -->


## Limitations

One of the biggest limitations of using this dataset is that it is based entirely on Facebook users. Therefore, it is important to note that this dataset may not be representative of the entire Turkish population evenly (Palen & Anderson, 2016). The methodology uses posts on Facebook business pages and groups to estimate changes in business activity. This framework is best used to see how quickly business have recovered from a natural disaster, in this case, the earthquake (Eyre et. al., 2020). The methodology relies on the assumption that businesses tend to publish more posts when they are open and fewer when they are closed, hence analysing the aggregated posting activity of a group of businesses over time it is possible to infer when they are open or closed. 


## Citations

Eyre, R., De Luca, F., & Simini, F. (2020). Social media usage reveals recovery of small businesses after natural hazard events. Nature communications, 11(1), 1629.

Palen, L., & Anderson, K. M. (2016). Crisis informatics—New data for extraordinary times. Science, 353(6296), 224-225.
