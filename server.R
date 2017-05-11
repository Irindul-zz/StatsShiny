shinyServer(function(input, output) {
  inputTable <- reactive({
    #Affiche les données directement
    inFile <- input$file1

    if (is.null(inFile))
      return(NULL)

    table <- read.csv(inFile$datapath, header=TRUE, sep=',', quote='')

  })

  output$contents <- renderTable({
      inputTable();
  })


  results <- reactive({
    #Les calculs sont fait et affichés ici.

    inFile <- input$file1

    if(is.null(inFile))
      return(cat(""))
    
    table <- read.csv(inFile$datapath, header=TRUE, sep=',', quote='')
    x <- table[,1]
    x <- x[!is.na(x)] #Pour enlever le NA dans les valeurs non définies

    y <- table[,2]
    y <- y[!is.na(y)]

    
    #Verifications
    if(is.null(x) || is.null(y))
      return(cat("Veuillez choisir un modèle de données correcte"))

    if(input$paired){
      if(length(x) != length(y))
        return(cat("Veuillez choisir un modèle de données correcte"))
    }

    #On appelle le test
    result <- wilcox.test(x, y, paired=input$paired)
    pval <- result$p.value
    stat <- result$statistic
    stat <- gsub('W', '', stat) #Enlève le texte et laisse que la valeur

    #Affichage des valeurs obtenues
    cat("La Valeur p est :", pval, "\n")

    #Le nom de la variable change si le test est apparié
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
    #Affiche le diagramme en baton des premières valeurs
    inFile <- input$file1

    if(is.null(inFile))
      return(cat(""))

    table <- read.csv(inFile$datapath, header=TRUE, sep=',', quote='')
    x <- table[,1]
    x <- x[!is.na(x)] #Pour enlever le NA dans les valeurs non définies

    barplot(x, main="Premières Valeurs", col="lightblue")
            

  }

  plot2 <- function(){
    #Affiche le diagramme en baton des secondes valeurs
      inFile <- input$file1

      if(is.null(inFile))
        return(cat(""))

      table <- read.csv(inFile$datapath, header=TRUE, sep=',', quote='')

      y <- table[,2]
      y <- y[!is.na(y)]

      barplot(y, main="Secondes Valeurs", col="lightblue")

  }

  output$plot1 <- renderPlot({
      print(plot1())
  })

  output$plot2 <- renderPlot({
      print(plot2())
  })

  output$message <- renderText({
    #Affichage d'un message en attendant l'import d'un fichier
    if(is.null(inputTable()))
      "Veuillez séléctionner le fichier à utiliser pour les tests."
    else "Voici les résultats : "
  })

})