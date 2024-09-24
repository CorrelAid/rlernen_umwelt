#####################################
###   UEBUNG: DATENIMPORT MIT R   ###
#####################################

## Übung 1: Infrastruktur ------------------------------------------------------
# Zuerst solltet Ihr alle notwendigen Packages laden - und ggf. vorher mit "install.packages("package") installieren.



## Übung 2: Daten laden --------------------------------------------------------

### Übung 2.a: Import einer lokal gespeicherten Datei
# Im Ordner "daten" findet Ihr die Datei "plastics.csv". Versucht diese einmal lokal zu laden - nutzt dafür "Import Dataset" in Eurem Environment (in der Standardeinstellung das Fenster oben rechts) und klickt Euch über die Benutzendenoberfläche zu Eurem Datensatz. Kopiert am Ende gerne den Code, der Euch rechts unten dann angezeigt wird. 

### Übung 2.b: Import einer lokal gespeicherten Datei
# Im Ordner "daten" findet Ihr die Datei "plastics.csv". Versucht diese einmal lokal zu laden - dieses Mal ohne die Hilfe von "Import Dataset", sondern direkt mit etwas R Code. 


### Übung 2.c: Import über eine URL
# Ladet den "Plastics"-Datensatz über folgenden Link: https://raw.githubusercontent.com/CorrelAid/rlernen_umwelt/main/daten/plastics.csv.


## Bonus - Übung 3: Formatierung von deutschen Texten --------------------------
# Noch einmal zurück zur Bundeswahlleiterin und den Strukturdaten zur Bundestagswahl 20217, die uns hier (https://www.bundeswahlleiterin.de/dam/jcr/f7566722-a528-4b18-bea3-ea419371e300/btw2017_strukturdaten.csv) als CSV-Datei zum Download zur Verfügung gestellt werden. Versucht die Datei manuell zu importieren. Achtet dabei auf den im Kapitel beschriebenen Ablauf und öffnet die Datei zunächst mit einem Texteditor: Welche Formatierung (encoding) hat sie? Ihr könnt die Formatierung anschließend beim manuellen Import unter "Locale" ändern. Die 2021er Strukturdaten lagen in der UTF-8 Kodierung vor. (Test: Was passiert, wenn wir die Locale nicht ändern?). Des Weiteren müsst Ihr natürlich wieder auf die Argumente 'skip' und 'delim' achten.
