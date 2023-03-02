# Nighttime Lights Analysis
# Main Script

# Filepaths --------------------------------------------------------------------
#### Root paths
if(Sys.info()[["user"]] == "robmarty"){
  git_dir  <- "~/Documents/Github/turkiye-rapid-damage-and-needs-assessment"
  data_dir <- file.path("~", "Dropbox", "World Bank", "Side Work", 
                        "Turkiye Earthquake Impact", "Data")
} 

#### Paths from root
osm_dir         <- file.path(data_dir, "OpenStreetMaps")
mcsft_buildings <- file.path(data_dir, "microsoft_building_footprints_data", "building_footprints_turkiye")

# Packages ---------------------------------------------------------------------
library(sf)
library(raster)
library(rgeos)
library(rgdal)
library(stringr)
library(leaflet)
library(leaflet.extras)

# Scripts ----------------------------------------------------------------------




