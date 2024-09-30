#####################################
  ###   UEBUNG: DATENVISUALISIERUNG  ###
#####################################

Wie gewohnt, gibt es auch in dieser Woche eine R-Datei, die Ihr dafür verwenden könnt, um das Gelernte noch einmal selbst zu üben. An manchen Stellen müsst Ihr Code selbst schreiben oder bearbeiten. Ersetzt dazu die entsprechenden Stellen (gekennzeichnet durch ???) durch die dafür vorgesehene Funktion und/oder Variable. 

## Schritt 1: Infrastruktur ----------------------------------------------------
Wie gewohnt müssen wir im ersten Schritt alle Packages installieren und laden, mit denen wir später arbeiten werden. Installiert und ladet hier das `tidyverse`-Package, falls Ihr weitere Packages benutzen wollt, fügt sie gerne hinzu!


---

## Schritt 2: Daten laden ------------------------------------------------------
Auch hier ist Alles beim Alten, denn als nächstes müssen wir unseren Datensatz laden. Verwendet den Datensatz `audit`, den Ihr inzwischen schon gut kennt. Nutzt dafür das die Funktion `readr::read_csv()` oder `rio::import()`, die Daten findet Ihr unter diesem Link: rio::import('https://raw.githubusercontent.com/CorrelAid/rlernen_umwelt/main/daten/bffp2019_audit_by_country_and_company.csv')


---

## Schritt 3: Daten bereinigen -------------------------------------------------
Die letzten zwei Wochen haben wir uns mit der Datentransformation und dem dplyr-Package beschäftigt. Auch diesen Datensatz können wir damit entsprechend bearbeiten:

# Top Ten Hersteller berechnen
top10_parentcompany <- audit %>%
  dplyr::select(parent_company, n_pieces) %>% # Spalten auswählen
  dplyr::group_by(parent_company) %>% # Pro Hersteller gruppieren
  dplyr::summarise(total_pieces = sum(n_pieces, na.rm = TRUE)) %>%
  dplyr::filter(! parent_company %in% c("Unbranded", "Inconnu", "Assorted"))  %>% # Unpassende Werte Filtern
  dplyr::slice_max(total_pieces, n = 10) %>% # die Top Ten abschneiden
  dplyr::arrange(desc(total_pieces))

---

## Schritt 4: Übersicht verschaffen --------------------------------------------
An dieser Stelle überprüfen wir nochmal unsere Ergebnise der Datentransformation...

# Überblick
???(top10_parentcompany)
head(???)

---

## Schritt 5: Daten visualisieren
...und visualisieren sie mit `ggplot2`. Wir ordnen die Graphik innerhalb der Initialisierung nochmal mit `reorder` an und erstellen anschließend ein Bardiagramm (`geom_bar`). Wir setzen das Argument `stat = "identity`, um die tatsächlichen Werte zu reflektieren. Anschließend passen wir die Beschriftungen (Labels) so an, dass die "Anzahl an Plastikstücken" auf der y-Achse und die Firmen (also "Hersteller") auf der x-Achse angezeigt werden. Zu guter Letzt fügen wir sogar noch Labels für die Datenpunkte ein.

# Erstellung eines Barplots zu den Herstellern von Plastik
ggplot2::ggplot(data = ???, 
                aes(x = ???, y = reorder(parent_company, total_pieces))) + # Plot auf Basis der bearbeiteten Daten inititalisieren und Reihenfolge sicherstellen
  geom_???(stat = "identity", fill = "#4E97AC") + # Initialisierung eines Barplots mit absoluten Werten (stat = "identity") in der Farbe blau (#4E97AC)
  ???(
    title = "Prominente Firmen aus aller Welt ..." ,
    subtitle = "... stellen die gefundenen Plastikverpackungen her.",
    x = "???",
    y = "???"
  ) +
  theme_minimal() +
  geom_text(aes(label = total_pieces), size = 2.5, hjust = -0.01)

---