shinyServer(function(input, output) {
  inputTable <- reactive({
    inFile <- input$file1

    if (is.null(inFile))
      return(NULL)

    table <- read.csv(inFile$datapath, header=TRUE, sep=',', quote='')

    #x <- c(0.80, 0.83, 1.89, 1.04, 1.45, 1.38, 1.91, 1.64, 0.73, 1.46)
    #y <- c(1.15, 0.88, 0.90, 0.74, 1.21)  
    #wilcox.test(x, y)
    # print(result)

  })



  output$contents <- renderTable({
      inputTable();
  })


  results <- reactive({
    inFile <- input$file1

    if(is.null(inFile))
      return(cat(""))
    
    table <- read.csv(inFile$datapath, header=TRUE, sep=',', quote='')
    x <- table[,1]
    x <- x[!is.na(x)] #Pour enlever le NA dans les valeurs non définies

    y <- table[,2]
    y <- y[!is.na(y)]

    if(is.null(x) || is.null(y))
      return(cat("Veuillez choisir un modèle de données correcte"))

    if(input$paired){
      if(length(x) != length(y))
        return(cat("Veuillez choisir un modèle de données correcte"))
    } 

    result <- wilcox.test(x, y, paired=input$paired)
    pval <- result$p.value
    stat <- result$statistic
    stat <- gsub('W', '', stat) #Enlève le texte et laisse que la valeur
    cat("La Valeur p est :", pval, "\n")
    name <-'W'
    if(input$paired)
      name <- 'V'

    cat(name, "vaut : ", stat, "\n");
     
    cat("Comparrez maintenant", name, " avec ", name, "critique. Si |", name, "| > ", name, "critique, alors l'hypothèse est rejetée.\n")

    z <- qnorm(1-(pval/2))
    cat("Valeur de z :", z, "\n");

    cat("Comparrez maintenant z avec Zcritique. Si |z| > Zcritique, alors l'hypothèse est rejetée.\n")


  })

  output$result <- renderPrint({ 
     results()
  })

  plot1 <- function(){
    inFile <- input$file1

    if(is.null(inFile))
      return(cat(""))

    table <- read.csv(inFile$datapath, header=TRUE, sep=',', quote='')
    x <- table[,1]
    x <- x[!is.na(x)] #Pour enlever le NA dans les valeurs non définies

    barplot(x, main="Premières Valeurs")
            

  }

  plot2 <- function(){
      inFile <- input$file1

      if(is.null(inFile))
        return(cat(""))

      table <- read.csv(inFile$datapath, header=TRUE, sep=',', quote='')

      y <- table[,2]
      y <- y[!is.na(y)]

      barplot(y, main="Secondes Valeurs")

  }

 

  output$plot1 <- renderPlot({
      print(plot1())
  })

  output$plot2 <- renderPlot({
      print(plot2())
  })


  output$message <- renderText({
    if(is.null(inputTable()))
      "Veuillez séléctionner le fichier à utiliser pour les tests."
    else "Voici les résultats : "
  })



})