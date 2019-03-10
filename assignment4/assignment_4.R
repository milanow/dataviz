install.packages('rgdal')
install.packages('leaflet')
install.packages('sp')

library(sp)
library(rgdal)
library(leaflet)

setwd("/Users/tianhewang/Desktop/ANLY512/Assignment\ 4")
data <- read.csv("EasternSchools.csv", quote = "\"", header = TRUE)

leaflet() %>% addTiles()%>% setView(70.8,22.8,zoom=8) %>% addCircleMarkers(lng=70.8,lat=22.8)

# add circles & radius
baltCrime<- read.csv("bcrime500.csv", quote = "\"", header = TRUE)
bcrime<-baltCrime[ 1:500,]
bcrime2 <- bcrime[which(bcrime$Weapon=="FIREARM"), ]
bcrime3 <- bcrime[which(bcrime$Weapon=="OTHER"), ]
leaflet() %>% addProviderTiles("CartoDB.DarkMatter") %>% 
    addCircleMarkers(data=bcrime2,lng=~Longitude,lat=~Latitude, color="grey", fillColor = "blue") %>%
    addCircleMarkers(data=bcrime3,lng=~Longitude,lat=~Latitude, color="orgnge", fillColor = "red")
# opacity = , weight = (scale of 1.0)

zips<-readOGR(dsn="./cb_2017_us_county_500k",layer="cb_2017_us_county_500k") # no file extension!
zips$GEOID <- as.numeric(zips$GEOID)
zips2<-zips[zips$ZCTA5CE10 %in% c('21201','21206','21210','21214','21218','21225','21289','21236','21275','21281','21290','21202','21207','21211'), ]

leaflet() %>% addTiles() %>% setView(-72,40,zoom=7) %>% addPolygons(data=zips2)
