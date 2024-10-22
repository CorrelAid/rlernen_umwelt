###############################################
###   UEBUNG: DATENTRANSFORMATION ADVANCED  ###
###############################################

## Teil 1: Infrastruktur -------------------------------------------------------
# Zuerst müssen wir den Datensatz und alle notwendigen Packages laden bzw. diese ggf. vorher mit "install.packages("package") installieren.
library(readr)
library(dplyr)
library(tidyverse)
library(tidyr)

# Import des audit-Datensatzes
audit <- read_csv("https://raw.githubusercontent.com/CorrelAid/rlernen_umwelt/refs/heads/main/daten/bffp2019_audit_by_country_and_company.csv")

## Übung 1: Pivoting von Datensätzen -------------------------------------------
# Wir wollen uns anschauen, wie viele Plastikteile pro Marke und Land gesammelt wurden. Da unser Datensatz insgesamt über 7.000 Firmen enthält, wollen wir uns einmal auf die "Top 10" der Firmen beschränken, die am meisten Plastikmüll verursachen. Wir verwenden die Funktion pivot_longer(), um die Daten zu pivotieren, sodass die Marken ("brand") die Spalten und die Länder ("country") die Zeilen darstellen. Ergänzt die Codes an den entsprechenden Stellen (???).

---

### Übung 1.1: Berechnung der Top 10 Firmen ------------------------------------
# Zunächst berechnet Ihr die Top 10 Firmen nach der Gesamtanzahl der gesammelten Plastikteile. Wir haben das so ähnlich bereits in der vergangenen Woche einmal gemacht!

# Ihr nehmt Euren Datensatz...
top10_companies <- audit %>%

# ... und gruppiert die Daten nach der Spalte "parent_company", um für jede Firma eine Summe zu berechnen.
  dplyr::group_by(???) %>%

# Dann berechnet Ihr die Gesamtsumme der gesammelten Plastikteile ("n_pieces") für jede Firma. Wichtig: Mit dem Argument "na.rm = TRUE" sorgt Ihr dafür, dass fehlende Werte (NA) ignoriert werden.
  dplyr::summarise(total_pieces = sum(???, na.rm = TRUE)) %>%
  
# Anschließend sortiere die Firmen absteigend nach der Anzahl der gesammelten Plastikteile...
  dplyr::arrange(dplyr::desc(total_pieces)) %>%
  
# ... wobei Ihr Euch ausschließlich auf die obersten 10 Firmen beschränken wollt.
  dplyr::slice(1:10) %>%
  
# Mit der Funktion "pull(parent_company)" extrahieren wir die Namen der Top 10 Firmen als Vektoren...
  dplyr::pull(parent_company)

# .. und filtern den ursprünglichen Datensatz, um nur diese Top 10 Firmen zu behalten.
pivot_audit <- audit %>%
  dplyr::???(parent_company %in% top10_companies) %>%

---
  
### Übung 1.2: Pivoting des Datensatzes ----------------------------------------
# nachdem wir nun die Top 10 der müllproduzierenden Firmen extrahiert haben, können wir mit den gefilterten Daten weitermachen.

# Die gefilterten Daten müsst Ihr erneut nach Land ("country") und Mutterkonzern ("parent_company") filtern. Diese Gruppierung ist notwendig, um die Summe der Plastikteile für jede Kombination aus Land und Firma zu berechnen.
  dplyr::group_by(???, ???) %>%
  
# Anschließend berechnet Ihr die Summe der gesammelten Plastikteile ("n_pieces") pro Kombination aus Land und Firma. Nutzt dabei wieder das Argument "na.rm = TRUE", um fehlende Werte zu ignorieren.
  dplyr::???(n_pieces = sum(???, na.rm = TRUE)) %>%
  
# Nun wandelt Ihr die Daten in eine breite Form um, bei der jede "parent_company" zu einer Spalte wird.
  tidyr::???(names_from = parent_company, values_from = n_pieces, values_fill = 0)

  # "names_from" definiert, welche Werte als Spaltennamen verwendet werden.
  # "values_from" gibt an, welche Daten in die Zellen geschrieben werden sollen.
  # "values_fill" füllt fehlende Werte mit 0, falls es keine Plastikteile für eine Firma in einem bestimmten Land gibt.

# Zum Abschluss zeigt Ihr die neue Tabelle in einer Ansicht an, um das Ergebnis zu überprüfen.
view(pivot_audit)


## Übung 2: Joining von Datensätzen --------------------------------------------

### Übung 2.1: Zweiten Datensatz erstellen -------------------------------------
# Zunächst einmal müssen wir einen zweiten Datensatz erstellen, den wir mit unserem audit-Datensatz zusammenfügen können. Wir haben hier einen kleinen Datensatz für Euch vorbereitet, der ein paar zusätzliche Informationen (BIP und Einwohnerzahl) zu einigen Ländern enthält. Somit entstehen zwei neue Variablen "population" und "gdp_per_capita". 
country_info <- tibble::tibble(
  country = c("Vereinigte Staaten", "Indien", "Indonesien", "Brasilien", "Deutschland"),
  population = c(331002651, 1380004385, 273523615, 212559417, 83783942),  # Einwohnerzahlen
  gdp_per_capita = c(65279, 2100, 3896, 6793, 46300)  # BIP pro Kopf in USD
)

---

### Übung 2.1: Zusammenführen der Datensätze -----------------------------------
# Nun wollen wir unsere beiden Datensätze zusammenfügen und die verschiedenen Formen des joinings noch einmal üben. Wichtig ist dabei, dass wir eine gemeinsame Variable angeben, anhand derer unsere Daten zugeordnet werden können. In diesem fall ist die Variable "country" in beiden Datensätzen enthalten.

# Führe ein full_join durch, um alle Einträge aus beiden Datensätzen zu behalten und alle fehlenden Werte (NA) entsprechend zu füllen.

joined_full <- dplyr::???(audit, country_info, by = "???")

# Der resultierende Datensatz enthält alle Länder, die entweder in "audit" oder in "country_info" vorkommen. Wenn für ein Land nur in einem der beiden Datensätze Informationen vorhanden sind, werden die anderen Felder mit NA gefüllt.

---

## Führe einen left_join durch, um alle Länder aus "audit" zu behalten.

joined_left <- dplyr::???(audit, country_info, by = "???")

# Der resultierende Datensatz enthält alle Länder aus "audit", auch wenn keine passenden Einträge in "country_info" gefunden wurden. Die zusätzlichen Informationen sind dann "NA".

---
  
# Führe einen inner_join durch, um nur die Länder zu behalten, die in beiden Datensätzen vorkommen.

joined_inner <- dplyr::???(audit, country_info, by = "???")

# Der resultierende Datensatz enthält nur die Länder, die in beiden Datensätzen vorkommen. Alle anderen Länder werden ausgeschlossen.

---
  
### Übung 2.4: Interpretation --------------------------------------------------

# Welchen Einfluss haben die verschiedenen Join-Arten auf die Größe des resultierenden Datensatzes?
  1. Full Join: Ein full_join kombiniert alle Einträge aus beiden Datensätzen. Das Ergebnis wird so groß sein wie die Anzahl der eindeutigen Länder aus beiden Datensätzen. Fehlende Werte werden mit NA gefüllt. Dies führt oft zu einem Datensatz, der mehr Zeilen enthält als beide ursprünglichen Datensätze, insbesondere wenn Länder nur in einem der beiden Datensätze vorhanden sind.
  2. Left Join: Ein left_join behält alle Einträge aus dem audit-Datensatz bei, selbst wenn es keine passenden Einträge im country_info-Datensatz gibt. Das Ergebnis wird also mindestens so groß sein wie der audit-Datensatz. Fehlende Werte im country_info-Datensatz werden als NA angezeigt, was bedeutet, dass das Ergebnis mehr Zeilen enthalten kann, je nachdem, wie viele Länder im country_info nicht vorhanden sind.
  3. Inner Join: Bei einem inner_join werden nur die Einträge behalten, die in beiden Datensätzen einen passenden Wert haben. Das bedeutet, dass nur Länder, die sowohl im audit-Datensatz als auch im country_info-Datensatz vorhanden sind, in das Ergebnis aufgenommen werden. Daher ist die Größe des resultierenden Datensatzes in der Regel kleiner als die der beiden ursprünglichen Datensätze, insbesondere wenn einer der Datensätze viele Länder oder Einträge ohne Übereinstimmung enthält.

# Welche Länder fallen bei einem inner_join weg und warum?
Bei einem inner_join werden nur die Länder, die in beiden Datensätzen vorhanden sind, berücksichtigt. Das bedeutet, dass Länder im audit-Datensatz, die nicht im country_info-Datensatz aufgeführt sind, wegfallen. Beispielsweise könnte ein Land wie "China" im audit-Datensatz aufgeführt sein, aber nicht im country_info-Datensatz. In diesem Fall würde "China" aus dem Ergebnis des inner_join entfernt werden. Ebenso könnten Länder im country_info-Datensatz, die im audit-Datensatz keine Daten haben, ebenfalls nicht im Ergebnis erscheinen. Dies ist wichtig für die Analyse, da wir möglicherweise relevante Informationen über bestimmte Länder verlieren.

# Wie könnte man fehlende Werte nach einem full_join sinnvoll behandeln?
Nach einem full_join ist es üblich, dass einige Werte in den Spalten des country_info-Datensatzes NA sein können, insbesondere für Länder, die nur in einem der beiden Datensätze vorhanden sind. Hier sind einige Ansätze, um mit fehlenden Werten umzugehen:
  
  1. Ersetzen mit Standardwerten: Man könnte NA-Werte durch Standardwerte ersetzen, wie z.B. einen Median oder Durchschnitt, um die Analyse nicht zu verzerren. Zum Beispiel könnte man für das BIP den globalen Durchschnitt verwenden, um fehlende Werte aufzufüllen.
  2. Datenanalyse nur mit vollständigen Fällen: In einigen Fällen könnte es sinnvoll sein, nur vollständige Fälle zu betrachten. Das kann durch die Verwendung von na.omit() erreicht werden, was alle Zeilen mit mindestens einem fehlenden Wert entfernt.
  3. Visualisierung der fehlenden Werte: Vor der Entscheidung, wie man mit fehlenden Werten umgeht, könnte man eine Visualisierung der fehlenden Werte durchführen, z.B. mit der VIM-Bibliothek, um besser zu verstehen, wie viele und welche Werte fehlen.
  4. Separate Analyse der fehlenden Werte: Es könnte auch hilfreich sein, eine separate Analyse der Länder mit fehlenden Werten durchzuführen, um zu verstehen, warum diese Informationen fehlen, und zu prüfen, ob diese Länder für die Analyse von Bedeutung sind.
  5. Imputation: Eine fortgeschrittene Methode zur Behandlung fehlender Werte ist die Imputation, bei der fehlende Werte basierend auf den vorhandenen Daten geschätzt werden, z.B. durch lineare Regression oder andere statistische Methoden.
  
  