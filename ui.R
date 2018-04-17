library(shiny)
library(plotly)
    titlePanel("Airquality prediction Model")
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
    ),
 
    mainPanel(
        
        sliderInput("SliderTemp",
                    "Temp Value:",
                    min = min(airquality[complete.cases(airquality),]$Temp) - 5,
                    max = max(airquality[complete.cases(airquality),]$Temp) +5,
                        value = 63),
        h3("Predicted Ozone with predictor Temp:"),
        textOutput("pred3"),
        checkboxInput("showModel3", "Show/Hide Model 3", value = TRUE),
        plotlyOutput("plot3"),
        sliderInput("SliderSolar",
                    "Solar.R Value:",
                    min = min(airquality[complete.cases(airquality),]$Solar.R) - 5,
                    max = max(airquality[complete.cases(airquality),]$Solar.R) +5,
                    value = 40),
        h3("Predicted Ozone with predictor Solar.R:"),
        textOutput("pred1"),
        checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
        plotlyOutput("plot1", height = "300px", width = "100%"),
        verbatimTextOutput("hover_info"),
        h3("Predicted Temp with predictor Solar.R:"),
        textOutput("pred2"),
        checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
        plotlyOutput("plot2")
       
        ##plotOutput("plot2", height = "300px", width = "100%", hover = hoverOpts(id = "plot_hover2")),
        ##verbatimTextOutput("hover_info")
       
    )
  )
