# Abrir bioseguridad-zoologicos.Rproj antes de ejecutar.
# En RStudio: source("ejecutar_todo.R")
if (!file.exists("R/funciones.R")) stop("Abra primero el proyecto .Rproj en RStudio.")
options(stringsAsFactors = FALSE)
if (!all(file.exists(file.path("datos", c("agudelo_respuestas.csv",
    "dulzaines_subtotales.csv", "jensen_uv.csv"))))) source("R/00_generar_datos.R")
dir.create("resultados", showWarnings = FALSE)
source("R/01_agudelo.R")
source("R/02_dulzaines.R")
source("R/03_jensen.R")
capture.output(sessionInfo(), file = "resultados/sesion_R.txt")
message("Listo: tablas, figuras y pruebas guardadas en resultados/.")
