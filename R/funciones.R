# Funciones compartidas. Solo se requiere R base (>= 4.1).
# Los puntajes son indicadores de auditoria, no probabilidades de infeccion.
leer_csv <- function(nombre) {
  read.csv(file.path("datos", nombre), stringsAsFactors = FALSE,
           na.strings = c("", "NA"), fileEncoding = "UTF-8")
}
guardar_csv <- function(x, nombre) {
  write.csv(x, file.path("resultados", nombre), row.names = FALSE,
            na = "", fileEncoding = "UTF-8")
}
validar_rango <- function(x, inferior, superior, etiqueta, entero = TRUE) {
  if (!is.numeric(x) || any(!is.na(x) & (!is.finite(x) |
      x < inferior | x > superior | (entero & x != floor(x))))) {
    stop("Valores invalidos en ", etiqueta, call. = FALSE)
  }
}
clasificar_agudelo <- function(x) {
  validar_rango(x, 0, 400, "puntaje Agudelo")
  ifelse(is.na(x), "Incompleto", ifelse(x >= 350, "Bueno",
           ifelse(x >= 100, "Regular", "Deficiente")))
}
clasificar_dulzaines <- function(x) {
  validar_rango(x, 0, 100, "puntaje Dulzaines")
  # El articulo NO define una categoria para 0-59. No se inventa una.
  ifelse(is.na(x), "Incompleto", ifelse(x >= 90, "Protegido",
    ifelse(x >= 80, "Medianamente protegido",
      ifelse(x >= 60, "Desprotegido", "Fuera del intervalo publicado"))))
}
sumar_completo <- function(x) {
  # Un dato ausente es desconocido: no equivale a cero ni se elimina.
  if (anyNA(x)) NA_real_ else sum(x)
}
iniciar_figura <- function(nombre, ancho = 1200, alto = 750) {
  png(file.path("resultados", nombre), width = ancho, height = alto, res = 120)
  par(mar = c(7, 5, 4, 2), bg = "white", col.axis = "#26364A",
      col.lab = "#26364A", col.main = "#16324F")
}
escenarios <- c("Control", "Guantes", "Utensilios", "Combinados")
