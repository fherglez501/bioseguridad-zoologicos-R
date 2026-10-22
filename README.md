# Bioseguridad y salud pública en zoológicos con R

**Práctica guiada · Clínica, Salud Pública y Bioseguridad · Pregrado**

Diagnosticar, priorizar y evaluar una intervención con datos simulados. La secuencia
mantiene el orden trabajado en clase: **Agudelo-Suárez y Villamil-Jiménez (2009) →
Dulzaines Castañeda et al. (2010) → Jensen et al. (2021)**. El ensayo de
Agudelo-Suarez (2017) sirve como lectura de contexto.

Todos los centros, cuidadores y resultados del proyecto son **ficticios**. La
práctica adapta metodologías para enseñar R; no constituye una validación de los
instrumentos ni una certificación sanitaria.

## Empezar en RStudio

1. Instalar R y RStudio si todavía no están disponibles. R debe ser >= 4.1.
2. En RStudio: **File → New Project → Version Control → Git**. Pegar la URL de
   clonación del repositorio y crear el proyecto. Se requiere Git instalado.
3. Abrir `bioseguridad-zoologicos.Rproj` si RStudio no lo abrió automáticamente.
4. En la consola ejecutar:

```r
source("ejecutar_todo.R")
```

El análisis usa **solo R base**, no instala paquetes ni necesita internet. Guarda
CSV, cuatro figuras PNG y un resumen estadístico en `resultados/`.

Para trabajar paso a paso, leer [practica.qmd](practica.qmd) y ejecutar los scripts
`R/01_agudelo.R`, `R/02_dulzaines.R` y `R/03_jensen.R` en ese orden. En un script,
**Ctrl+Enter** ejecuta la línea o selección. **Source** ejecuta todo el archivo.
Los scripts también funcionan por separado desde la raíz del proyecto.

## Guía y entrega

- `practica.qmd`: explicaciones, código y preguntas de los tres módulos.
- `practica.html`: guía ya ejecutada con tablas y figuras, para abrir sin Quarto.
- `plantillas/entrega.qmd`: informe breve para completar; contiene la matriz de mejora.
- `docs/guia_docente.md`: tiempos, alineación, criterios y respuestas orientativas.
- `docs/metodologia_y_fuentes.md`: qué se conserva y qué se adapta de cada artículo.
- `docs/diccionario_datos.md`: unidad de observación, variables y valores admitidos.
- `R/00_generar_datos.R`: simulador reproducible con semilla fija.
- `tests/validar.R`: controles de integridad, umbrales y resultados.

Quarto es **opcional**. Para producir la guía HTML desde RStudio, instalar el
paquete `knitr` una vez, abrir `practica.qmd` y pulsar **Render**. Esto requiere
Quarto disponible en la instalación de RStudio. Alternativa en terminal:

```bash
quarto render practica.qmd
```

Si no se dispone de Quarto, los scripts y las preguntas se pueden trabajar
directamente en RStudio, y el informe se puede entregar en otro editor.

## Recorrido de 180 minutos

| Etapa | Pregunta | Producto | Tiempo sugerido |
|---|---|---|---|
| Agudelo | ¿Qué dimensiones de salud pública requieren atención? | Perfil y cambio temporal | 50 min |
| Dulzaines | ¿Dónde se concentran las brechas de bioseguridad? | Subtotales ponderados y prioridades | 50 min |
| Jensen | ¿Qué medida reduce la transferencia de trazador en la simulación? | Gráfica pareada y comparación | 60 min |
| Integración | ¿Qué medida aplicar y cómo verificarla? | Matriz de mejora y conclusión | 20 min |

También puede distribuirse en tres sesiones de una hora. Los tiempos son una
propuesta docente, no un calendario institucional confirmado.

## Cautelas de interpretación

- El puntaje de 400 de la primera etapa se obtiene con **20 indicadores y pesos
  docentes**. No reproduce los formularios completos ni su validación original.
- En Dulzaines se conservan los máximos de los seis acápites. Para valores <60
  se informa **Fuera del intervalo publicado**, porque la fuente no los clasifica.
- Los puntajes de ambas auditorías no se promedian entre sí ni equivalen a una
  probabilidad de infección. Convertirlos a porcentaje no vuelve equivalentes los instrumentos.
- En Jensen, cada cuidador participa en los cuatro escenarios. El análisis
  principal conserva ese emparejamiento. No se cuentan terrarios y superficies
  como réplicas independientes de la intervención.
- La fluorescencia mide transferencia del trazador: no confirma patógenos,
  viabilidad, infección ni eficacia clínica. La simulación incluye efectos
  programados; sus valores p no son evidencia sobre un zoológico real.

Para reiniciar los datos simulados: `source("R/00_generar_datos.R")`.
Este comando sobrescribe los CSV de simulación; guardar una copia si se han editado.
Para comprobar el proyecto: `source("tests/validar.R")`.

Verificación inicial: ejecución completa y controles aprobados con R 4.3.3;
los bloques de la guía también fueron ejecutados con knitr. Consulte
`docs/verificacion.md`.

## Fuentes

Las referencias completas y las páginas metodológicas se encuentran en
[metodología y fuentes](docs/metodologia_y_fuentes.md). Se proporcionan vínculos
a los artículos; los PDF adjuntos no se redistribuyen dentro del repositorio.
