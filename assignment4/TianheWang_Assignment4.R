library(rgdal)
library(leaflet)
library(dplyr)
library(htmltools)
library(tidyr)
library(ggplot2)
library(expss)

setwd("/Users/tianhewang/Desktop/ANLY512/Assignment\ 4")
allSchools <- read.csv("EasternSchools.csv", quote = "\"", header = TRUE)
allSchools <- mutate(allSchools, raceOTHERS = allSchools$raceWHITE + allSchools$raceAMERIND + allSchools$raceHI + allSchools$raceBLACK)
school_lvl1 <- allSchools[which(allSchools$LEVEL==1), ]
school_lvl2 <- allSchools[which(allSchools$LEVEL==2), ]
school_lvl3 <- allSchools[which(allSchools$LEVEL==3), ]
school_lvl4 <- allSchools[which(allSchools$LEVEL==4), ]

lvl1_schools = leaflet() %>% addProviderTiles("CartoDB.DarkMatter") %>% 
                  addCircleMarkers(data=school_lvl1,lng=~LON,lat=~LAT, color="red", fillColor = "red")
lvl2_schools = leaflet() %>% addProviderTiles("CartoDB.DarkMatter") %>% 
                  addCircleMarkers(data=school_lvl2,lng=~LON,lat=~LAT, color="yellow", fillColor = "yellow")
lvl3_schools = leaflet() %>% addProviderTiles("CartoDB.DarkMatter") %>% 
                  addCircleMarkers(data=school_lvl3,lng=~LON,lat=~LAT, color="blue", fillColor = "blue")
lvl4_schools = leaflet() %>% addProviderTiles("CartoDB.DarkMatter") %>% 
                  addCircleMarkers(data=school_lvl4,lng=~LON,lat=~LAT, color="green", fillColor = "green")

leaflet_grid <- 
  tagList(
    tags$table(width = "100%",
       tags$tr(
         tags$td(lvl1_schools),
         tags$td(lvl2_schools)
       ),
       tags$tr(
         tags$td(lvl3_schools),
         tags$td(lvl4_schools)
       )
    )
  )

browsable(leaflet_grid)

zips<-readOGR(dsn="./cb_2017_us_county_500k",layer="cb_2017_us_county_500k") # no file extension!

leaflet() %>% addTiles() %>%
  addCircleMarkers(data = a, radius = 3, color = "blue", weight = 3, opacity = 1, fill = TRUE, fillColor = "blue", fillOpacity = 0.2, label = ~city) %>%
  addCircleMarkers(data = b, radius = 3, color = "yellow", weight = 3, opacity = 0.5, fill = TRUE, fillColor = "red", fillOpacity = 0.2, label = ~city) %>%
  addRectangles(lng1 = -75.00000, lat1 = 39.90000, lng2 = -75.30000, lat2 = 40.10000, color = "red", weight = 5,
                fillColor = "transparent") %>%
  addLabelOnlyMarkers(lng = -75.1652, lat = 39.9526, label = "Philadelphia", 
                      labelOptions = labelOptions(noHide = T, textsize = "10px")) %>%
  addLegend("topright", colors = c("blue", "yellow"), labels = c("Magnet School", "Charter School"), title = "Type of Speciality School", opacity = 1)
