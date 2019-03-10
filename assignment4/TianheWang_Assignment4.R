library(rgdal)
library(leaflet)
library(dplyr)
library(htmltools)
library(tidyr)
library(ggplot2)

setwd("D:\\Work\\HU\\dataviz\\assignment4")
allSchools <- read.csv("EasternSchools.csv", quote = "\"", header = TRUE)
allSchools <- mutate(allSchools, raceOTHERS = allSchools$raceWHITE + allSchools$raceAMERIND + allSchools$raceHI + allSchools$raceBLACK)
school_lvl1 <- allSchools[which(allSchools$LEVEL==1), ]
school_lvl2 <- allSchools[which(allSchools$LEVEL==2), ]
school_lvl3 <- allSchools[which(allSchools$LEVEL==3), ]
school_lvl4 <- allSchools[which(allSchools$LEVEL==4), ]

lvl1_schools = leaflet() %>% addTiles() %>% 
                  addCircleMarkers(data=school_lvl1,lng=~LON,lat=~LAT, 
                                   radius = 3, color="red", fillColor = "red")
lvl2_schools = leaflet() %>% addTiles() %>% 
                  addCircleMarkers(data=school_lvl2,lng=~LON,lat=~LAT, 
                                   radius = 3, color="yellow", fillColor = "yellow")
lvl3_schools = leaflet() %>% addTiles() %>% 
                  addCircleMarkers(data=school_lvl3,lng=~LON,lat=~LAT, 
                                   radius = 3, color="blue", fillColor = "blue")
lvl4_schools = leaflet() %>% addTiles() %>% 
                  addCircleMarkers(data=school_lvl4,lng=~LON,lat=~LAT, 
                                   radius = 3, color="green", fillColor = "green")

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

counties <- readOGR(dsn="./Pennsylvania_School_Districts",layer="cb_2016_42_unsd_500k")
grades01 = school_lvl1$G01

G01_grades = leaflet(counties) %>% addTiles() %>%
  addCircleMarkers(data = school_lvl1, radius = 1.5, fill = FALSE, color = "red", opacity = (grades01-20)/100,
                   lng=~LON, lat=~LAT) %>%
  addRectangles(lng1 = -74.90000, lat1 = 40.10000, lng2 = -75.40000, lat2 = 40.35000, color = "black", weight = 5,
                fillColor = "transparent") %>%
  addRectangles(lng1 = -75.70000, lat1 = 40.50000, lng2 = -75.10000, lat2 = 40.75000, color = "black", weight = 5,
                fillColor = "transparent")
G01_grades


m_school = allSchools %>% filter(magnetSchoolStatus == "Yes")
c_school = allSchools %>% filter(isCHARTER == "Yes")

school_grade = leaflet(counties) %>% addTiles() %>%
  addPolygons(weight=1,color="blue",fillOpacity = .1) %>%
  addCircleMarkers(data = m_school, radius = 2, color = "yellow", weight = 3, opacity = (grades01)/100, label = ~city) %>%
  addCircleMarkers(data = c_school, radius = 2, color = "blue", weight = 3, opacity = (grades01)/100, label = ~city) %>%
  addLegend("topright", colors = c("red", "green"), labels = c("magnet school", "charter school"), title = "Type of School", opacity = 1)
school_grade

asians = leaflet() %>% addTiles() %>% 
  addCircleMarkers(data=allSchools,lng=~LON,lat=~LAT, 
                   radius = 3, opacity = allSchools$raceASIAN / 100, color="purple", fillColor = "purple")
asians
