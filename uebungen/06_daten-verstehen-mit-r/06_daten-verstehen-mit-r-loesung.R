#########################################
###   UEBUNG: DATEN VERTSEHEN MIT  R  ###
#########################################

## Übung 1: Zusammenfassung ----------------------------------------------------
# Versucht, anhand der präsentierten Datenanalyse folgende Fragen zu beantworten.

# 1.  Wie viel Plastik wurde insgesamt gesammelt?


# 2.  Wie viel Plastik wurde durchschnittlich je Kontinent gesammelt?


# 3.  Welche Faktoren beeinflussen möglicherweise diese Unterschiede?



## Übung 2: Fragen -------------------------------------------------------------
# Welche Fragen könnten wir uns denn (unter Berücksichtigung unseres Datensatzes) noch stellen? Wie könnte eine Visualisierung oder eine zusammenfassende Statistik dabei helfen? Skizziert Eure Fragen gerne schriftlich.



## Übung 3: Wiederholung -------------------------------------------------------
# Versucht, mithilfe dieser R-Datei die folgenden Codes selbst auszuführen und zu verstehen. Geht dabei gerne Schritt für Schritt durch: Markiert Euch Code-Abschnitte und führt diese mithilfe von 'CMD + ENTER' (für Mac) bzw. 'CTRL + ENTER' (für Windows) aus. Wenn Ihr Code hinzufügt, könnt Ihr das direkt im Code-Editor machen.

### Schritt 1: Infrastruktur ----

# Notwendige Packages laden - ggf. vorher mit install.packages("package") installieren
library(rio)
library(tidyverse)
library(ggplot2)
library(dplyr)
library(countrycode)

### Schritt 2: Daten laden ----
# Im Ordner 'daten' findet Ihr die Datei 'bffp2019_community_by_country.csv', die Ihr für diese Übung in R ladet. 

### Community Datensatz laden
community <- rio::import(here::here('daten/bffp2019_community_by_country.csv'))


### Schritt 3: Daten bereinigen ---
# Diesen Schritt haben wir an dieser Stelle schon einmal für Euch übernommen. Ihr müsst hier also nichts weiter tun. Aber denkt dran: Normalerweise ist dieser Schritt super wichtig, weshalb wir uns diesen in den beiden Sessions zum Thema 'Datentransformation' noch genauer anschauen werden!

### Schritt 4: Übersicht verschaffen ----
# Kleine Leitfragen können an dieser Stelle durchaus hilfreich sein: Wie viele Zeilen hat der Datensatz und was schauen wir uns in dieser Zeile überhaupt an? Wie viele Variablen hat der Datenatz und wofür stehen die Abkürzungen?

# Überblick über die Community verschaffen
dplyr::glimpse(community)

# Überblick über den Plastik-Audit verschaffen
dplyr::glimpse(audit)


## Übung 4.1: Variable 'n_volunteers' ------------------------------------------
# Bislang haben wir uns der Variable 'n_pieces' gewidmet und möchten nun die Variable der Freiwilligen 'n_volunteers' betrachten: Wie sehr unterscheiden sich beispielsweise die Freiwilligenzahlen nach Kontinenten? Beantworten wir diese Frage doch mit einem Punktediagramm (Scatterplot)! Führt dazu einmal den folgenden Code aus und versucht, die Grafik in eigenen Worten zu beschreiben und zu interpretieren:

ggplot(data = community, 
       aes(x = continent, # x-Achse zeigt die Kontinente
           y = n_volunteers)) +  # y-Achse zeigt die Freiwilligenanzahl
  geom_jitter(size = 3, # Größe der Punkte
              alpha = 0.6, # Transparenz der Punkte
              width = 0.2) +  # Breite der Punkt-jitter pro Kategorie
  labs(title = "Auch die Anzahl freiwillig Engagierter bei 'Break Free From Plastic' ..." ,
       subtitle = "... unterscheidet sich nach Kontinent und Land.",
       y = "Anzahl freiwilliger Helfer*innen", # y-Achsenbezeichnung 
       x = "Kontinente", # x-Achsenbezeichnung
       caption = "Datenquelle: TidyTuesday und BFFP") + # Festlegung der Achsenbezeichungen, Überschriften und Titel
  theme_minimal() + # Festlegung des Layout-Designs  
  theme(legend.position ="none") # Ausblenden der Legende


## Übung 4.2: Interpretation ---------------------------------------------------
# Versuchen wir uns an der Interpretation der Graphik: Was können wir ablesen? Wo gibt es Limitationen?
