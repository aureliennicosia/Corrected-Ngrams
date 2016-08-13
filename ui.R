
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#


sidebar <- dashboardSidebar(
  textInput("searchButton2", h3("Word"), value= "Figure"),
  sliderInput("daterange", h3("Year range"),
              min = 1800, max = 2008, value = c(1900,2000)),
 # dateRangeInput("daterange", h3("Year range:"),format = "yyyy", start="1900-01-01", end="2000-01-01", startview = "decade"),
  selectInput("checkbox", 
                     label = h3("Choose the corpus"), 
                     choices = list("American English 2012" = "eng_us_2012", 
                                    "American English 2009" = "eng_us_2009",
                                   	"British English 2012" = "eng_gb_2012",
                                    	"British English 2009" = "eng_gb_2009",
                                    	"English 2012" = "eng_2012",
                                    	"English 2009" = "eng_2009",
                                    	"English Fiction 2012" = "eng_fiction_2012",
                                    	"English Fiction 2009" = "eng_fiction_2009",
                                    	"Google One Million" = "eng_1m_2009",
                                    	"French 2012" = "fre_2012",
                                    	"French 2009" = "fre_2009"
                                    ),
                     selected = "eng_us_2009")
  )



# Simple header -----------------------------------------------------------
dashboardPage(
  dashboardHeader(title = "Corrected Ngrams Viewer by Aurélien Nicosia", titleWidth = 450),
  dashboardSidebar(sidebar ,titleWidth = 350),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    fluidRow(
           box(
             title = "What do you want to plot?",width= 8,collapsible= TRUE,status = "warning", solidHeader = TRUE, br(), 
             selectInput("plotChoice", 
                         label = NULL,
                         choices = list("Google Viewer and corrected trend" = "all", 
                                        "Google Viewer" = "google", "Corrected trend" = "corrected"),
                         selected = "all"
                         )),
             
             box(title= "Extracting useful information from the Google Ngram
dataset: A general method to take the growth of the scientific literature into account" ,statut = "primary",collapsible= TRUE,solidHeader = TRUE, br(),
                 plotlyOutput("plot.corrected"), width =8)
      
           
           
     )
    )
  )
