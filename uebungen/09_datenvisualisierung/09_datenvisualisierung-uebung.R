##########################################
###   UEBUNG: DATENVISUALISIERUNG IN R ###
##########################################

# In dieser Übung visualisieren wir die Anzahl von Plastikstücken, die von den zehn führenden Herstellern weltweit produziert wurden.
# Da wir dafür zunächst einmal unsere Daten bereinigen müssen, wird es ebenfalls noch einmal eine kleine Wiederholung der dplyr-Verben geben.
# Dabei erstellen wir ein Balkendiagramm und formatieren es mit ggplot2, um die Daten anschaulich darzustellen.
# Ersetzt die entsprechenden Stellen im Code '???' durch die richtigen Variablen und/oder Funktionen.


  
## Übung 1: Infrastruktur ------------------------------------------------------
# Wie gewohnt installieren und laden wir im ersten Schritt alle Packages, mit denen wir später arbeiten werden. 
# Falls Ihr weitere Packages benutzen wollt, fügt sie gerne hinzu!

# Notwendige Packages laden - ggf. vorher mit "install.packages("package") installieren
# Die Packages dplyr und ggplot2 sind im tidyverse enthalten
library(tidyverse)
library(rio)


  
## Übung 2: Daten laden --------------------------------------------------------
# Als nächstes laden wir den Datensatz `audit`, den wir inzwischen schon gut kennen. Die Daten finden wir unter folgendem Link: 'https://raw.githubusercontent.com/CorrelAid/rlernen_umwelt/main/daten/bffp2019_audit_by_country_and_company.csv'
audit <- rio::import('???')

## Übung 3: Daten bereinigen ---------------------------------------------------
# Bevor wir unsere Daten visualisieren können, müssen wir diese bereinigen - schließlich wollen wir nur die Top 10 abbilden.

# Zunächst erstellen wir einen neuen Datensatz der Top-Ten-Hersteller nach Anzahl der Plastikstücke.
top10_parentcompany <- audit %>%
  
# Dann wählen wir die Spalten für Herstellername ('parent_company') und Stückanzahl ('n_pieces') aus ...
  dplyr::???(parent_company, n_pieces) %>%                                      
  
# ... gruppieren die Daten nach den herstellenden Firmen ('parent_company')...
  dplyr::???(parent_company) %>%                                              
  
# ... und berechnen die Gesamtanzahl an Plastikstücken pro Firma ('n_pieces').
# NAs sollen dabei explizit nicht berücksichtigt werden ('na.rm = TRUE').
  dplyr::summarise(total_pieces = sum(???, na.rm = TRUE)) %>%                  
  
# Anschließend müssen wir Firmen ohne eindeutige Zuordnung herausfiltern ...
  dplyr::filter(!parent_company %in% c("Unbranded", "Inconnu", "Assorted")) %>%    
  
# ... und die zehn Firmen mit den meisten Plastikstücken auswählen.
  dplyr::slice_max(total_pieces, n = 10) %>%                                       
  
# ... Abschließend sortieren wir die Firmen in absteigender Reihenfolge nach Anzahl der Plastikstücke ('total_pieces').
  dplyr::arrange(desc(total_pieces))                                               

  

## Übung 4: Übersicht verschaffen ----------------------------------------------
# Wir verschaffen uns einen Überblick über unseren neuen Datensatz 'top10_parentcompany'
print(???)


  
## Übung 5: Daten visualisieren ------------------------------------------------
# Erstellung eines Balkendiagramms (Barplot, 'geom_bar') für die Top Ten Hersteller von Plastikmüll

# Wir initialisieren zunächst unseren Plot mit ggplot2 und unserem neuen Datensatz 'top10_parentcompany' ...
ggplot2::ggplot(data = ???,
                aes(x = ???, y = reorder(parent_company, total_pieces))) + 
  
# ... entscheiden uns für das Balkendiagramm ('geom_bar') als Darstellungsform und legen die Farbe fest.
  ggplot2::???(stat = "identity", fill = "#4E97AC") + 
  
# Anschließend labeln wir den Titel und die Achsenbeschriftungen ...
  ggplot2::???(
    title = "Prominente Firmen aus aller Welt ...",
    subtitle = "... stellen die gefundenen Plastikverpackungen her.",
    x = "Anzahl an Plastikstücken",
    y = "Hersteller"
  ) +
  
# ... und verwenden das minimalistische Design ('theme_minimal').
  ggplot2::???() +
  
# Die Anzahl gesammelter Plastikteile sollen als Textlabels rechts neben den Balken angezeigt werden.
  ggplot2::geom_text(aes(label = total_pieces), size = 2.5, hjust = -0.01)

# Hinweis: Der Code erzeugt ein Bar-Diagramm, das die zehn größten Hersteller von Plastikstücken anhand der Anzahl der gefundenen Stücke anzeigt.
