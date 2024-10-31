#####################################
###   UEBUNG: DATENVISUALISIERUNG  ###
#####################################

## Schritt 1: Infrastruktur ----------------------------------------------------
Wie gewohnt müssen wir im ersten Schritt alle Packages installieren und laden, mit denen wir später arbeiten werden. Installiert und ladet hier das `tidyverse`-Package, falls Ihr weitere Packages benutzen wollt, fügt sie gerne hinzu!

# install.packages("tidyverse")
# install. packages("ggplot2")
library(tidyverse)

---

## Schritt 2: Daten laden ------------------------------------------------------
Auch hier ist Alles beim Alten, denn als nächstes müssen wir unseren Datensatz laden. Verwendet den Datensatz `audit`, den Ihr inzwischen schon gut kennt. Nutzt dafür das die Funktion `readr::read_csv()` oder `rio::import()`, die Daten findet Ihr unter diesem Link: rio::import('https://raw.githubusercontent.com/CorrelAid/rlernen_umwelt/main/daten/bffp2019_audit_by_country_and_company.csv')

# Audit-Datensatz laden
audit <- rio::import("https://raw.githubusercontent.com/CorrelAid/lernplattform/main/daten/bffp2019_audit_by_country_and_company.csv")

---

  ## Schritt 3: Daten bereinigen -------------------------------------------------
Die letzten zwei Wochen haben wir uns mit der Datentransformation und dem dplyr-Package beschäftigt. Auch diesen Datensatz können wir damit entsprechend bearbeiten:

# Top Ten Hersteller berechnen
top10_parentcompany <- audit %>%
  dplyr::select(parent_company, n_pieces) %>% # Spalten auswählen
  dplyr::group_by(parent_company) %>% # Pro Hersteller gruppieren
  dplyr::summarise(total_pieces = sum(n_pieces, na.rm = TRUE)) %>%
  dplyr::filter(!parent_company %in% c("Unbranded", "Inconnu", "Assorted")) %>% # Unpassende Werte Filtern
  dplyr::slice_max(total_pieces, n = 10) %>% # die Top Ten abschneiden
  dplyr::arrange(desc(total_pieces))

---
  
## Schritt 4: Übersicht verschaffen --------------------------------------------
An dieser Stelle überprüfen wir nochmal unsere Ergebnise der Datentransformation...

# Überblick
summary(top10_parentcompany)
head(top10_parentcompany)

---

## Schritt 5: Daten visualisieren
...und visualisieren sie mit `ggplot2`. Wir ordnen die Graphik innerhalb der Initialisierung nochmal mit `reorder` an und erstellen anschließend ein Bardiagramm (`geom_bar`). Wir setzen das Argument `stat = "identity`, um die tatsächlichen Werte zu reflektieren. Anschließend passen wir die Beschriftungen (Labels) so an, dass die "Anzahl an Plastikstücken" auf der y-Achse und die Firmen (also "Hersteller") auf der x-Achse angezeigt werden. Zu guter Letzt fügen wir sogar noch Labels für die Datenpunkte ein.

# Erstellung eines Barplots zu den Herstellern von Plastik
ggplot2::ggplot(data = top10_parentcompany, aes(x = total_pieces, y = reorder(parent_company, total_pieces))) + # Plot auf Basis der bearbeiteten Daten inititalisieren und Reihenfolge sicherstellen
  geom_bar(stat = "identity", fill = "#4E97AC") + # Initialisierung eines Barplots mit absoluten Werten (stat = "identity") in der Farbe blau (#4E97AC)
  labs(
    title = "Prominente Firmen aus aller Welt ...",
    subtitle = "... stellen die gefundenen Plastikverpackungen her.",
    x = "Anzahl an Plastikstücken",
    y = "Hersteller"
  ) +
  theme_minimal() +
  geom_text(aes(label = total_pieces), size = 2.5, hjust = -0.01)

---