# Verificación de la versión inicial

Fecha: 22 de octubre de 2026.

- R 4.3.3 en Linux: ejecución de `R/00_generar_datos.R`, `ejecutar_todo.R`
  y `tests/validar.R` sin errores.
- Comprobados: claves únicas, 200 respuestas docentes, 30 subtotales y
  1,600 observaciones UV; diez visitas de auditoría y cuarenta ensayos UV.
- Verificados límites de clasificación, datos ausentes, exclusión de la fuente,
  emparejamiento, asignación de orden y ajuste de comparaciones múltiples.
- Cuatro figuras PNG generadas y revisadas visualmente.
- Bloques R de `practica.qmd` ejecutados con knitr 1.45; HTML autónomo producido
  con Pandoc, con cuatro imágenes incrustadas y sin bloques R pendientes.
- No se verificó la interfaz de RStudio ni el botón Render de Quarto en una
  computadora Windows. El archivo `.Rproj` usa configuración estándar y UTF-8.

Los resultados numéricos se refieren exclusivamente a los datos simulados de
esta versión. Modificar datos o reglas requiere volver a ejecutar los controles.
