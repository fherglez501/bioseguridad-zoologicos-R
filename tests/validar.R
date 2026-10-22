# Verificacion del caso distribuido. Ejecutar desde la raiz del proyecto.
# Usa R base; no instala paquetes ni cambia datos de entrada.
source("ejecutar_todo.R")
stopifnot(identical(clasificar_agudelo(c(0,99,100,349,350,400)),
  c("Deficiente","Deficiente","Regular","Regular","Bueno","Bueno")))
stopifnot(identical(clasificar_dulzaines(c(0,59,60,79,80,89,90,100)),
  c("Fuera del intervalo publicado","Fuera del intervalo publicado",
    "Desprotegido","Desprotegido","Medianamente protegido",
    "Medianamente protegido","Protegido","Protegido")))
stopifnot(clasificar_agudelo(NA_real_) == "Incompleto",
  clasificar_dulzaines(NA_real_) == "Incompleto",
  is.na(sumar_completo(c(10,NA))), sumar_completo(c(10,20)) == 30)
for (valor in c(-1,101,Inf,59.5)) {
  stopifnot(inherits(try(clasificar_dulzaines(valor), silent = TRUE), "try-error"))
}
stopifnot(nrow(agudelo_totales) == 10,
  sum(is.na(agudelo_totales$puntaje_400)) == 1,
  is.na(cambio$cambio_puntos[cambio$centro == "Z5"]),
  cambio$cambio_puntos[cambio$centro == "Z3"] == 70,
  all(dulzaines_totales$obtenido == c(57,72,83,92,47)),
  nrow(jensen_totales) == 40,
  all(table(jensen_totales$cuidador, jensen_totales$escenario) == 1),
  all(comparaciones$n_pares == 10),
  all(comparaciones$p_holm >= comparaciones$p_sin_ajuste),
  all(comparaciones$p_holm <= 1))
# Comprueba que el total se construya SOLO con los siete receptores.
manual <- sum(j$puntaje_uv[j$cuidador == "C01" &
  j$escenario == "Control" & j$terrario %in% 4:10])
stopifnot(manual == jensen_totales$total_uv[jensen_totales$cuidador == "C01" &
  jensen_totales$escenario == "Control"])
plan <- leer_csv("jensen_orden_ensayos.csv")
for (id in unique(plan$cuidador)) {
  g <- plan[plan$cuidador == id, ]
  stopifnot(setequal(g$escenario, escenarios), setequal(g$orden_ensayo,1:4))
}
stopifnot(nrow(unique(merge(j[c("cuidador","escenario","orden_ensayo")],
  plan, by = c("cuidador","escenario","orden_ensayo")))) == 40)
figuras <- file.path("resultados", c("01_agudelo_seguimiento.png",
  "02_dulzaines_brechas.png", "03_jensen_pareado.png", "03_jensen_recorrido.png"))
stopifnot(all(file.exists(figuras)), all(file.info(figuras)$size > 1000))
message("VALIDACION CORRECTA: integridad, clasificaciones, pares, tablas y figuras.")
