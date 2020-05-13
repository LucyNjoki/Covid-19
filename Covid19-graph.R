#*********************************************************************
#Purpose: COVID-19 Graph
#Date: 13/5/2020
#Author: LNN
#Acknowledge: Taryn Morris (R-Ladies - Intro to shiny)
#*********************************************************************

rm(list = ls(all = TRUE))

#Install tidycovid package
#remotes::install_github("joachim-gassen/tidycovid19")

#package load
library(tidycovid19)
library(tidyverse)
library(extrafont)
library(ggthemes)
library(ggrepel)
library(plotly)

#download the data
CovData <- download_jhu_csse_covid19_data()

saveRDS(CovData, "CovData.rds")

head(CovData)


#plot
theme_set(theme_tufte())

ggplotly(
  ggplot(CovData %>% filter(country == "Kenya"),
         aes(x = date, y = confirmed, colour = country)) +
    geom_line() +
    geom_point() +
    labs(y = "confirmed")
)
