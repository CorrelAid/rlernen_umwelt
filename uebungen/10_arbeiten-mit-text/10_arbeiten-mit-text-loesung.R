#################################
### UEBUNG: ARBEITEN MIT TEXT ###
#################################

## Übung 1: Infrastruktur ------------------------------------------------------
# Im ersten Schritt müssen wir alle Packages installieren und laden, mit denen Ihr später arbeiten werdet. Falls Ihr weitere Packages benutzen wollt, fügt sie gerne hinzu!

# Notwendige Packages laden - ggf. vorher mit "install.packages("package") installieren

library(dplyr)
library(stringr)
library(wordcloud)
library(stopwords)



## Übung 2: Daten laden --------------------------------------------------------
# Als nächstes laden wir den Datensatz `plastics`, den wir inzwischen schon ganz gut kennen. Dafür nutzen wir die Funktion `read_csv`. Die Daten findet Ihr unter diesem Link: https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-01-26/plastics.csv

data_raw <- rio::import("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-01-26/plastics.csv")



## Übung 3: Bereinigung "PepsiCo" ----------------------------------------------
# In der folgenden Übung wollen wir uns noch einmal die str_replace()-Funktion anschauen. 
# Nachdem wir auf der Lernplattform die Ländervariablen bereinigt haben, soll es nun um die Firmennamen ('parent_company') gehen.


### Übung 3.1: Fehlerhafte Einträge identifizieren 
# Bevor wir die Firmennamen bereininge, müssen wir uns zunächst einen Überblick über die möglichen Version dens Firmennamens verschaffen. 

# Ihr nehmt Euren Datensatz ...
data_raw %>%

  # ... und sucht in der Spalte `parent_company` nach allen Einträgen, die 'Pepsi' oder 'pepsi' enthalten. Verwendet dafür die Funktion `str_detect`:
    dplyr::filter(stringr::str_detect(parent_company, '[Pp]epsi'))

# Mit dem regulären Ausdruck`'.*[Pp]epsi.*'` erfassen wir alle, Einträge die 'Pepsi' oder 'pepsi' und von einer unbestimmten Menge weiterer Zeichen umschlossen sind. 
# Insgesamt identifizieren wir folgende Varianten, die wir vereinheitlichen wollen:
  
#  | parent_company  |
#  |-----------------|
#  | Pepsico         |
#  | PepsiCo         |
#  | Etika - PepsiCo |


### Übung 3.2: Fehlerhafte Einträge bereinigen ---------------------------------
# Als nächstes wollen wir die entsprechenden Namen vereinheitlichen. Um den Code kurz und flexibel zu halten, nutzen wir hierzu `str_replace()` zusammen mit regulären Ausdrücken:
# Nachdem wir in 3.1. alle möglichen Varianten des Firmennamens identifiziert haben, wollen wir diese nun durch den einheitlichen Namen 'PepsiCo' ersetzen:
# Die Syntax von `str_replace` funktioniert folgendermaßen: `str_replace(*Textvariable*, *Zeichenfolge oder Regex*, *Ersatz*)`

# Ihr nehmt Euren Datensatz ...
data_raw %>%
  
  # ... und verwendet mutate(), um die Spalte 'parent_company' zu bearbeiten.
  dplyr::mutate(
    
    # Mit str_replace() ersetzen wir alle Varianten des Firmennamens, die 'Kraft' oder 'kraft' enthalten, durch den einheitlichen Namen 'Kraft Foods'.
    parent_company = stringr::str_replace(parent_company, '.*[Pp]epsi.*', 'PepsiCo')
  ) %>%
  
  # Nach der Bereinigung filtern wir nun die Daten, um nur die Zeilen zu behalten, in denen der neue Name 'Kraft Foods' vorkommt.
  dplyr::filter(parent_company == "PepsiCo") # Hier zeigen wir nur die Einträge mit dem neuen Firmennamen an.



## Übung 4: Bereinigung "Kraft Heinz Company" ----------------------------------
# Als weiteres Beispiel schauen wir uns die Kraft Heinz Company an.
  

### Übung 4.1: Fehlerhafte Einträge identifizieren 
# Bevor wir die Firmennamen bereinigen, müssen wir uns zunächst einen Überblick über die möglichen Version dens Firmennamens verschaffen. 

# Ihr nehmt Euren Datensatz ...
data_raw %>%
  
  # ... und sucht in der Spalte `parent_company` nach allen Einträgen, die 'Kraft' oder 'kraft' enthalten. Verwendet dafür die Funktion `str_detect`:
  dplyr::filter(stringr::str_detect(parent_company, '[Kk]raft'))

# Insgesamt identifizieren wir folgende Varianten, die wir vereinheitlichen wollen:

#  | parent_company      |
#  |---------------------|
#  | Kraft Heinz Company |
#  | Kraft Foods         |
#  | kraft food          |
#  | Capri Sun/Kraft     |
#  | Kraft Suchard       |
#  | Kraft Heinz         |
#  | Kraft               |
 
### Übung 4.2: Fehlerhafte Einträge bereinigen ---------------------------------
# Nachdem wir in 4.1. alle möglichen Varianten des Firmennamens identifiziert haben, wollen wir diese nun durch den einheitlichen Namen 'Kraft Foods' ersetzen:

# Ihr nehmt Euren Datensatz ...
data_raw %>%
  
  # ... und verwendet mutate(), um die Spalte 'parent_company' zu bearbeiten.
  dplyr::mutate(
    
    # Mit str_replace() ersetzen wir alle Varianten des Firmennamens, die 'Kraft' oder 'kraft' enthalten, durch den einheitlichen Namen 'Kraft Foods'.
    parent_company = stringr::str_replace(parent_company, '.*[Kk]raft.*', 'Kraft Foods')
  ) %>%
  
  # Nach der Bereinigung filtern wir nun die Daten, um nur die Zeilen zu behalten, in denen der neue Name 'Kraft Foods' vorkommt.
  dplyr::filter(parent_company == "Kraft Foods") # Hier zeigen wir nur die Einträge mit dem neuen Firmennamen an.



## Übung 5: Erstellung einer Wortwolke für die Firmenhäufigkeit ----------------
# Zum Abschluss dieser Übung erstellen wir eine Wortwolke, um visuell darzustellen, welche Firmen in unserem Datensatz am häufigsten genannt werden. 
# Wir werden zunächst englische Stoppwörter entfernen, um sicherzustellen, dass nur relevante Firmennamen in der Wortwolke angezeigt werden.


# Ihr nehmt Euren Datensatz...
data_raw %>%
  
  # ... und entfernt zunächst englische Stoppwörter aus der Spalte 'parent_company'.
  dplyr::filter(!(parent_company %in% stopwords::stopwords("en"))) %>%
  
  # Dann erstellt Ihr eine neue Tabelle, die die Häufigkeit jeder Firma zählt (`count()`).
  dplyr::count(parent_company, sort = TRUE) %>%
  
  # Anschließend erstellt Ihr die Wortwolke. Dazu speichert Ihr das Ergebnis in einer neuen Variable.
  {wordcloud::wordcloud(words = .$parent_company,                        # Die Firmennamen
                        freq = .$n,                                      # Die Häufigkeit der Firmennamen
                        min.freq = 15,                                   # Minimale Häufigkeit, um in die Wortwolke aufgenommen zu werden
                        max.words = 100,                                  # Maximale Anzahl der Wörter in der Wortwolke
                        random.order = FALSE,                            # Die Wörter werden in absteigender Häufigkeit angeordnet
                        rot.per = 0.35)}                                 # Der Anteil der rotierenden Wörter (in Grad)

# Versucht das Ergebnis in eigenen Worten zu beschreiben. Was fällt Euch auf? Was ist vielleciht unklar?
