# Nighttime Lights Analysis
# Main Script

# Filepaths --------------------------------------------------------------------
#### Root paths
if(Sys.info()[["user"]] == "robmarty"){
  git_dir  <- "~/Documents/Github/turkiye-rapid-damage-and-needs-assessment"
  data_dir <- file.path("~", "Dropbox", "World Bank", "Side Work", 
                        "Turkiye Earthquake Impact", "Data")
  # fig_dir <- file.path("~", "Dropbox", "World Bank", "Side Work", 
  #                       "Turkiye Earthquake Impact", "Outputs", "figures")
} 

#### Paths from Root
gas_flare_dir <- file.path(data_dir, "Global Gas Flaring")
ntl_bm_dir    <- file.path(data_dir, "NTL BlackMarble")
tess_dir      <- file.path(data_dir, "tessellation")
adm_dir       <- file.path(data_dir, "turkey_administrativelevels0_1_2")
eq_usgs_dir       <- file.path(data_dir, "earthquake_intensity")

fig_dir <- file.path(git_dir, "reports", "figures")

# Packages ---------------------------------------------------------------------
library(dplyr)
library(readr)
library(readxl)
library(janitor)
library(geodata)
library(sf)
library(sp)
library(rgdal)
library(rgeos)
library(raster)
library(lubridate)
library(blackmarbler)
library(exactextractr)
library(stringr)
library(ggplot2)
library(purrr)
library(tidyverse)
library(leaflet)
library(ggpubr)

# Functions --------------------------------------------------------------------
pad3 <- function(x){
  if(nchar(x) == 1) out <- paste0("00", x)
  if(nchar(x) == 2) out <- paste0("0", x)
  if(nchar(x) == 3) out <- paste0(x)
  return(out)
}
pad3 <- Vectorize(pad3)

pad2 <- function(x){
  if(nchar(x) == 1) out <- paste0("0", x)
  if(nchar(x) == 2) out <- paste0(x)
  return(out)
}
pad2 <- Vectorize(pad2)

# Scripts ----------------------------------------------------------------------
if(F){
  
  ntl_gir_dir <- file.path(git_dir, "notebooks", "ntl-analysis")
  
  source(file.path(ntl_gir_dir, "01_clean_gas_flaring_data.R"))
  source(file.path(ntl_gir_dir, "02_download_black_marble.R"))
  source(file.path(ntl_gir_dir, "03_aggregate.R"))
  source(file.path(ntl_gir_dir, "04_append.R"))
  
}



