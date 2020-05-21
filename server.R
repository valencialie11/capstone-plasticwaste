function(input, output) {
  
  output$plastic <- renderPlotly({
    
    if (input$asc == "Ascending") {
      options(scipen = 999)
      plot1 <- ggplot(data = plasticprod_new, mapping = aes(x = reorder(Year,-sum_ton), y = sum_ton, text = paste("Year:", Year, "<br>", "Amount of plastic produced:", sum_ton))) +
        geom_col(aes(fill = sum_ton)) +
        scale_fill_viridis_c() +
        labs(x = "Year", y = "Total amount of plastic produced") +
        coord_flip() +
        theme_minimal() +
        theme(legend.position = "none")
      }
    
    else if (input$asc == "Descending") {
      options(scipen = 999)
      plot1 <- ggplot(data = plasticprod_new, mapping = aes(x = reorder(Year,sum_ton), y = sum_ton, text = paste("Year:", Year, "<br>", "Amount of plastic produced:", sum_ton))) +
        geom_col(aes(fill = sum_ton)) +
        scale_fill_viridis_c() +
        coord_flip() +
        labs(x = "Year", y = "Total amount of plastic produced") +
        theme_minimal() +
        theme(legend.position = "none")
    }
    
    else {
      options(scipen = 999)
      plot1 <- ggplot(data = plasticprod_new, mapping = aes(x = Year, y = sum_ton, text = paste("Year:", Year, "<br>", "Amount of plastic produced:", sum_ton))) +
        geom_col(aes(fill = sum_ton)) +
        scale_fill_viridis_c() +
        coord_flip() +
        labs(x = "Year", y = "Total amount of plastic produced") +
        theme_minimal() +
        theme(legend.position = "none")
    }
    
    ggplotly(plot1, tooltip = "text")
    
    
  })
   
 
  output$pie <- renderPlot({
    
    inadeq2 <- inadeq %>% 
      filter(Entity == input$choice)
    
    ggplot(data = inadeq2, mapping = aes(x = "", y = value, fill = names)) +
      geom_bar(width = 1, stat = "identity") + coord_polar("y", start=0) +
      theme(legend.title = element_blank(),
            axis.title.y = element_blank(),
            axis.title.x = element_blank()) +
      scale_fill_discrete(name = "", labels = c("Share of plastic adequately managed", "Share of plastic INADEQUATELY managed"))
    
  })
  
  output$Good <- renderValueBox({
    inadeq3 <- inadequately_managed %>% 
      filter(Entity == input$choice)
    
    valueBox(paste0(inadeq3$remain, "%"), "Adequately managed", icon("check-circle"), color = "green")
    
  })
  output$Bad <- renderValueBox({
    inadeq3 <- inadequately_managed %>% 
      filter(Entity == input$choice)
    
    valueBox(paste0(inadeq3$share, "%"), "Inadequately managed", icon("times-circle"), color = "red")
  })
  
  output$Worst <- renderValueBox({
    valueBox("North Korea", "Worst Country", icon = icon("trophy"))
    
  })
  
  output$gdpmis <- renderPlotly({
    
    plot_2 <- ggplot(data = gdp_newnewnew, mapping = aes(x = Mismanaged, y = GDP)) +
      geom_jitter(aes(color = Entity)) +
      geom_smooth(method = "lm") +
      theme_minimal() +
      labs(x = "Mismanaged plastic waste per capita", y = "GDP per capita") +
      theme(legend.position = "none") 
    
    ggplotly(plot_2)
    })

  output$handling <- renderPlot({

      fatest <- fatenews %>% 
        filter(Year == input$slide)
    
  ggplot(data = fatest, mapping = aes(x = "", y = sum_values, fill = Entity)) +
    geom_bar(width = 1, stat = "identity") + coord_polar("y", start=0) +
    theme(legend.title = element_blank(),
          axis.title.y = element_blank(),
          axis.title.x = element_blank()) +
    scale_fill_discrete(name = "", labels = c("Discarded", "Incinerated", "Recycled"))
 })
  
  output$overall <- renderPlotly({
    

    plot_3 <- ggplot(data = fatenews, mapping = aes(x = Year, y = sum_values, text = paste(Entity, "<br>", "Year:", Year, "<br>", "Percentage:", paste0(sum_values, "%")))) +
      geom_col(aes(fill = Entity)) +
      theme_minimal() +
      scale_fill_viridis_d() +
      labs(x = "Year", y = "Percentage of plastic waste that is...")
    
    ggplotly(plot_3, tooltip = "text")
    
  })
  
  output$Discarded <- renderValueBox({
    
    faterD <- fateD %>% 
      filter(Year == input$slide)
    
    valueBox(
      "", paste0(faterD$sum_values, "%"), icon = icon("trash"),
      color = "red")})
  
  output$Incinerated <- renderValueBox({
    
    faterI <- fateI %>% 
      filter(Year == input$slide)
    
    valueBox(
      "", paste0(faterI$sum_values, "%"), icon = icon("fire"),
      color = "green")})
  
  output$Recycled <- renderValueBox({
    
    faterR <- fateR %>% 
      filter(Year == input$slide)
    
    valueBox("",
      paste0(faterR$sum_values, "%"), icon = icon("recycle"),
      color = "blue")})
  
  output$sea <- renderPlotly({
    
    if (input$buttons == "Macroplastics"){
    plot_5 <- ggplot(data = macromicro, mapping = aes(x = Year, y = `Macroplastics (>0.5cm) (tonnes)`, text = paste("Year:", Year, "<br>", "Amount of Macroplastics:", paste0(`Macroplastics (>0.5cm) (tonnes)`, " tonnes"), "<br>", Entity))) +
        geom_line(aes(color = Entity), group = 1) +
        labs(x = "Year", "Amount of Macroplastics") +
        theme_minimal()
    }
    
    else if (input$buttons == "Microplastics"){
      
      plot_5 <- ggplot(data = macromicro, mapping = aes(x = Year, y = `Microplastics (<0.5cm) (tonnes)`, text = paste("Year:", Year, "<br>", "Amount of Microplastics:", paste0(`Microplastics (<0.5cm) (tonnes)`, " tonnes"), "<br>", Entity))) +
        geom_line(aes(color = Entity), group = 1) +
        labs(x = "Year", "Amount of Microplastics") +
        theme_minimal()}
      ggplotly(plot_5, tooltip = "text")
  })
  
  output$leaflet <- renderLeaflet({
   
    ico <- makeIcon(
      iconUrl = "water-bottle-png-image-39990-1700.png",
      iconWidth= 20, iconHeight=20
    )
    
    
    # membuat object leaflet(), sama seperti awalan ggplot()
    map1 <- leaflet()
    
    # membuat tiles atau gambar peta
    map1 <- addTiles(map1)
    
    # membuat konten popup dengan gaya penulisan html
    content_popup <- paste(sep = " ",
                           "Amount of surface waste in the Ocean:", paste0(surfacenewnewnew$`All sizes (total mass) (tonnes)`, " tonnes"), "<br>",
                           "Ocean:", surfacenewnewnew$Entity
    )
    
    # memasukkan marker atau titik sesuai dengan data
    map1 <- addMarkers(map = map1, 
                       lng =  surfacenewnewnew$longtitude, # garis bujur
                       lat = surfacenewnewnew$latitude, # garis lintang
                       icon = ico, #icon
                       
                       popup = content_popup, #popup atau tulisan
                       
                       clusterOptions = markerClusterOptions() # membuat cluster supaya tidak overlap
    )
    
    map1
    
  })
  
  output$Global <- renderInfoBox({
    infoBox("Total surface waste in 2013",
           paste0(surf$`All sizes (total mass) (tonnes)`, " tonnes"), icon = icon("globe"),
           color = "blue", fill = FALSE)
  })
  
  output$New <- renderPlotly({
    
    if(input$selector == "Surface area"){
   plotnew <-  ggplot(data = newsurf, mapping = aes(x = genus, y = mean_surf, text = paste(genus, "<br>", "Environment:", envi, "<br>", "Average surface area:", mean_surf))) +
      geom_col(aes(fill = envi)) +
     labs(x = "Genus", y = "Average surface area") +
     theme_minimal() +
     coord_flip() +
     scale_fill_viridis_d() +
     theme(legend.position = "none")
    }
    
    else if(input$selector == "Weight"){
      plotnew <-  ggplot(data = newweight, mapping = aes(x = genus, y = mean_weight, text = paste(genus, "<br>", "Environment:", envi, "<br>", "Average weight:", mean_weight))) +
        geom_col(aes(fill = envi)) +
        labs(x = "Genus", y = "Average weight")+
        theme_minimal() +
        coord_flip() +
        theme(legend.position = "none")
      
    }
    
    else {
      
     plotnew <-  ggplot(data = newvol, mapping = aes(x = genus, y = mean_vol, text = paste(genus, "<br>", "Environment:", envi, "<br>", "Average volume:", mean_vol))) +
      geom_col(aes(fill = envi)) +
      labs(x = "Genus", y = "Average volume") +
       theme_minimal() +
       coord_flip() +
       scale_fill_brewer(palette = "Set3") +
       theme(legend.position = "none")
    }
    
    
    ggplotly(plotnew, tooltip = "text")
  })
}

