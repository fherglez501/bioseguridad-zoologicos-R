# Regenera datos ARTIFICIALES. No son registros de los articulos ni de un zoologico.
# Se ejecuta una sola vez o cuando se quiera reiniciar el caso.
source("R/funciones.R")
set.seed(22102026)
dir.create("datos", showWarnings = FALSE)
escribir <- function(x, n) write.csv(x, file.path("datos", n),
  row.names = FALSE, na = "", fileEncoding = "UTF-8")

# 1. Agudelo: version didactica abreviada, con 20 indicadores x 20 puntos.
# La publicacion no aporta el baremo completo por item. Estos pesos son DOCENTES.
conceptos <- rep(c("Salud animal", "Salud ambiental", "Seguridad",
                   "Conservacion", "Educacion"), each = 4)
indicadores <- c("Registros de eventos de salud", "Estadisticas de morbilidad y mortalidad",
 "Vigilancia de zoonosis", "Refugio y comportamiento natural",
 "Gestion de residuos", "Higiene de alimentos", "Manejo de cadaveres", "Control ambiental documentado",
 "Capacitacion en bioseguridad", "Requisitos de salud ocupacional", "Informacion al visitante", "Plan de evacuacion",
 "Programa de conservacion", "Actividades de conservacion", "Registro de especies involucradas", "Seguimiento del programa",
 "Programa educativo", "Actividades educativas", "Educacion en salud publica", "Evaluacion de actividades educativas")
catalogo <- data.frame(item = sprintf("A%02d", 1:20), concepto = conceptos,
  indicador = indicadores,
  instrumento = c("Director o MVZ", "Director o MVZ", "Director o MVZ", "Exhibicion",
    "Encuestador", "Encuestador", "Encuestador", "Director o MVZ",
    "Trabajadores", "Trabajadores", "Exhibicion", "Encuestador",
    rep("Director o MVZ", 8)), maximo = 20L,
  origen = "Adaptacion docente no validada")
escribir(catalogo, "catalogo_agudelo.csv")
a <- expand.grid(item = catalogo$item, centro = paste0("Z", 1:5),
  visita = c("Inicial", "Seguimiento"), stringsAsFactors = FALSE)
base <- c(Z1 = 0.35, Z2 = 0.50, Z3 = 0.65, Z4 = 0.78, Z5 = 0.90)
a$respuesta <- rbinom(nrow(a), 4, pmin(0.98, base[a$centro] +
  ifelse(a$visita == "Seguimiento", 0.12, 0)))
# Respuesta 0,1,2,3,4 equivale a 0,5,10,15,20 puntos, siempre didacticos.
a$respuesta[a$centro == "Z5" & a$visita == "Inicial" & a$item == "A20"] <- NA
a$procedencia <- "SIMULADO"
escribir(a, "agudelo_respuestas.csv")

# 2. Dulzaines: se conservan los SEIS maximos publicados (9+20+16+29+18+8).
# Se trabaja con subtotales por acapite, no con una reconstruccion del Anexo 1.
secciones <- data.frame(seccion = paste0("D", 1:6),
  nombre = c("Ubicacion, vinculos y traslado", "Control sanitario y saneamiento",
    "Alimentacion, conservacion y suministro de agua",
    "Diagnostico y vigilancia epizootiologica", "Salud y estado de la exhibicion",
    "Inmunoprofilaxis, medicina preventiva y terapeutica"),
  maximo = c(9, 20, 16, 29, 18, 8))
escribir(secciones, "catalogo_dulzaines.csv")
# Cinco escenarios ficticios: sirven para descubrir diferencias entre brecha
# absoluta y porcentaje de cumplimiento; no son una muestra poblacional.
puntos <- rbind(c(4, 10, 8, 18, 12, 5), c(6, 13, 11, 22, 14, 6),
                c(7, 16, 13, 25, 15, 7), c(8, 18, 15, 27, 17, 7),
                c(3, 8, 6, 16, 10, 4))
d <- do.call(rbind, lapply(1:5, function(i) data.frame(
  centro = paste0("Z", i), seccion = secciones$seccion,
  obtenido = puntos[i, ], procedencia = "SIMULADO")))
escribir(d, "dulzaines_subtotales.csv")

# 3. Jensen: 10 cuidadores x 4 escenarios x 10 terrarios x 4 superficies.
# El cuidador es el bloque; cada uno realiza los cuatro escenarios.
plan <- do.call(rbind, lapply(sprintf("C%02d", 1:10), function(id)
  data.frame(cuidador = id, escenario = sample(escenarios), orden_ensayo = 1:4)))
escribir(plan, "jensen_orden_ensayos.csv")
superficies <- c("Pared", "Refugio", "Sustrato", "Bebedero")
filas <- list(); k <- 0L
efecto_cuidador <- runif(10, 0.75, 1.25)
for (i in seq_len(nrow(plan))) {
  ensayo <- plan[i, ]; ci <- match(ensayo$cuidador, sprintf("C%02d", 1:10))
  tasa <- c(Control = 0.43, Guantes = 0.27, Utensilios = 0.40, Combinados = 0.035)
  for (ter in 1:10) for (sup in superficies) {
    # Terrarios 1-2: controles previos. Terrario 3: fuente. 4-10: receptores.
    pr <- if (ter < 3) 0 else if (ter == 3) 1 else
      min(0.95, tasa[ensayo$escenario] * efecto_cuidador[ci] * exp(-0.13 * (ter - 4)))
    puntaje <- if (ter == 3) 3L else rbinom(1, 3, pr)
    k <- k + 1L
    filas[[k]] <- data.frame(cuidador = ensayo$cuidador,
      escenario = ensayo$escenario, orden_ensayo = ensayo$orden_ensayo,
      terrario = ter, superficie = sup, puntaje_uv = puntaje,
      procedencia = "SIMULADO")
  }
}
escribir(do.call(rbind, filas), "jensen_uv.csv")
message("Datos simulados generados con semilla 22102026.")
