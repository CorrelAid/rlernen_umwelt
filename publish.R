# Publish selected apps on shinyapps.io
# Either you can publish all apps at once or one by one

rsconnect::accountInfo()

# Files that need to be added for all apps
files_every_time <- c(
  "www/favicon.html",
  "www/favicon.ico",
  "www/style.css",
  "www/app_parameters.yml",
  "R/setup/gradethis-setup.R",
  "R/setup/tutorial-setup.R",
  "R/setup/functions.R")

# Publish all apps at once -------------------------------------------------

# Names of the Rmd files for the apps
app_file_names <- c(
  "02_datenschutz-und-datenethik.Rmd",
  "03_grundlagen-der-statistik.Rmd",
  "04_einfuehrung-in-r.Rmd",
  "05_datenimport.Rmd",
  "05_0_datenimport-exkurs-geo.Rmd",
  "05_1_datenimport-exkurs-api.Rmd",
  "05_2_datenimport-exkurs-sql.Rmd",
  "06_daten-verstehen-mit-r.Rmd",
  "07_datentransformation.Rmd",
  "08_datentransformation.Rmd",
  "09_datenvisualisierung.Rmd",
  "10_arbeiten_mit_text.Rmd",
  "11_reports.Rmd",
  "11_0_exkurs-automatisierte-reports.Rmd",
  "12_interaktive-visualisierungen.Rmd"
)

# App names on shinyapps.io
app_names <- stringr::str_replace(app_file_names, ".Rmd", "")


# Deploy all apps
purrr::walk2(app_file_names, app_names, function(app_file_name, app_name) {
  rsconnect::deployApp(appDir = here::here(),
                       appFiles = c(app_file_name, files_every_time),
                       appName = app_name,
                       launch.browser = FALSE, # Will not open the app in the browser
                       # If the app already exists, it will be overwritten
                       # set to FALSE if you want to be asked
                       forceUpdate = TRUE
  )
})

# Deploy all apps separately -----------------------------------------------

# 02 Datenschutz und Ethik
rsconnect::deployApp(appDir = here::here(),
                     appFiles = c("02_datenschutz-und-datenethik.Rmd", files_every_time),
                     appName = "02_datenschutz-und-datenethik")

# 03 Grundlagen der Statistik
rsconnect::deployApp(appDir = here::here(),
                     appFiles = c("03_grundlagen-der-statistik.Rmd", files_every_time),
                     appName = "03_grundlagen-der-statistik")

# 04 Einführung in R
rsconnect::deployApp(appDir = here::here(),
                     appFiles = c("04_einfuehrung-in-r.Rmd", files_every_time),
                     appName = "04_einfuehrung-in-r")

# 05 Datenimport
rsconnect::deployApp(appDir = here::here(),
                     appFiles = c("05_datenimport.Rmd", files_every_time),
                     appName = "05_datenimport")

# 05_0 Datenimport geodaten
rsconnect::deployApp(appDir = here::here(),
                     appFiles = c("05_0_datenimport-exkurs-geo.Rmd", files_every_time, "daten/geospatial/"),
                     appName = "05_0_datenimport-exkurs-geodaten")

# 05_1 Datenimport api
rsconnect::deployApp(appDir = here::here(),
                     appFiles = c("05_1_datenimport-exkurs-api.Rmd", files_every_time),
                     appName = "05_1_datenimport-exkurs-api")

# 05_2 Datenimport SQL
rsconnect::deployApp(appDir = here::here(),
                     appFiles = c("05_2_datenimport-exkurs-sql.Rmd", files_every_time),
                     appName = "05_2_datenimport-exkurs-sql")

# 06 Daten verstehen mit R
rsconnect::deployApp(appDir = here::here(),
                     appFiles = c("06_daten-verstehen-mit-r.Rmd", files_every_time),
                     appName = "06_daten-verstehen-mit-r")

# 07 Datentransformation I
rsconnect::deployApp(appDir = here::here(),
                     appFiles = c("07_datentransformation.Rmd", files_every_time),
                     appName = "07_datentransformation")

# 08 Datentransformation II 
rsconnect::deployApp(appDir = here::here(),
                     appFiles = c("08_datentransformation.Rmd", files_every_time),
                     appName = "08_datentransformation")

# 09 Datenvisualisierung
rsconnect::deployApp(appDir = here::here(),
                     appFiles = c("09_datenvisualisierung.Rmd", files_every_time, "daten/geospatial/"),
                     appName = "09_datenvisualisierung")

# 10 Arbeiten mit Text 
rsconnect::deployApp(appDir = here::here(),
                     appFiles = c("10_arbeiten_mit_text.Rmd", files_every_time),
                     appName = "10_arbeiten_mit_text")


# 11 Reports
rsconnect::deployApp(appDir = here::here(),
                     appFiles = c("11_reports.Rmd", files_every_time),
                     appName = "11_reports")

# 11_0 Exkurs automatisierte Reports
rsconnect::deployApp(appDir = here::here(),
                     appFiles = c("11_0_exkurs-automatisierte-reports.Rmd", files_every_time),
                     appName = "11_0_exkurs-automatisierte-reports")

# 12 Shiny/Interaktive Visualisierungen
rsconnect::deployApp(appDir = here::here(),
                     appFiles = c("12_interaktive-visualisierungen.Rmd", files_every_time),
                     appName = "12_interaktive-visualisierungen")
