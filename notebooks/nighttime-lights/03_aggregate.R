# Aggregate Nighttime Lights

# Do if make changes to how data processed and need to start from scratch
DELETE_DIR <- F 

if(DELETE_DIR){
  unlink(file.path(ntl_bm_dir, "FinalData", "aggregated"), recursive = T)
  dir.create(file.path(ntl_bm_dir, "FinalData", "aggregated"))
}

# Load/prep gas flaring boundaries data ----------------------------------------
# Make spatial file for:
# 1. Locations with gas flaring
# 2. Location in Syria without gas flaring

#### Gas Flaring
gf_df <- readRDS(file.path(gas_flare_dir, "FinalData", "gas_flare_locations.Rds"))

coordinates(gf_df) <- ~longitude+latitude
crs(gf_df) <- CRS("+init=epsg:4326")

gf_sf <- gf_df %>% st_as_sf() %>% st_buffer(dist = 5000)
gf_sp <- gf_sf %>% as("Spatial")

#### Country file
adm0_sp <- readOGR(dsn = file.path(adm_dir, "tur_polbnda_adm0.shp"))

#### Non GS Locations
adm0_no_gf_sp <- gDifference(adm0_sp, gf_sp, byid=F)
adm0_no_gf_sp$id <- 1

# Loop through ROIs ------------------------------------------------------------
for(roi in c("tessellation", "adm0", "adm1", "adm2")){
  
  ## Load ROI spatial file
  if(roi == "tessellation") roi_sf <- read_sf(file.path(tess_dir, "tessellation.geojson"))
  
  if(roi == "adm0"){
    roi_sf <- readOGR(dsn = file.path(adm_dir, "tur_polbnda_adm0.shp")) %>% 
      st_as_sf() %>%
      dplyr::select(adm0)
  } 
  
  if(roi == "adm1"){
    roi_sf <- readOGR(dsn = file.path(adm_dir, "tur_polbnda_adm1.shp")) %>% 
      st_as_sf() %>%
      dplyr::select(adm1)
  } 
  
  if(roi == "adm2"){
    roi_sf <- readOGR(dsn = file.path(adm_dir, "tur_polbna_adm2.shp")) %>% 
      st_as_sf() %>%
      dplyr::select(pcode)
  } 
  
  # Loop through product -------------------------------------------------------
  # VNP46A2 = daily
  # VNP46A3 = monthly
  # VNP46A4 = annually
  
  for(product in c("VNP46A2", "VNP46A3", "VNP46A4")){
    
    ## Make directory to export files - organized by ROI and prduct
    OUT_DIR <- file.path(ntl_bm_dir, "FinalData", "aggregated", paste0(roi, "_", product))
    dir.create(OUT_DIR)
    
    # Loop through rasters -----------------------------------------------------
    r_name_vec <- file.path(ntl_bm_dir, "FinalData", paste0(product, "_rasters")) %>% list.files()
    
    for(r_name_i in r_name_vec){
      
      OUT_FILE <- file.path(OUT_DIR, r_name_i %>% str_replace_all(".tif", ".Rds"))
      
      ## Check if file exists
      if(!file.exists(OUT_FILE)){
        
        ## Load raster and create rasters for just gas flaring and non gas flaring locations
        r <- raster(file.path(ntl_bm_dir, "FinalData", paste0(product, "_rasters"), r_name_i))
        
        r_gf   <- r %>% crop(gf_sp)         %>% mask(gf_sp)
        r_nogf <- r %>% crop(adm0_no_gf_sp) %>% mask(adm0_no_gf_sp)
        
        ## Extract data
        roi_sf$ntl_bm_mean       <- exact_extract(r,      roi_sf, fun = "mean")
        roi_sf$ntl_bm_gf_mean    <- exact_extract(r_gf,   roi_sf, fun = "mean")
        roi_sf$ntl_bm_no_gf_mean <- exact_extract(r_nogf, roi_sf, fun = "mean")
        
        roi_sf$ntl_bm_median       <- exact_extract(r,      roi_sf, fun = "median")
        roi_sf$ntl_bm_gf_median    <- exact_extract(r_gf,   roi_sf, fun = "median")
        roi_sf$ntl_bm_no_gf_median <- exact_extract(r_nogf, roi_sf, fun = "median")
        
        for(thresh in c(2, 5, 10)){
          
          r_t <- r
          r_t[] <- as.numeric(r[] > thresh)
          
          r_t_gf   <- r_t %>% crop(gf_sp)         %>% mask(gf_sp)
          r_t_nogf <- r_t %>% crop(adm0_no_gf_sp) %>% mask(adm0_no_gf_sp)
          
          roi_sf[[paste0("ntl_bm_prop_g", thresh)]]       <- exact_extract(r_t,      roi_sf, fun = "mean")
          roi_sf[[paste0("ntl_bm_gf_prop_g", thresh)]]    <- exact_extract(r_t_gf,   roi_sf, fun = "mean")
          roi_sf[[paste0("ntl_bm_no_gf_prop_g", thresh)]] <- exact_extract(r_t_nogf, roi_sf, fun = "mean")
          
        }
        
        ## Prep for export
        roi_df <- roi_sf
        roi_df$geometry <- NULL
        
        ## Add date
        if(product == "VNP46A2"){
          year <- r_name_i %>% substring(12,15) %>% as.numeric()
          day  <- r_name_i %>% substring(17,19) %>% as.numeric()
          date_r <- as.Date(day, origin = paste0(year, "-01-01"))
        }
        
        if(product == "VNP46A3"){
          year <- r_name_i %>% substring(12,15) %>% as.numeric()
          month  <- r_name_i %>% substring(17,19) %>% as.numeric()
          date_r <- paste0(year, "-", month, "-01") %>% ymd()
        }
        
        if(product == "VNP46A4"){
          # Just grab year
          date_r <- r_name_i %>% substring(12,15) %>% as.numeric()
        }      
        
        roi_df$date <- date_r
        
        ## Export
        saveRDS(roi_df, OUT_FILE)
      }
    }
  }
}


