# MODULO 3. Transferencia de trazador UV en un diseno con medidas repetidas.
source("R/funciones.R")
dir.create("resultados", showWarnings = FALSE)
j <- leer_csv("jensen_uv.csv")
validar_rango(j$puntaje_uv, 0, 3, "puntaje UV")
stopifnot(!anyNA(j), nrow(j) == 1600,
  !anyDuplicated(j[c("cuidador", "escenario", "terrario", "superficie")]),
  setequal(j$escenario, escenarios), length(unique(j$cuidador)) == 10,
  setequal(j$terrario, 1:10),
  setequal(j$superficie, c("Pared", "Refugio", "Sustrato", "Bebedero")))
if (any(table(j$cuidador, j$escenario) != 40)) stop("Diseno incompleto.")
j$escenario <- factor(j$escenario, levels = escenarios)
j$cuidador <- factor(j$cuidador)
# Se registra todo el recorrido, pero se excluyen fuente y controles previos
# del resultado principal, igual que en el articulo.
receptores <- j[j$terrario >= 4 & j$terrario <= 10, ]
jensen_totales <- aggregate(puntaje_uv ~ cuidador + escenario, receptores, sum)
names(jensen_totales)[3] <- "total_uv"
validar_rango(jensen_totales$total_uv, 0, 84, "total UV")
guardar_csv(jensen_totales, "03_jensen_totales.csv")
resumen_jensen <- do.call(rbind, lapply(escenarios, function(e) {
  x <- jensen_totales$total_uv[jensen_totales$escenario == e]
  data.frame(escenario = e, n_cuidadores = length(x), media = mean(x),
    mediana = median(x), desviacion = sd(x), minimo = min(x), maximo = max(x))
}))
guardar_csv(resumen_jensen, "03_jensen_resumen.csv")
# Friedman bloquea por cuidador; apropiado como introduccion para puntuaciones
# acotadas/ordinales agregadas. Son 10 bloques, no 280 terrarios independientes.
prueba_friedman <- friedman.test(total_uv ~ escenario | cuidador, data = jensen_totales)
# Comparaciones planificadas contra control: diferencias EMPAREJADAS.
control <- jensen_totales[jensen_totales$escenario == "Control", ]
comparaciones <- do.call(rbind, lapply(escenarios[-1], function(e) {
  otro <- jensen_totales[jensen_totales$escenario == e, ]
  par <- merge(control[c("cuidador", "total_uv")], otro[c("cuidador", "total_uv")],
    by = "cuidador", suffixes = c("_control", "_intervencion"))
  # Una diferencia negativa indica menos transferencia UV que el control.
  delta <- par$total_uv_intervencion - par$total_uv_control
  p <- if (all(delta == 0)) 1 else wilcox.test(delta, mu = 0, exact = FALSE)$p.value
  data.frame(escenario = e, n_pares = nrow(par),
    diferencia_media = mean(delta), diferencia_mediana = median(delta),
    reduccion_medias_pct = if (mean(par$total_uv_control) > 0)
      100 * (1 - mean(par$total_uv_intervencion) / mean(par$total_uv_control)) else NA_real_,
    p_sin_ajuste = p)
}))
comparaciones$p_holm <- p.adjust(comparaciones$p_sin_ajuste, method = "holm")
guardar_csv(comparaciones, "03_jensen_comparaciones.csv")
# Extension opcional: ANOVA con error de medidas repetidas. Revisar supuestos
# y esfericidad antes de usarlo en investigacion; no es el analisis principal.
anova_repetidas <- aov(total_uv ~ escenario + Error(cuidador/escenario),
                       data = jensen_totales)
capture.output(prueba_friedman, comparaciones, summary(anova_repetidas),
  file = file.path("resultados", "03_jensen_estadistica.txt"))

iniciar_figura("03_jensen_pareado.png")
plot(1, type = "n", xlim = c(0.7, 4.3), ylim = c(0, 84), xaxt = "n",
  xlab = "", ylab = "Suma UV en terrarios 4-10 (0-84)",
  main = "Cada linea representa al mismo cuidador | SIMULADO")
axis(1, at = 1:4, labels = escenarios)
for (id in levels(jensen_totales$cuidador)) {
  g <- jensen_totales[jensen_totales$cuidador == id, ]
  g <- g[match(escenarios, as.character(g$escenario)), ]
  lines(1:4, g$total_uv, col = "#94A3B8", lwd = 1)
  points(1:4, g$total_uv, col = "#94A3B8", pch = 16)
}
lines(1:4, resumen_jensen$media, col = "#087E8B", lwd = 4, type = "b", pch = 19)
legend("topright", c("Cuidador", "Media"), col = c("#94A3B8", "#087E8B"), lwd = c(1,4), bty = "n")
dev.off()
por_terrario <- aggregate(puntaje_uv ~ cuidador + escenario + terrario, j, sum)
medias <- aggregate(puntaje_uv ~ escenario + terrario, por_terrario, mean)
iniciar_figura("03_jensen_recorrido.png")
plot(1, type = "n", xlim = c(1,10), ylim = c(0,12), xlab = "Orden del terrario",
  ylab = "Puntaje UV medio por terrario (0-12)",
  main = "Controles 1-2 | fuente 3 | receptores 4-10 | SIMULADO")
cols <- c("#B45309", "#2563EB", "#7C3AED", "#087E8B")
for (i in 1:4) {
  g <- medias[medias$escenario == escenarios[i], ]; g <- g[order(g$terrario), ]
  lines(g$terrario, g$puntaje_uv, type = "b", col = cols[i], pch = i, lwd = 2)
}
abline(v = 3, lty = 2, col = "#64748B")
legend("topright", escenarios, col = cols, lty = 1, pch = 1:4, bty = "n")
dev.off()
print(resumen_jensen); print(prueba_friedman); print(comparaciones)
message("El trazador representa transferencia mecanica; no mide infeccion ni viabilidad.")
