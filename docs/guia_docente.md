# Guía docente y criterios propuestos

## Alcance

Pregrado en Medicina Veterinaria o áreas afines. Se presupone una introducción
a bioseguridad, salud pública y lectura de tablas; no experiencia previa con R.
Se propone 180 minutos en una sesión o tres sesiones de 60 minutos. Modalidad
individual o parejas, con entrega identificada por estudiante/equipo.

Al finalizar, el estudiantado calculará y explicará los tres análisis con datos
simulados, distinguirá diagnóstico de evaluación experimental y propondrá tres
acciones verificables. Los criterios son una propuesta para esta actividad.

## Alineación

| Resultado observable | Contenido y actividad | Evidencia | Criterio | Tiempo | Fuente |
|---|---|---|---|---:|---|
| Calcular el perfil y el cambio sin imputar ceros | Lectura de CSV, índice docente, dimensiones y ausencias | Tabla, figura y explicación de Z5 | Integridad y denominadores correctos | 50 min | Agudelo 2009, pp. 776–779 |
| Comparar dos formas de priorizar brechas | Sumar seis acápites; ordenar brechas absoluta y relativa | Tabla ordenada y prioridades | Máximos y laguna <60 reconocidos | 50 min | Dulzaines 2010, pp. 2–5 |
| Comparar cuatro escenarios preservando el cuidador | Agregación, gráfica pareada, Friedman y Wilcoxon–Holm | Figura y efecto con límites | Sin pseudorreplicación ni inferencia de infección | 60 min | Jensen 2021, pp. 158–159 |
| Proponer acciones con verificación | Síntesis de los tres módulos y reflexión | Matriz de tres acciones | Evidencia, responsable, plazo, indicador y meta | 20 min | Integración docente; Agudelo 2017 |

## Conducción sugerida

**Inicio del primer bloque:** preguntar si un zoológico con una calificación
alta puede mantener una brecha importante. Mostrar las cinco dimensiones.
Explicar `<-`, `$`, selección `[filas, columnas]`, `source()` y `NA`.

**Desarrollo:** ejecutar por selecciones, pedir interpretación antes de mostrar
la siguiente línea y contrastar total con perfil. En el segundo bloque, dejar
que el grupo descubra las ponderaciones y la categoría ausente. En el tercero,
dibujar conceptualmente las cuatro mediciones del mismo cuidador y preguntar
qué observaciones serían independientes.

**Cierre:** cada estudiante/equipo presenta una acción verificable y una
limitación. La evidencia de cierre es la matriz y las tres conclusiones.

No se requiere visita, animales, personal real ni datos identificables. Para
aplicación de campo posterior se deben redefinir indicadores, fuentes y reglas
de puntuación, revisar su pertinencia y evaluar confiabilidad y validez. Esta
práctica informática no reemplaza ese trabajo.

## Respuestas orientativas de la simulación incluida

Estas respuestas están visibles en el repositorio: son para retroalimentación,
no una clave reservada de examen. Si se cambia el simulador, volver a calcular.

### Agudelo

- Z3 muestra el mayor cambio calculable: 235 a 305, **+70 puntos**, ambos regular.
- Z1 aumenta 40; Z2 30; Z4 35 y pasa de regular a bueno.
- Z5 inicial tiene 19/20 indicadores. A20 carece de respuesta; el total y el
  cambio quedan NA. Solicitar evidencia de evaluación de actividades educativas.
- Identificar la dimensión mínima de Z1 leyendo el archivo de perfiles. Aceptar
  la respuesta calculada y reconocer empates si los hubiera.
- Las preguntas deben corresponder a dirección/MVZ, exhibición, encuestador y
  trabajadores, con evidencia verificable. Una entrevista por sí sola no confirma
  que la práctica operativa se cumpla.
- Mejor puntuación temporal no prueba causalidad ni valida el índice abreviado.

### Dulzaines

- Totales: Z1 57; Z2 72; Z3 83; Z4 92; Z5 47.
- Z2 desprotegido; Z3 medianamente protegido; Z4 protegido.
- Z1 y Z5 quedan fuera del intervalo publicado. No llamarlos protegidos ni
  inventar una categoría atribuida a los autores.
- En Z1, D4 tiene mayor brecha absoluta (11 puntos); D1 mayor brecha relativa
  (5/9 = 55.56%). D2 y D3 tienen cada uno 50% de brecha. El máximo ponderado
  hace que distintas formas de ordenar produzcan prioridades diferentes.
- La selección final debe justificarse con ruta de exposición, consecuencia,
  evidencia de la brecha y viabilidad. El puntaje no es probabilidad de infección.

### Jensen

- 1,600 observaciones de superficies → 40 totales de ensayo → diez cuidadores
  con cuatro mediciones cada uno. La intervención se compara dentro del cuidador.
- Medias UV de la simulación: control 24.2; guantes 18.2; utensilios 25.5;
  combinados 2.8. La combinación difiere del control en −21.4 puntos,
  con 88.43% de reducción de medias.
- Friedman: chi cuadrada ≈23.121, 3 gl, p≈0.0000381. Wilcoxon–Holm:
  guantes≈0.1482; utensilios≈0.4376; combinados≈0.01748.
- Son resultados artificiales. La combinación fue programada para mostrar
  menor transferencia; sus valores p no prueban eficacia en condiciones reales.
- No detectar diferencia no prueba equivalencia: requeriría diseño y margen
  específicos. El cambio de signo en utensilios merece describirse, no ocultarse.
- Fuente y controles previos no son receptores posteriores de la transferencia.
  Incluir la fuente distorsiona la comparación del resultado principal.
- El trazador no informa identidad ni viabilidad de patógenos, dosis infectante,
  susceptibilidad o infección. La simulación no reproduce toda la práctica real.
- El artículo reporta ANOVA de una vía y Tukey; aquí se usa otra estrategia
  para enseñar el bloqueo por cuidador. Mantener visible esa diferencia.

## Evaluación propuesta (100 puntos de esta práctica)

| Criterio | Máximo | Evidencia para obtener el máximo |
|---|---:|---|
| Cálculo e integridad | 25 | Totales correctos, NA conservado, máximos y bandas respetados |
| Interpretación y límites | 25 | Distingue escalas, reconoce adaptación y lagunas, evita causalidad sin diseño |
| Diseño y comparación | 25 | Agrega receptores, conserva pares, interpreta efecto y p ajustado sin pseudorreplicación |
| Plan verificable | 20 | Tres acciones vinculadas a hallazgos; cada una con ruta, medida, responsable, plazo, indicador y meta |
| Claridad y reproducibilidad | 5 | Informe breve y coherente; figuras identificadas; versión de R y comando reportados |

Asignar el máximo si se satisfacen todos los elementos del criterio; 75% si hay
una omisión menor que no altera la conclusión; 50% si la evidencia es parcial
o requiere correcciones sustantivas; 0% cuando falta o la conclusión contradice
el cálculo/diseño. Permitir valores intermedios con retroalimentación escrita.
No representa una modificación a las ponderaciones oficiales de la materia.

## Problemas frecuentes

- **No encuentra `R/funciones.R`:** abrir el `.Rproj`; no ejecutar desde la carpeta R.
- **Caracteres extraños:** abrir y guardar los archivos con codificación UTF-8.
- **No tiene Quarto/knitr:** ejecutar los scripts y leer la guía HTML incluida.
- **Hay errores después de editar CSV:** conservar encabezados, claves únicas y rangos.
- **Se quiere cambiar Z1 en la figura:** modificar `centro_elegido` en el módulo 2.
- **Se perdieron resultados:** volver a ejecutar el script principal; los datos
  de entrada permanecen. El simulador solo se ejecuta automáticamente si faltan CSV.
