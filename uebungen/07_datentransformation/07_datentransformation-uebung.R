#####################################
###   UEBUNG: DATENBEREINIGUNG IN  R  ###
#####################################

## Übung 1: Infrastruktur ------------------------------------------------------
# Zuerst müssen wir alle notwendigen Packages laden - und ggf. vorher mit "install.packages("package") installieren.




## Übung 2: Daten laden --------------------------------------------------------
# Als nächstes müssen wir den Datensatz `plastics`, den wir inzwischen schon ganz gut kennen. Diesen findet Ihr unter diesem Link: https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-01-26/plastics.csv. Ergänzt die Funktion, die wir zum Laden einer remote gespeicherten csv-Datei verwenden:

data_raw <- rio::???("???")


## Übung 3: Datenbereinigung ---------------------------------------------------
# Um sinnvoll mit unserem Daten arbeiten zu können, müssen wir diese zunächst einmal mithilfe der `dplyr`-Verben bereinigen - dabei gehen wir Schritt für Schritt für. Ersetzt dabei in den folgenden Codes die '???' durch die entsprechenden Funktionen, Variablen oder Ausprägungen.

### Übung 3.1: Daten filtern ---------------------------------------------------
# Zuerst filtern wir die Daten nach den folgenden Bedingungen...:

# - keine 'EMPTY'-Werte für country
# - kein 'Grand Total' für parent_company
# - nur das Jahr 2019

# ... und anschließend speichern wir die gefilterten Daten in einem R-Objekt R-Objekt namens "plastics_processed".

plastics_processed <- data_raw %>%
  dplyr::???(
    country != "???",
    ??? != "Grand Total",
    year == ???
  )

### Übung 3.1: Länder bereinigen -----------------------------------------------
# Verschaffen wir uns einmal einen Überblick über alle vorhandenen Länder. Dafür können wir die die Funktion `unique()` für die Ländervariable `country` verwenden.

plastics_processed$??? %>%
  unique()

### Übung 3.2: Bereinigung Länderbezeichnungen ---------------------------------
# Wir wissen nun, welche Länder in unserem Datensatz enhalten sind - jedoch sind die Bezeichnungen nicht einheitlich. Wir wollen am Ende folgende Bezeichnungen erhalten:  

# - Großbritannien soll mit *United Kingdom* bezeichnet werden, 
# - die USA sollen mit *United States* benannt werden
# - und die Ländernamen sollen mit einem Großbuchstaben beginnen, sonst aber klein geschrieben werden.
  
# Dazu müssen wir mithilfe der `mutate()`-Funktion die Ländervariable `country` bearbeiten.

# Hinweis: Schaut Euch dafür die Hilfe zu den Funktionen `?stringr::str_replace()` und `?stringr::str_to_title()` einmal an.

plastics_processed <- plastics_processed %>%
  mutate(
    ??? = dplyr::case_when(
      ??? == "United Kingdom of Great Britain & Northern Ireland" ~ "???",
      ??? == "United States of America" ~ "???",
      TRUE ~ country
    ),
    country = str_to_title(country)
  )


### Übung 3.3: Ergänzung Ländervariable ----------------------------------------
# Nachdem wir die Ländernamen nun bereinigt haben, wollen wir noch zwei neue Variablen hinzufügen:

# - `continent`: Name des Kontinents, zu dem das Land gehört, diese sollen auch noch umbenannt werden zu Afrika, Amerika, Asien, Europa und Ozeanien,
# - `countrycode`: Countrycode des Landes in iso3c.
# - `country`: Der englische Ländername soll durch den deutschen Ländernamen ersetzt werden.

# Hinweis: Das `countrycode`-Package ist hier wahnsinnig hilfreich. Schaut gerne mal in die Dokumentation des Packages (https://cran.r-project.org/web/packages/countrycode/countrycode.pdf), bevor Ihr die Aufgabe bearbeitet.

plastics_processed <- plastics_processed %>%
  mutate(
    continent = countrycode::countrycode(country,
                                         origin = "country.name",
                                         destination = "continent"
    ),
    continent = dplyr::case_when(
      continent == "Africa" ~ "Afrika",
      continent == "Americas" ~ "Amerika",
      ??? == "Asia" ~ "???",
      ??? == "Europe" ~ "???",
      continent == "Oceania" ~ "Ozeanien"
    ),
    countrycode = countrycode::countrycode(country,
                                           origin = "country.name",
                                           destination = "iso2c"
    ),
    country = countrycode::countrycode(country,
                                       origin = "country.name",
                                       destination = "country.name.de")
)


# Perfekt - schon haben wir unseren ersten Datensatz komplett bereinigt! Aus diesem Datensatz lassen sich nun noch zwei weitere Datensätze erstellen, denen wir in den kommenden Wochen auch noch das ein oder andere Mal begegnen werden.


## Übung 4: Datensatz erstellen ------------------------------------------------

### Übung 4.1: Community-Datensatz ---------------------------------------------
# Der erste Datensatz soll der Community-Datensatz für 2019 nach Ländern sein. Folgt den Kommentaren im folgenden Code für die Transformation Eures eben erstellten `plastics_processed`-Datensatzes.

# Zuerst nehmt Ihr Euren vorhandenen Datensatz und weist diesem eine neue Bezeichnung zu...
community19_by_country <- plastics_processed %>% 
  # ...gruppiert den Datensatz nach Kontinent und Land...
  ???(continent, country) %>% 
  # ...und berechnet noch zusammenfassende Statistiken...
  ???(
    #1) Die Summe von grand_total
    n_pieces = sum(grand_total, na.rm = TRUE),
    #2) Die Anzahl an (einzelnen) Ehrenamtlichen
    n_volunteers = unique(volunteers),
    #3) Die Anzahl an (einzelnen) Events
    n_events = unique(num_events)
  )


# So schnell und einfach habt Ihr mal eben einen neuen Datensatz erstellt!


### Übung 4.2: Audit-Datensatz -------------------------------------------------
# Übung macht den Meister! Daher erstellen wir direkt noch einen zweiten Datensatz: Folgt einfach wieder den Anweisungen im Code, um den Audit-Datensatz zu erstellen.

# Zuerst nehmt Ihr Euren vorhandenen Datensatz und weist diesem eine neue Bezeichnung zu...
plastics19_by_country_and_company <- plastics_processed %>%
  # ...verändert die Form Eures Datensatz zu einem langen Format 
  # (Spalten hdpe, ldpe, o, pet, pp, ps, pvc)...
  tidyr::???(
    cols = c(hdpe, ldpe, o, pet, pp, ps, pvc),
    names_to = "plastic_type",
    values_to = "n_pieces"
    ) %>%
  # ...transformiert Eure Spalten zu Faktoren...
  dplyr::???(dplyr::across(
    .cols = c(country, continent, year, plastic_type),
    .fns = as_factor
    )) %>%
  # ...und reduziert den Datensatz auf folgende Variablen:
  # continent, country, parent_company, plastic_type, n_pieces
  dplyr::???(
    continent,
    country,
    parent_company,
    plastic_type,
    n_pieces
  )


# Kommen Euch die fertigen Datensätze irgendwie bekannt vor? Mit ihnen habt Ihr bereits in den letzten Wochen gearbeitet, damals direkt mit den bereinigten Datensätzen - jetzt könnt Ihr den Code schon selbst schreiben, sehr gut! Wenn Ihr weitere Ideen zur Bereinigung des Codes habt oder Ihr die `dplyr`-Verben nochmal testen wollt, dann macht gerne mit diesem Datensatz weiter oder versucht Euren eigenen Datensatz von Anfang an einzulesen und zu bereinigen. 