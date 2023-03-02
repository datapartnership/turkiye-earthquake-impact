# Convert OSM from .shp to .Rds

# OSM files are orignally downloaded as shapefiles (.shp). However, these files
# are large and take a long time to load. Rds files are compressed and faster
# for R to load.

shp_files <- file.path(osm_dir, "rawdata") %>%
  list.files(pattern = "*.shp")

for(shp_file_i in shp_files){
  
  rds_file_i <- shp_file_i %>% str_replace_all(".shp", ".Rds")
  
  OUT_FILE <- file.path(osm_dir, "finaldata", "rds_files", rds_file_i)
  
  if(!file.exists(OUT_FILE)){
    df <- readOGR(dsn = file.path(osm_dir, "rawdata", shp_file_i))
    saveRDS(df, OUT_FILE)
  }
}
