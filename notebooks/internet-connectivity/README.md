# Internet Connectivity Post Earthquake

To detect changes in network connectivity, three datasets are used - Meta's Network Connectivity Maps during crisis, Ookla's SPeedtest Intelligence dataset and Ookla's Mobile Coverage Scan dataset. These datasets were provided by [Meta](https://dataforgood.facebook.com/dfg/tools/business-activity-trends) and [Ookla](https://www.ookla.com/ookla-for-good) through the proposal [Türkiye Rapid Damage Needs Assessment](https://portal.datapartnership.org/readableproposal/427) of the [Development Data Partnership](https://datapartnership.org).


## Data

### Meta Network Coverage Maps

Network Coverage maps show where Facebook users have cellular connectivity at a 2G, 3G or 4G connection type through their mobile device. This is determined based on the types of cell sites that users connect to in order to update their Facebook app’s data, which causes data to be sent between a user's device and the Facebook servers that host the app. In other words, this measures the estimated range, approximate coverage area and type of network connection based on the cell site IDs and locations that the users’ devices report. It is not based on data obtained from telecommunication services. Meta creates three types of Network Coverage Maps - Active Network Coverage, Network Coverage Undetcted and Probability of Network Coverage. For the purpose of this case, the Network Coverage Undetected maps were used. 

The Network Coverage Undetected map shows grid tiles for which there is no certainty of having network coverage on that date because no users’ devices reported connecting to cell sites there, but where there was observed coverage during the 30-day baseline period. The data is published at a Bing tile level 16.  This is equivalent to roughly 600 meters on a side near the equator or the size of 2 city blocks. 

### Ookla Speedtest Connectivity




## Methodology

### Meta Network Coverage Maps



## Implementation

Once the data was obtained from the Meta Data For Good portal and Ookla Speedtest portal, the point data were transformed to align with the shapefiles provided by UNOCHA. More details can be found in the attached notebook. 


## Limitations

The Limitations of the Meta Network Connectivity Maps


## Next Steps

The Next Steps for Ookla Speedtest connectivity would be to compare the weekly users to a 3 month prior baseline and plot the changes in average users over time. 