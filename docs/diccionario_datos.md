# Diccionario de datos

Todos los CSV están codificados en UTF-8, separados por comas y contienen
encabezados. Una celda vacía representa un valor desconocido (`NA`), no cero.
`procedencia = SIMULADO` identifica observaciones ficticias.

| Archivo | Una fila representa | Variables y valores |
|---|---|---|
| `catalogo_agudelo.csv` | Un indicador docente (20 filas) | `item` A01–A20; `concepto` cinco dimensiones; `indicador`; `instrumento` cuatro fuentes; `maximo` 20; `origen` adaptación |
| `agudelo_respuestas.csv` | Un indicador en un centro y visita (200 filas) | `item`; `centro` Z1–Z5; `visita` Inicial/Seguimiento; `respuesta` entero 0–4 o NA; `procedencia` |
| `catalogo_dulzaines.csv` | Un acápite (6 filas) | `seccion` D1–D6; `nombre`; `maximo` 9,20,16,29,18,8 |
| `dulzaines_subtotales.csv` | Un acápite de un centro (30 filas) | `centro` Z1–Z5; `seccion`; `obtenido` entero 0–máximo; `procedencia` |
| `jensen_orden_ensayos.csv` | Un ensayo cuidador × escenario (40 filas) | `cuidador` C01–C10; `escenario` Control/Guantes/Utensilios/Combinados; `orden_ensayo` 1–4, permutado para cada cuidador |
| `jensen_uv.csv` | Una superficie de un terrario de un ensayo (1,600 filas) | `cuidador`; `escenario`; `orden_ensayo`; `terrario` 1–10; `superficie` Pared/Refugio/Sustrato/Bebedero; `puntaje_uv` 0–3; `procedencia` |

## Regla docente de respuesta Agudelo

| Respuesta | Interpretación para esta práctica | Puntos |
|---:|---|---:|
| 0 | Ausencia documentada del componente | 0 |
| 1 | Desarrollo incipiente | 5 |
| 2 | Cumplimiento parcial | 10 |
| 3 | Cumplimiento avanzado con brechas | 15 |
| 4 | Cumplimiento completo de la definición docente | 20 |
| NA | Información insuficiente | NA |

Estos niveles fueron creados para enseñar el cálculo; no son los niveles de un
cuestionario validado. En una auditoría real harían falta definiciones operativas
y evidencia por indicador. Hay un NA intencional: Z5, Inicial, A20. El total de
esa visita debe permanecer incompleto y su cambio temporal no se calcula.

## Datos derivados

- `01_agudelo_totales.csv`: 10 visitas; 20 ítems esperados y total 0–400 o NA.
- `01_agudelo_perfiles.csv`: porcentaje por dimensión; máximo docente 80 cada una.
- `01_agudelo_cambios.csv`: diferencia seguimiento menos inicial, no efecto causal.
- `02_dulzaines_totales.csv`: total 0–100 y categoría publicada cuando está definida.
- `02_dulzaines_brechas.csv`: puntos y porcentaje faltantes por acápite.
- `03_jensen_totales.csv`: 40 totales UV 0–84 por cuidador y escenario.
- `03_jensen_resumen.csv`: media, mediana, dispersión y diez cuidadores por escenario.
- `03_jensen_comparaciones.csv`: tres contrastes pareados contra control; diferencias
  intervención menos control, reducción relativa de medias y valores p ajustados.

La reducción de medias se calcula como `100*(1-media_intervencion/media_control)`.
No es la media de los porcentajes individuales. Si el control tiene media cero,
la reducción no está definida y se registra NA. Una reducción negativa indica
mayor puntaje UV bajo la intervención; no se recorta artificialmente a cero.
