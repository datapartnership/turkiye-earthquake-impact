# Foundational Datasets and Data Products Summary

## Foundational Datasets

**Foundational Datasets** refer to **all** datasets used in the analytics prepared for a project. The Foundational Datasets table includes a description of the data and their update frequency, as well as access links and contact information for questions about use and access. Users should not require any datasets not included in this table to complete the analytical work for the Data Good.

Following is list of all Foundational Datasets used in this Data Good:

```{note}
**Project Sharepoint** links are only accessible to the project team. For permissions to access these data, please write to the contact provided. The **Development Data Hub** is the World Bank's central data catalogue and includes meta-data and license information.
```

Where feasible, all datasets that can be obtained through the Development Data Hub have been placed in a special collection: *forthcoming*

| ID  | Name | License | Description | Update Frequency | Access | Contact |
| --- | ---- | ------- | ----------- | ---------------- | ------ | ------- |
| 1      | Türkiye - Subnational Administrative Boundaries                       | Open                   | Admin boundaries up to level 3                                                                                        | Every year (Last updated in 27 February 2023)                                      | [HDX](https://data.humdata.org/dataset/cod-ab-tur)                                     | [Sahiti Sarva](mailto:ssarva@worldbank.org), Data Lab                     |
| 2      | Mobility Data                           | Proprietary            | Timestamped lat/lon points provided by Veraset Movement                               | Weekly (Daily possible)                                          | [Development Data Partnership](https://portal.datapartnership.org/submitproposal)                                                       |  [Development Data Partnership](mailto:datapartnership@worldbank.org)                                |
| 3   |  Meta Business Activity Trends during crisis   |   Proprietary      |     Timestamped at GADM2 Level        |      Daily after the earthquake            |  [Development Data Partnership](https://portal.datapartnership.org/submitproposal)       |    [Development Data Partnership](mailto:datapartnership@worldbank.org)      |
| 4   |  Meta Network Connectivity Maps during crisis    |    Proprietary     |    Timestamped at Bing Tile Level 16 (~600m)     |      Daily after the earthquake            |   [Development Data Partnership](https://portal.datapartnership.org/submitproposal)     |   [Development Data Partnership](mailto:datapartnership@worldbank.org)      |
| 5   |  Ookla Speedtest Intelligence    |  Proprietary       |      Timestamped lat/long points       |       Daily           |   [Development Data Partnership](https://portal.datapartnership.org/submitproposal)     |  [Development Data Partnership](mailto:datapartnership@worldbank.org)        |
| 6   |  BlackMarble Night Lights Data    |    Open     |      Timestamped lat/lon points       |      Daily            |        |         |
| 7   |  Premise Household needs survey    |   Proprietary      |   Timestamped lat/lon points of survey results          |       Will not be updated           |   [Development Data Partnership](https://portal.datapartnership.org/submitproposal)     |    [Development Data Partnership](mailto:datapartnership@worldbank.org)     |

## Data Products Summary

**Data Products** are produced using the **Foundational Datasets** and can be further used to generate indicators and insights. All Data Products include documentation, references to original data sources (and/or information on how to access them), and a description of their limitations.

Following is a summary of Data Products used in this Data Good:

| ID  | Name | Description | Limitations | Foundational Datasets Used (ID#) |
| --- | ---- | ----------- | ----------- | -------------------------------- |
|  A         |  Observed POI Visitation based on mobility traces  |     Daily aggregated analysis of trip   patterns through formal and informal checkpoints, over time.                       |     Convenience sampling; Sample size is    limited                                                                                                                                                   |     1,2                    |
| B   | Observed changes in Business Activity Trends     |    Daily and weekly aggregated business activity trends per business vertical         |   Only uses data from Facebook users          |     1, 4                             |
| C   |  Observed changes in NightLight Data    |   Weekly aggregated trends in nightlight connectivity          |             |          1,6                        |
| D   |  Observed changes in Internet Connectivity    |     Daily and weekly aggregated by admin 1 and admin 2 levels        |    Only uses data from users who volunatrily conducted a speedtest or are Facebook users.         |          1,4,5                        |
