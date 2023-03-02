

mcsft_buildings %>% list.files()

df <- st_read(file.path(mcsft_buildings, "122101201.geojson"))
df1 <- st_read(file.path(mcsft_buildings, "122101312.geojson"))

leaflet() %>%
  addTiles() %>%
  addPolygons(data = df) %>%
  addPolygons(data = df, color = "red")
