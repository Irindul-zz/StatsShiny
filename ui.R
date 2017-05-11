shinyUI(fluidPage(theme='bootstrap.min.css',
  headerPanel("TP Statistiques Polytech 3A"),

  sidebarLayout(
    sidebarPanel(

      h2("Test de rang signé de Wilcoxon"),
      p("Le test de rang signé de est un test statistique non paramétrique utilisé pour la comparaison de deux échantillons semblables."),
      p("Il peut être utilisé comme une alternative du test de Student."),
      HTML("
          <p>Pour plus d'informations, voici la page anglaise <a target='_blank' href='https://en.wikipedia.org/wiki/Wilcoxon_signed-rank_test'>Wikipedia</a> du test. </p>
        "),
      h3("Notre Application"),
      p("Le test se lance après avoir importé un fichier au format CSV."),
      p("Ce fichier doit comporter un HEADER (Première ligne au format NOM1,NOM2)"),
      p("Les données seront séparèes par un ',' "),
      
      HTML("<span > Exemple : 
            <table class='table'>
              <tr>
                <th>NOM1,</th>
                <th>NOM2</th>
              </tr>
              <tr>
                <td>1.35,</td>
                <td>1.23</td>
              </tr>
              <tr>
                <td>0.34,</td>
                <td>0.89</td>
              </tr>
            </table>
            </span>"),
      p("Un fichier nomé 'valeursTest.csv' sert d'exemple et peut être utilisé pour tester. Ce fichier est situé a la racine du projet."),
      br(),

      fileInput('file1', 'Choisir le fichier', buttonLabel = "Parcourir..", placeholder = "Aucun fichier séléctionné",
        accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')),
      p("Cocher cette case pour un test avec des valeurs appariés (Les deux colonnes doivent contenir le même nombre de valeurs)"),
      checkboxInput('paired', 'Appariés', FALSE),
      h3("Notre Équipe"),
      HTML("<p>Réalisé par <b>Martial TARDY</b> et <b>Mathieu REGNARD</b></p>"),
      HTML("<p>Dans le cadre d'un projet de statistiques à <a target='_blank'href='http://polytech.univ-lyon1.fr/''>Polytech Lyon</a> en INFO 3A </p> ")

      ),
    mainPanel(
      tableOutput('contents'),
      textOutput('message'),
      plotOutput('plot1'),
      plotOutput('plot2'),
      verbatimTextOutput('result')

      )
    )
  ))
