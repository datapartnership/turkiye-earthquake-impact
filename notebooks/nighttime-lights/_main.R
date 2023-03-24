# Nighttime Lights Analysis
# Main Script

# Filepaths --------------------------------------------------------------------
#### Root paths
if(Sys.info()[["user"]] == "robmarty"){
  git_dir  <- "~/Documents/Github/turkiye-earthquake-impact"
  data_dir <- file.path("~", "Turkiye Earthquake Impact", "Data")
} 

#### Data Paths from Root
gas_flare_dir <- file.path(data_dir, "Global Gas Flaring")
ntl_bm_dir    <- file.path(data_dir, "NTL BlackMarble")
tess_dir      <- file.path(data_dir, "tessellation")
adm_dir       <- file.path(data_dir, "turkey_administrativelevels0_1_2")
eq_usgs_dir   <- file.path(data_dir, "earthquake_intensity")

#### Path to output figures
fig_dir       <- file.path(git_dir, "reports", "figures")

# Packages ---------------------------------------------------------------------
pacman::p_load(dplyr,
               readr,
               readxl,
               janitor,
               geodata,
               sf,
               sp,
               rgdal,
               rgeos,
               raster,
               lubridate,
               exactextractr,
               stringr,
               ggplot2,
               purrr,
               tidyverse,
               leaflet,
               ggpubr,
               devtools)

if(!require(blackmarbler)){
  devtools::install_github("ramarty/blackmarbler")
}

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
  
  ntl_gir_dir <- file.path(git_dir, "notebooks", "nighttime-lights")
  
  ## Clean data
  source(file.path(ntl_gir_dir, "01_clean_gas_flaring_data.R"))
  source(file.path(ntl_gir_dir, "02_download_black_marble.R"))
  source(file.path(ntl_gir_dir, "03_aggregate.R"))
  source(file.path(ntl_gir_dir, "04_append.R"))
  
  ## Analysis / figures
  source(file.path(ntl_gir_dir, "05_avg_ntl_by_period.R"))
  source(file.path(ntl_gir_dir, "05_map_ntl_annual.R"))
  source(file.path(ntl_gir_dir, "05_maps_ntl_changes.R"))
  source(file.path(ntl_gir_dir, "05_ntl_trends_daily.R"))
  source(file.path(ntl_gir_dir, "05_ntl_trends_monthly.R"))
  
}



