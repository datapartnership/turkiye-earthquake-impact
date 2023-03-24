# Download Black Marble Data

# Bearer Key -------------------------------------------------------------------
#### Bearer token from NASA
# To get token, see: https://github.com/ramarty/download_blackmarble
BEARER <- read_csv("~/Desktop/bearer_bm.csv") %>% pull(token)

# Define Region of Interest ----------------------------------------------------
# Polygon around Turkey and Syria. Also grab Syria in case useful to look at impacts
# there.

## Grab polygons
syr_sp <- gadm(country = "SYR", level=0, path = tempdir()) 
tur_sp <- gadm(country = "TUR", level=0, path = tempdir()) 

## Combine Syria and Turkey into one polygon
roi_sp <- rbind(syr_sp, tur_sp)
roi_sp$id <- 1
roi_sp <- raster::aggregate(roi_sp, by = "id")
roi_sf <- roi_sp %>% st_as_sf()

# Download data ----------------------------------------------------------------
## Annual Data
bm_raster(roi_sf = roi_sf,
          product_id = "VNP46A4",
          date = 2012:2021,
          bearer = BEARER,
          output_location_type = "file",
          file_dir = file.path(ntl_bm_dir, "FinalData", "VNP46A4_rasters"))

## Monthly Data
bm_raster(roi_sf = roi_sf,
          product_id = "VNP46A3",
          date = seq.Date(from = ymd("2022-01-01"), to = Sys.Date(), by = "month"),
          bearer = BEARER,
          output_location_type = "file",
          file_dir = file.path(ntl_bm_dir, "FinalData", "VNP46A3_rasters"))

## Daily Data
bm_raster(roi_sf = roi_sf,
          product_id = "VNP46A2",
          date = seq.Date(from = ymd("2023-01-01"), to = Sys.Date(), by = "day"),
          bearer = BEARER,
          output_location_type = "file",
          file_dir = file.path(ntl_bm_dir, "FinalData", "VNP46A2_rasters"))






# Download annual data ---------------------------------------------------------
# Downloads a raster for each month. If raster already created, skips calling 
# function.



years <- 2012:2021

for(year_i in years){
  
  OUT_FILE <- file.path(ntl_bm_dir,
                        "FinalData",
                        "VNP46A4_rasters",
                        paste0("bm_VNP46A4_",year_i,".tif"))
  
  if(!file.exists(OUT_FILE)){
    r <- bm_raster(roi_sf = roi_sf,
                   product_id = "VNP46A4",
                   date = year_i,
                   bearer = BEARER)
    
    writeRaster(r, OUT_FILE)
  }
}

# Download monthly data --------------------------------------------------------
# Downloads a raster for each month. If raster already created, skips calling 
# function.

months <- seq.Date(from = ymd("2022-01-01"),
                   to = floor_date(Sys.Date(), unit = "months"),
                   by = "month") %>%
  as.character()

for(month_ymd in months){
  
  year  <- month_ymd %>% year()
  month <- month_ymd %>% month()
  
  OUT_FILE <- file.path(ntl_bm_dir,
                        "FinalData",
                        "VNP46A3_rasters",
                        paste0("bm_VNP46A3_",year,"_",pad2(month),".tif"))
  
  if(!file.exists(OUT_FILE)){
    r <- bm_raster(roi_sf = roi_sf,
                   product_id = "VNP46A3",
                   date = month_ymd,
                   bearer = BEARER)
    
    writeRaster(r, OUT_FILE)
  }
}


# Download daily data --------------------------------------------------------
# * Downloads a raster for each daily If raster already created, skips calling 
#   function.
# * Some days do not have data, which will cause an error. Use trycatch to skip
# * Both VNP46A1 and VNP46A2 are daily data. VNP46A2 has more corrections, but
#   VNP46A1 has more recent data. We download both.

dates <- seq.Date(from = ymd("2023-01-01"),
                  to = Sys.Date(),
                  by = "day") %>%
  as.character() %>%
  rev()

for(date in dates){
  for(product_id in c("VNP46A2")){ # , "VNP46A1"
    
    year <- date %>% year()
    day  <- date %>% yday()
    
    OUT_FILE <- file.path(ntl_bm_dir,
                          "FinalData",
                          paste0(product_id, "_rasters"),
                          paste0("bm_",product_id,"_",year,"_",pad3(day),".tif"))
    
    if(!file.exists(OUT_FILE)){
      
      print(OUT_FILE)
      
      out <- tryCatch(
        {
          
          r <- bm_raster(roi_sf = roi_sf,
                         product_id = product_id,
                         date = date,
                         bearer = BEARER)
          
          writeRaster(r, OUT_FILE)
        },
        error=function(cond) {
          print("Error! Skipping.")
        }
      )
      
    }
  }
}

