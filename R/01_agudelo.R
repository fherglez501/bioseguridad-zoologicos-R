# MODULO 1. Diagnostico de salud publica y seguimiento.
source("R/funciones.R")
dir.create("resultados", showWarnings = FALSE)
respuestas <- leer_csv("agudelo_respuestas.csv")
catalogo <- leer_csv("catalogo_agudelo.csv")
stopifnot(!anyDuplicated(respuestas[c("centro", "visita", "item")]),
          !anyDuplicated(catalogo$item), nrow(catalogo) == 20,
          sum(catalogo$maximo) == 400, all(respuestas$item %in% catalogo$item))
validar_rango(respuestas$respuesta, 0, 4, "respuesta Agudelo")
a <- merge(respuestas, catalogo, by = "item", all.x = TRUE)
# Conversion de la escala docente de cumplimiento 0-4 a puntos 0-20.
a$puntos <- a$respuesta / 4 * a$maximo
grupos <- split(a, interaction(a$centro, a$visita, drop = TRUE))
agudelo_totales <- do.call(rbind, lapply(grupos, function(g) {
  if (nrow(g) != 20) stop("Faltan indicadores en ", g$centro[1])
  total <- sumar_completo(g$puntos)
  data.frame(centro = g$centro[1], visita = g$visita[1],
    respondidos = sum(!is.na(g$respuesta)), esperados = 20,
    puntaje_400 = total, categoria = clasificar_agudelo(total))
}))
rownames(agudelo_totales) <- NULL
# Un total no se extrapola a 400 si falta un indicador.
guardar_csv(agudelo_totales, "01_agudelo_totales.csv")
perfil <- aggregate(cbind(puntos, maximo) ~ centro + visita + concepto,
  data = a, FUN = sumar_completo, na.action = na.pass)
perfil$porcentaje <- 100 * perfil$puntos / perfil$maximo
guardar_csv(perfil, "01_agudelo_perfiles.csv")
cambio <- merge(agudelo_totales[agudelo_totales$visita == "Inicial", c("centro", "puntaje_400")],
  agudelo_totales[agudelo_totales$visita == "Seguimiento", c("centro", "puntaje_400")],
  by = "centro", suffixes = c("_inicial", "_seguimiento"))
cambio$cambio_puntos <- cambio$puntaje_400_seguimiento - cambio$puntaje_400_inicial
guardar_csv(cambio, "01_agudelo_cambios.csv")
iniciar_figura("01_agudelo_seguimiento.png")
mat <- rbind(cambio$puntaje_400_inicial, cambio$puntaje_400_seguimiento)
barplot(mat, beside = TRUE, names.arg = cambio$centro, ylim = c(0, 420),
  col = c("#94A3B8", "#087E8B"), ylab = "Puntaje docente (0-400)",
  main = "Salud publica: linea de base y seguimiento | SIMULADO")
abline(h = c(100, 350), lty = 2, col = "#B45309")
legend("topleft", c("Inicial", "Seguimiento"), fill = c("#94A3B8", "#087E8B"), bty = "n")
mtext("Z5 inicial: dato faltante; no se representa como cero", side = 1, line = 4)
dev.off()
print(agudelo_totales)
message("Modulo 1 completo. Revise por que Z5 inicial esta incompleto.")
