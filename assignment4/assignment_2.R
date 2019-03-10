install.packages('rgdal')
install.packages('leaflet')

library(rgdal)
library(leaflet)

setwd("/Users/tianhewang/Desktop/ANLY512/Assignment\ 4")
data <- read.csv("EasternSchools.csv", quote = "\"", header = TRUE)

leaflet() %>% addTiles() 

# %>% setView(70.8,22.8,zoom=8) %>% addCircleMarkers(lng=70.8,lat=22.8)



