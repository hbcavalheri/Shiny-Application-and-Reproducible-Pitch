cities<-data.frame("city"=c("Sao Paulo","Rio de Janeiro","Campinas","Recife",
                            "Belem","Belo Horizonte","Brasilia","Manaus","Orlando",
                            "Fort Lauderdale","New York","Miami","Los Angeles",
                            "Atlanta","Chicago","Dallas","Houston","Washington, DC"),
                   "country"=c(rep("Brazil",8),rep("United States",10)),
                   "lat"=c(-23.5505,-22.9068,-22.9099,-8.0476,-1.4558,-19.9245,
                           -15.7942,-3.1190,28.5383,26.1224,40.7128,25.7617,
                           34.0522,33.7490,41.8781,32.7767,29.7604,38.9072),
                   "long"=c(-46.6333,-43.1729,-47.0626,-34.8770,-48.4902,-43.9352,
                            -47.8822,-60.0217,-81.3792,-80.1373,-74.0060,-80.1918,
                            -118.2437,-84.3880,-87.6298,-96.7970,-95.3698,-77.0369))

flights<-data.frame("city-start"=c(rep("Sao Paulo",9),rep("Rio de Janeiro",5),
                                   rep("Campinas",2),"Recife",rep("Belem",2),
                                   rep("Belo Horizonte",2),"Brasilia","Manaus"),
                    "city-end"=c("New York","Miami","Los Angeles","Orlando",
                                 "Atlanta","Chicago","Dallas","Houston","Washington, DC",
                                 "Miami","New York","Atlanta","Houston","Orlando",
                                 "Orlando","Fort Lauderdale","Miami","Fort Lauderdale",
                                 "Miami","Miami","Orlando","Miami","Miami"),
                    "start-lat"=rep(NA,23),
                    "start-long"=rep(NA,23),
                    "end-lat"=rep(NA,23),
                    "end-long"=rep(NA,23),
                    "city.id.s"=c(rep(8,9),rep(7,5),rep(4,2),6,1,1,2,2,3,5),
                    "city.id.e"=c(8,7,6,9,1,2,3,5,10,7,8,1,5,9,9,4,7,4,7,7,9,7,7)
)

oi<-c("Sao Paulo","Rio de Janeiro","Campinas","Recife","Belem","Belo Horizonte",
      "Brasilia","Manaus")
for(i in 1:length(oi)){
    flights[which(flights$city.start==oi[i]),3]<-cities[which(cities==oi[i]),3]
    flights[which(flights$city.start==oi[i]),4]<-cities[which(cities==oi[i]),4]
}
oi1<-c("Orlando","Fort Lauderdale","New York","Miami","Los Angeles","Atlanta",
       "Chicago","Dallas","Houston","Washington, DC")
for(u in 1:length(oi1)){
    flights[which(flights$city.end==oi1[u]),5]<-cities[which(cities==oi1[u]),3]
    flights[which(flights$city.end==oi1[u]),6]<-cities[which(cities==oi1[u]),4]
}

cities
flights


mapa1 <- map_data("world")
mapa<-subset(mapa1, region %in% c("Brazil", "Uruguay", "Argentina", "French Guiana", "Suriname", "Colombia", "Venezuela",
                                  "Bolivia", "Ecuador", "Chile", "Paraguay", "Peru", "Guyana", "Panama", "Costa Rica", 
                                  "Nicaragua", "Honduras", "El Salvador", "Belize", "Guatemala", "Mexico", "Trinidad and Tobago",
                                  "Caribe", "Puerto Rico", "Dominican Republic", "Haiti", "Jamaica", "Cuba", "Bahamas", "Antiles",
                                  "Dominica", "Saba","USA","Canada"))
mapa_pais<-subset(mapa1, region %in% c("Brazil","USA"))

