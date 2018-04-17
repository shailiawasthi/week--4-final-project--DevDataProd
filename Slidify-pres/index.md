---
title: "Developing Data Products"
author: "Savita Kohli"
date: "April 16, 2018"
output: slidy_presentation
highlighter: highlight.js
hitheme: zenburn
mode: selfcontained
framework: revealjs
revealjs:
  theme: night
  transition: convex
subtitle: New York Airquality
ext_widgets:
  rCharts:
  - libraries/nvd3
  - libraries/leaflet
widgets: []
knit        : slidify::knit2slides
---


# The Assignment 

The goal of this assignment is to build:

1. __A Shiny application__ that has widget input, ui input in `server.R`, reactive output using server calculations, and supporting documentation.

2. __A Reproducible Pitch Presentation__ that contains five slides in either Slidify or Rstudio Presenter that is pushed to and hosted on GitHub or Rpubs and contains embedded `R` code that runs. 

## Links to Project App & Docs

1. Shiny App: [Link](https://savitakohli.shinyapps.io/MultiOutcome_Shiny/)
2. server.R` and `ui.R` files: [Link](https://github.com/savitakohli/Developing-Data-Products-Final-Project) 

---

## New York Air Quality Measurements

Since the ozone layer absorbs UVB ultraviolet light from the sun, ozone layer depletion increases surface UVB levels (all else equal), which could lead to damage, including increase in skin cancer.

### Data Source

The data were obtained from the New York State Department of Conservation (ozone data) and the National Weather Service (meteorological data).

<center>
_"Life on earth is protected from the UV rays by Ozone Layer"_
</center>

---

## Data Details
Daily readings of the following air quality values for May 1, 1973 (a Tuesday) to September 30, 1973.

- Ozone: Mean ozone in parts per billion from 1300 to 1500 hours at Roosevelt Island

- Solar.R: Solar radiation in Langleys in the frequency band 4000-7700 Angstroms from 0800 to 1200 hours at Central Park

- Wind: Average wind speed in miles per hour at 0700 and 1000 hours at LaGuardia Airport

- Temp: Maximum daily temperature in degrees Fahrenheit at La Guardia Airport.
    

---  
##Data Exploration and Analysis 
Following analysis is to show the impact of Solar.R and Temp on Ozone layer.
    
    ```r
    summary(lm(Ozone ~ Solar.R + Temp - 1, data = airquality ))
    ```
    
    ```
    ## 
    ## Call:
    ## lm(formula = Ozone ~ Solar.R + Temp - 1, data = airquality)
    ## 
    ## Residuals:
    ##    Min     1Q Median     3Q    Max 
    ## -40.29 -23.07 -12.78  13.28 118.91 
    ## 
    ## Coefficients:
    ##         Estimate Std. Error t value Pr(>|t|)    
    ## Solar.R  0.06675    0.03212   2.078   0.0401 *  
    ## Temp     0.41000    0.08438   4.859 3.98e-06 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 29.38 on 109 degrees of freedom
    ##   (42 observations deleted due to missingness)
    ## Multiple R-squared:  0.7046,	Adjusted R-squared:  0.6992 
    ## F-statistic:   130 on 2 and 109 DF,  p-value: < 2.2e-16
    ```
    
    ```r
    airquality<- airquality[complete.cases(airquality),]
    
    airquality$predicted <- fitted.values(glm(Ozone ~ Solar.R -1, data = airquality))
    airquality$predicted1 <- fitted.values(glm(Ozone ~ Temp -1, data = airquality))
    ```

---  
### Plotting airquality Ozone, Solar.R and Temp data
    

```r
     attach(airquality)
    par(mfrow = c(2, 1))
    plot(Solar.R, Ozone, xlab = "Solar.R", ylab = "Ozone", main = "Ozone ~ Solar.R")
    lines(Solar.R, predicted)
    plot(Temp, Ozone, xlab = "Temp", ylab = "Ozone", main = "Ozone ~ Temp")
    lines(Temp, predicted1)
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1-1.png)

