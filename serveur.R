



# Setup Shiny app back-end components
# -------------------------------------
server <- function(input, output) {
  
  x.ng <- reactive({
    ng <- ngram(input$searchButton2, year_start = input$daterange[1], 
      year_end = input$daterange[2], count = TRUE, corpus = input$checkbox, 
      smoothing = 0)
    
  })
  x.etall <- reactive({
    
    ngram("et al", year_start = input$daterange[1], year_end = input$daterange[2], 
      count = TRUE, corpus = input$checkbox, smoothing = 0)
  })
  x.ofthe <- reactive({
    ngram("of the", year_start = input$daterange[1], year_end = input$daterange[2], 
      count = TRUE, corpus = input$checkbox, smoothing = 0)
  })
  x.the <- reactive({
    ngram("the", year_start = input$daterange[1], year_end = input$daterange[2], 
      count = TRUE, corpus = input$checkbox, smoothing = 0)
  })
  x <- reactive({
    df = data.frame(p.t = x.ng()$Count/x.the()$Count, q.t = x.etall()$Count/x.ofthe()$Count, 
      time = x.ng()$Year)
  })
  
  x.final <- reactive({
    fit = gls(p.t ~ time * q.t, data = x(), corr = corAR1(form = ~1))
    
    
    
    # ## simple examples using gamm as alternative to gam
    beta <- coef(fit)
    beta.trans <- c(beta[3] + beta[1], beta[4] + beta[2], 
      beta[1], beta[2])
    p.t_q.t <- pmax((beta.trans[1] + beta.trans[2] * x()$time) * 
      x()$q.t, 0)
    p.t_Nq.t <- pmax((beta.trans[3] + beta.trans[4] * x()$time) * 
      (1 - x()$q.t), 0)
    prop = c(p.t_q.t, p.t_Nq.t, x()$p.t)
    corpus = c(rep("Scientific literature", length(p.t_q.t)), 
      rep("Non scientific literature", length(p.t_Nq.t)), 
      rep("Google Viewer", length(x()$p.t)))
    df2 <- data.frame(proportion = prop * 100, Trends = corpus, 
      Year = x()$time)
    df2
    
  })
  
  plot.choice = reactive(input$plotChoice)
  
  output$plot.corrected <- renderPlotly({
    if (plot.choice() == "all") {
      df = x.final()
      title.choix <- "Google Viewer and corrected trend"
    }
    if (plot.choice() == "google") {
      df = subset(x.final(), Trends == "Google Viewer")
      title.choix <- "Google Viewer trend"
    }
    if (plot.choice() == "corrected") {
      df = subset(x.final(), Trends != "Google Viewer")
      title.choix <- "Corrected trend"
    }
    
    p2 <- ggplot(df, aes(x = Year, y = proportion, colour = Trends)) + 
      geom_line() + ggtitle(paste0(title.choix, " of ", 
      input$searchButton2, sep = " ")) + ylab("Proportion (%)")
    ggplotly(p2)
    
  })
  
  
}

