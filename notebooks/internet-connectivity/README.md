# Internet Connectivity Post Earthquake

To detect changes in network connectivity, three datasets are used - Meta's Network Connectivity Maps during crisis, Ookla's SPeedtest Intelligence dataset and Ookla's Mobile Coverage Scan dataset. These datasets were provided by [Meta](https://dataforgood.facebook.com/dfg/tools/business-activity-trends) and [Ookla](https://www.ookla.com/ookla-for-good) through the proposal [Türkiye Rapid Damage Needs Assessment](https://portal.datapartnership.org/readableproposal/427) of the [Development Data Partnership](https://datapartnership.org).

## Data

### Meta Network Coverage Maps

Network Coverage maps show where Facebook users have cellular connectivity at a 2G, 3G or 4G connection type through their mobile device. This is determined based on the types of cell sites that users connect to in order to update their Facebook app’s data, which causes data to be sent between a user's device and the Facebook servers that host the app. In other words, this measures the estimated range, approximate coverage area and type of network connection based on the cell site IDs and locations that the users’ devices report. It is not based on data obtained from telecommunication services. Meta creates three types of Network Coverage Maps - Active Network Coverage, Network Coverage Undetcted and Probability of Network Coverage. For the purpose of this case, the Network Coverage Undetected maps were used.

The Network Coverage Undetected map shows grid tiles for which there is no certainty of having network coverage on that date because no users’ devices reported connecting to cell sites there, but where there was observed coverage during the 30-day baseline period. The data is published at a Bing tile level 16.  This is equivalent to roughly 600 meters on a side near the equator or the size of 2 city blocks.

### Ookla Speedtest Connectivity

The Ookla Speedtest connectivity dataset relies on user-generated speedtest information. Everytime a users conducts a speedtest on their laptop or mobile phone using fixed or broadband internet connections, it is recorded along with the latitude and longistude of the test, the ISP provider of the user. This data is then processed to generate indicators such as number of users who conducted the test, download speed, upload speed and latency.

## Methodology

### Meta Network Coverage Maps

In areas affected by a crisis, it is very difficult to distinguish between a nonoperational cell site and one that didn't receive signals because users have left the area. This methodology relies on a phone's reporting of cell IDs, and found that different phone models occasionally report different cell IDs for the same physical base station. This leads to overcounting the number of cell sites covering a grid tile.

In addition, those incorrect cell IDs lead to fewer location samples for the correct cell ID and create additional unreliable coverage polygons for the incorrectly reported cell IDs. As the method relies on “last known location” for coverage area estimates, discrepancies between the actual location and the reported location of a user’s device may be included in the samples for any given cell site, especially when the cell site is close to an airport.

### Ookla Speedtest Connectivity

Detailed information about the methodology and sampling used for Ookla Speedtest data extracts can be found [here](https://worldbankgroup.sharepoint.com.mcas.ms/teams/DevelopmentDataPartnershipCommunity-WBGroup/Shared%20Documents/Forms/AllItems.aspx?csf=1&web=1&e=Yvwh8r&cid=fccdf23e%2D94d5%2D48bf%2Db75d%2D0af291138bde&FolderCTID=0x012000CFAB9FF0F938A64EBB297E7E16BDFCFD&id=%2Fteams%2FDevelopmentDataPartnershipCommunity%2DWBGroup%2FShared%20Documents%2FProjects%2FData%20Lab%2FTurkiye%20Earthquake%20Impact%2FData%2Fookla%5Fspeedtest%2FSpeedtest%5FTest%5FMethodology%5Fv1%2E8%5F2023%2D01%2D01%2Epdf&viewid=80cdadb3%2D8bb3%2D47ae%2D8b18%2Dc1dd89c373c5&parent=%2Fteams%2FDevelopmentDataPartnershipCommunity%2DWBGroup%2FShared%20Documents%2FProjects%2FData%20Lab%2FTurkiye%20Earthquake%20Impact%2FData%2Fookla%5Fspeedtest)

## Implementation

Once the data was obtained from the Meta Data For Good portal and Ookla Speedtest portal, the point data were transformed to align with the shapefiles provided by UNOCHA. More details can be found in the attached notebook.

## Limitations

The Limitations of the Meta Network Connectivity Maps is the fact that it relies on Facebook users' data alone. The limitation of Ookla's Speedtest connectivity relies on user-generated tests. Although the average number of users who take a test remain relatively consistent per month, it is subject to fluctuation. The dataset also does not contain information about the same latitude and longitude consistently. However, given aggregated data is used (at admin 1 or admin 2 levels), the findings can still be useful.

## Next Steps

The Next Steps for Ookla Speedtest connectivity would be to compare the weekly users to a 3 month prior baseline and plot the changes in average users over time.
