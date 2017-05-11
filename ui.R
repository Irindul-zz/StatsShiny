shinyUI(pageWithSidebar(
  headerPanel("TP Statistiques Polytech 3A"),
  sidebarPanel(
    fileInput('file1', 'Choisir le fichier', buttonLabel = "Parcourir..", placeholder = "Aucun fichier séléctionné",
              accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')),
    tags$hr(),
    checkboxInput('paired', 'Appariés', FALSE)
  ),
  mainPanel(
    tableOutput('contents'),
    textOutput('message'),
    verbatimTextOutput('result')
  )
))
