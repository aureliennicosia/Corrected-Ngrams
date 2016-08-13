


list.of.packages <- c("ggplot2", "devtools", "lubridate", "nlme", 
  "plotly", "shinydashboard", "shiny", "git2r")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[, 
  "Package"])]
if (length(new.packages)) install.packages(new.packages)

library(shiny)
library(shinydashboard)

library(devtools)
install_github("ngramr", "seancarmody")
require(ngramr)
library(ggplot2)
library(lubridate)
library(nlme)
library(plotly)
library(shinydashboard)
library(shiny)
library(git2r)



