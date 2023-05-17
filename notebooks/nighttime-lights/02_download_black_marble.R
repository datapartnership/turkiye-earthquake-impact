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
          date = 2012:2022,
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
          date = seq.Date(from = ymd("2022-11-01"), to = Sys.Date(), by = "day"),
          bearer = BEARER,
          output_location_type = "file",
          file_dir = file.path(ntl_bm_dir, "FinalData", "VNP46A2_rasters"))
