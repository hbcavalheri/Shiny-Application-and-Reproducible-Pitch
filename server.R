library(shiny)
library(ggplot2)
library(maps)
library(ggrepel)
library(rsconnect)
library(devtools)
library(dplyr)
library(ggmap)

source("data.R")

shinyServer(function(input, output,session) {
   
    observe({
        x <- input$checkGroup1
        if (x==1){
            
            updateCheckboxGroupInput(session,"checkGroup2", label = NULL, 
                                     choices = list("Belem" = 1, "Belo Horizonte" = 2, 
                                                    "Brasilia"=3,"Campinas"=4,"Manaus"=5,
                                                    "Recife"=6,"Rio de Janeiro"=7,
                                                    "Sao Paulo"=8),selected = 1:8)
        }
        else
        {
            updateCheckboxGroupInput(session,"checkGroup2", label = NULL, 
                                     choices = list("Atlanta" = 1, "Chicago"=2,"Dallas"=3, 
                                                    "Fort Lauderdale"=4,"Houston"=5,
                                                    "Los Angeles"=6,"Miami"=7,
                                                    "New York"=8,"Orlando"=9,
                                                    "Washington, DC"=10),
                                     selected = 1:10)
        }
    })
    
    data <- reactive({ 
        x <- input$checkGroup1
        if (x==1){
            oi3<-subset(flights,city.id.s %in% input$checkGroup2)
            
        } else {
            oi3<-subset(flights,city.id.e %in% input$checkGroup2)
            
        }
        
            fly<-data.frame("city"=c(oi3$city.start,oi3$city.end),
                            "lat"=c(oi3$start.lat,oi3$end.lat),
                            "long"=c(oi3$start.long,oi3$end.long),
                            "group"=rep(rownames(oi3),2))

    })
    

    output$plot <- renderPlot({
        
        p <- ggplot(environment=environment())
        p<- p + geom_polygon(data=mapa, aes_string(x='long', y='lat', group = 'group'),
                              colour="darkgray", fill="#00001C" ) +
            coord_map(xlim = c(-135, -30),ylim = c(-35,55)) +
            geom_polygon( data=mapa_pais, aes_string(x='long', y='lat', group = 'group'),
                          colour="#ffffff", fill="#00001C" ) +
            theme(panel.background = element_rect(fill='#00001C',colour='#00001C'),
                  panel.grid.major = element_blank(), 
                  panel.grid.minor = element_blank(),
                  axis.line = element_blank(),
                  axis.text.x = element_blank(),
                  axis.text.y = element_blank(),
                  axis.ticks = element_blank(),
                  axis.title.x = element_blank(),
                  axis.title.y = element_blank()
            ) +
            geom_point(data=data(), aes_string(x = 'long', y ='lat'), col = "#ffffff",size=3) +
            geom_path(data =data(), aes_string('long', 'lat', group = 'group'), alpha = 0.5, 
                      color = "#fa6900") +
            geom_text_repel(data=cities, aes(x = long, y = lat, label = city), 
                            col = "#ffffff", size = 4, segment.color = NA)
        
        plot(p)
    })
    
    output$text1 <- renderTable({
        x <- input$checkGroup1
        if (x==1){
            oi3<-subset(flights,city.id.s %in% input$checkGroup2)
            oi5<-data.frame("From"=oi3$city.start,"To"=oi3$city.end)
        }else {
            oi3<-subset(flights,city.id.e %in% input$checkGroup2)
            oi5<-data.frame("From"=oi3$city.end,"To"=oi3$city.start)
        }
        oi5
    })
    

})
