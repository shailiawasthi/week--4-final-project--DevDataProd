library(shiny)
library(ggplot2)
library(grid)
library(gridExtra)
library(plotly)
shinyServer(function(input, output) {
    model1 <- lm(Ozone ~ Solar.R, data = airquality)
    model2 <- lm(Temp ~ Solar.R, data = airquality)
    model3 <- lm(Ozone ~ Temp, data = airquality)
    
    model1pred <- reactive({
        SolarInput <- input$SliderSolar
       
        predict(model1, newdata = data.frame(Solar.R = SolarInput))
      
    })
    output$pred1 <- renderText({
        model1pred()
    })

model3pred <- reactive({
    TempInput <- input$SliderTemp
    
    predict(model3, newdata = data.frame(Temp = TempInput))
    
})
output$pred3 <- renderText({
    model3pred()
})
   
    
     output$plot1 <- renderPlotly({
        SolarInput <- input$SliderSolar
        minS = min(airquality[complete.cases(airquality),]$Solar.R) - 5
        maxS = max(airquality[complete.cases(airquality),]$Solar.R) +5
        minO = min(airquality[complete.cases(airquality),]$Ozone) - 5
        maxO = max(airquality[complete.cases(airquality),]$Ozone) +5
        
        g <- ggplot(airquality, aes(   y = airquality$Ozone, x = airquality$Solar.R, ylab = "Ozone", 
             xlab = "Solar.R"), bty = "n", pch = 16,
             xlim = c(minS, maxS), ylim = c(minO, maxO)) + geom_point()
        if(input$showModel1){
           
            g <- g + stat_smooth(method = 'lm', color = "red", lwd = 2)
            }
        
        g <- g+ ggtitle("Ozon Prediction with Solar.R predictor")
        g <- g + geom_point(x = SolarInput, y = model1pred(), col = "Green", pch = 16, cex = 6)
      
           ggplotly(g) 
        
     })
   
     output$plot3 <- renderPlotly({
         TempInput <- input$SliderTemp
         minT = min(airquality[complete.cases(airquality),]$Temp) - 5
         maxT = max(airquality[complete.cases(airquality),]$Temp) +5
         minO = min(airquality[complete.cases(airquality),]$Ozone) - 5
         maxO = max(airquality[complete.cases(airquality),]$Ozone) +5
         
         g3 <- ggplot(airquality, aes(   y = airquality$Ozone, x = airquality$Temp, ylab = "Ozone", 
                                         xlab = "Temp"), bty = "n", pch = 16,
                      xlim = c(minT, maxT), ylim = c(minO, maxO)) + geom_point()
         if(input$showModel3){
             
             g3 <- g3 + stat_smooth(method = 'lm', color = "Green", lwd = 2)
         }
         
         g3 <- g3+ ggtitle("Ozone Prediction with Temp Predictor")
         g3 <- g3 + geom_point(x = TempInput, y = model3pred(), position = "identity", col = "Yellow", pch = 16, cex = 6)
         
         ggplotly(g3)
         
     })
     
###Model2
     model2pred <- reactive({
         SolarInput <- input$SliderSolar
         predict(model2, newdata = data.frame(Solar.R = SolarInput))
         
     })
     
     output$pred2 <- renderText({
         model2pred()
     })
     
    output$plot2 <- renderPlotly({
        SolarInput <- input$SliderSolar
        minT = min(airquality[complete.cases(airquality),]$Temp) - 5
        maxT = max(airquality[complete.cases(airquality),]$Temp) +5
        minS = min(airquality[complete.cases(airquality),]$Solar.R) - 5
        maxS = max(airquality[complete.cases(airquality),]$Solar.R) +5
        
        g2 <- ggplot(airquality, aes(   y = airquality$Temp, x = airquality$Solar.R, ylab = "Ozone", 
                                       xlab = "Solar.R"), bty = "n", pch = 16,
                    xlim = c(minS, maxS), ylim = c(minO, maxO)) + geom_point()
        if(input$showModel2){
            ##g<- g + stat_smooth(aes(x = airquality[complete.cases(airquality),]$Solar.R, y = model1$fitted.values), col = "red", lwd = 2)
            g2 <- g2 + stat_smooth(method = 'lm', color = "Green", lwd = 2)
        }
        
        g2 <- g2+ ggtitle("Temprature Prediction with Solar.R Predictor")
        g2 <- g2 + geom_point(x = SolarInput, y = model2pred(), position = "identity", col = "Blue", pch = 16, cex = 6)
        
        ## points(x = TempInput, y = model2pred(), col = "Black", pch = 16, cex = 6)
        ##output$hover_info <- renderPrint({
          ##  if(!is.null(input$plot_hover))
           ##     paste0("Solar.R: ", input$plot_hover2$x, " ", "Temp: ",input$plot_hover2$y)})
        ggplotly(g2)
        
    })
   
    
    
 ##grid.arrange(g, g2)
    
    
})