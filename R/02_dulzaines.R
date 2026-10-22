# MODULO 2. Evaluacion ponderada y priorizacion de brechas.
source("R/funciones.R")
dir.create("resultados", showWarnings = FALSE)
subtotales <- leer_csv("dulzaines_subtotales.csv")
secciones <- leer_csv("catalogo_dulzaines.csv")
stopifnot(sum(secciones$maximo) == 100, !anyDuplicated(secciones$seccion),
  !anyDuplicated(subtotales[c("centro", "seccion")]),
  all(subtotales$seccion %in% secciones$seccion))
d <- merge(subtotales, secciones, by = "seccion", all.x = TRUE)
validar_rango(d$obtenido, 0, d$maximo, "subtotales Dulzaines")
if (any(table(d$centro) != 6)) stop("Cada centro debe tener seis secciones.")
d$brecha_puntos <- d$maximo - d$obtenido
d$cumplimiento_pct <- 100 * d$obtenido / d$maximo
d$brecha_pct <- 100 - d$cumplimiento_pct
dulzaines_totales <- aggregate(obtenido ~ centro, d,
  FUN = sumar_completo, na.action = na.pass)
dulzaines_totales$categoria <- clasificar_dulzaines(dulzaines_totales$obtenido)
guardar_csv(dulzaines_totales, "02_dulzaines_totales.csv")
guardar_csv(d, "02_dulzaines_brechas.csv")
# Explore un centro: cambiar Z1 por Z2, Z3, Z4 o Z5.
centro_elegido <- "Z1"
foco <- d[d$centro == centro_elegido, ]
foco <- foco[order(foco$brecha_puntos, decreasing = TRUE), ]
iniciar_figura("02_dulzaines_brechas.png")
barplot(foco$brecha_puntos, names.arg = foco$seccion, col = "#D97706",
  ylab = "Puntos faltantes", xlab = "Seccion (consulte el catalogo)",
  main = paste("Brechas ponderadas en", centro_elegido, "| SIMULADO"))
dev.off()
# No se infiere riesgo epidemiologico de estos pesos. La decision tambien
# requiere rutas de exposicion, gravedad, evidencia, viabilidad y responsable.
print(dulzaines_totales)
print(foco[c("seccion", "maximo", "obtenido", "brecha_puntos", "brecha_pct")])
