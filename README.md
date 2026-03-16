# Índice de Envejecimiento · Provincia de San Luis

### San Luis: el IE provincial se duplicó en 42 años — de 26 (1980) a 47 (2022)

Análisis del índice de envejecimiento por departamento · Censos 1980–2022  
**Fuente:** INDEC · Censo Nacional de Población, Hogares y Viviendas 2022 · Resultados definitivos  
**Etapa:** 1 de 3 — Microsoft Excel

\---

## ¿Qué es el índice de envejecimiento?

El índice de envejecimiento (IE) expresa cuántas personas de **65 años o más** existen por cada **100 personas de 0 a 14 años**. Un IE alto indica una población con mayor proporción de adultos mayores respecto a niños y jóvenes.

> IE = (Población de 65+ / Población de 0 a 14) × 100

\---

## Preguntas que responde este análisis

* ¿Cuál es el nivel de envejecimiento actual de cada departamento en 2022?
* ¿Qué departamentos envejecieron más rápido entre 2010 y 2022?
* ¿Cuáles superan el índice provincial (47) y por cuánto?
* ¿En qué período intercensal fue más acelerado el proceso de envejecimiento?

\---

## Hallazgos principales

* **Libertador General San Martín** es el departamento más envejecido (IE = 85 en 2022), más que duplicando el índice provincial.
* **Gobernador Dupuy** es el menos envejecido (IE = 38), el único de los nueve departamentos por debajo de 40.
* **6 de los 9 departamentos** superan el índice provincial de 47 en 2022.
* El período **2010–2022** fue el de mayor aceleración del envejecimiento en todos los departamentos sin excepción.
* **Coronel Pringles** registró la mayor variación relativa en ese período (+54%), superando incluso a Libertador General San Martín en términos de velocidad de cambio.

\---

## Datos utilizados

|Campo|Detalle|
|-|-|
|Fuente original|INDEC · Cuadro 8.19 del Censo Nacional 2022|
|Cobertura geográfica|9 departamentos de la Provincia de San Luis|
|Años censales|1980 · 1991 · 2001 · 2010 · 2022|
|Variable analizada|Índice de envejecimiento por departamento|
|Nota metodológica|Los datos de 1970 solo están disponibles para el total provincial (muestra censal). El departamento Juan Martín de Pueyrredón se llamaba La Capital hasta el Censo 2022.|

\---

## Estructura del archivo Excel

El archivo `IE\_SanLuis\_FINAL.xlsx` contiene las siguientes hojas:

|Hoja|Contenido|
|-|-|
|`Datos base`|Tabla original del INDEC normalizada. Formato ancho: un año censal por columna.|
|`Datos_largo`|Tabla transformada con Power Query. Columnas: Departamento · Año · IE. Usada como fuente de la tabla dinámica.|
|`Indicadores`|Variación absoluta, variación relativa (%) y ranking calculados con fórmulas Excel vinculadas a Datos base.|
|`TD Evolución`|Tabla dinámica con evolución del IE por año censal y departamento. Incluye slicers de Departamento y Año.|
|`Dashboard`|Los tres gráficos principales reunidos: ranking provincial, comparativa 2010 vs 2022 y evolución temporal.|

\---

## Indicadores calculados

### Variación absoluta

Diferencia en puntos del IE entre dos censos.

```
Var. absoluta = IE(2022) − IE(2010)
```

Ejemplo — Libertador General San Martín: 85 − 58 = **+27 puntos**

### Variación relativa (%)

Cambio proporcional respecto al valor de partida. Permite comparar departamentos con IE iniciales distintos.

```
Var. relativa = ((IE(2022) − IE(2010)) / IE(2010)) × 100
```

Ejemplo — Coronel Pringles: ((57 − 37) / 37) × 100 = **+54,1%**

### Ranking

Posición ordinal de cada departamento por IE 2022, de mayor a menor.

```excel
=JERARQUIA(D5, $D$5:$D$13, 0)
```

\---

## Visualizaciones

|Gráfico|Tipo|Pregunta que responde|
|-|-|-|
|Ranking Provincial IE 2022|Barras horizontales ordenadas|¿Cuál es el departamento más envejecido?|
|IE 2010 vs IE 2022|Barras agrupadas + línea de referencia|¿Cuánto creció el IE en el último período?|
|Evolución temporal 1980–2022|Líneas por departamento|¿Cómo evolucionó cada departamento a lo largo del tiempo?|

Los gráficos de ranking y comparativa son estáticos.  
El gráfico de evolución temporal es interactivo mediante slicers de Departamento y Año.

\---

## Decisiones metodológicas

**¿Por qué se excluyó el Total provincial del ranking?**  
El código 74 representa la provincia en su conjunto, no un departamento. Incluirlo en el ranking distorsionaría la comparación entre unidades equivalentes.

**¿Por qué se compara 2010 vs 2022 y no 1980 vs 2022?**  
El período 2010–2022 es el más reciente y el de mayor aceleración. Es el intervalo más relevante para comprender la dinámica actual del envejecimiento en la provincia.

**¿Por qué los slicers solo controlan el gráfico de evolución temporal?**  
Las segmentaciones filtran tablas dinámicas. El gráfico de líneas está construido sobre la TD de evolución, mientras que el ranking y la comparativa se construyen directamente sobre la hoja Indicadores, que no es una tabla dinámica. Esta distinción es intencional: los datos de situación actual (ranking, comparativa) son definitivos; los datos históricos (evolución) se prestan a exploración interactiva.

\---

## Proceso de trabajo

Este proyecto siguió una metodología de documentación continua con 4 fases:

1. **Preparación y limpieza** — normalización de la tabla del INDEC, transformación a formato largo con Power Query.
2. **Análisis e indicadores** — cálculo de variación absoluta, relativa y ranking con fórmulas vinculadas.
3. **Visualización** — tres gráficos con paleta de azules consistente y línea de referencia provincial.
4. **Documentación** — Registro de sesiones, capturas de proceso y README.

\---

## Próximas etapas del portafolio

### Etapa 2 · SQL / MySQL Workbench

Reproducción del análisis en SQL: queries con `RANK()`, `LAG()` para variación intercensal y `CASE WHEN` para categorías de envejecimiento. Los scripts `.sql` se publicarán en este repositorio.

### Etapa 3 · Tableau

Dashboard interactivo con mapa coroplético por departamento, línea de evolución temporal y filtros por año censal. Se publicará en Tableau Public con link desde este README.

\---

## Herramientas utilizadas

- Microsoft Excel 2019
- Power Query

\---

*Proyecto de portafolio de análisis de datos · Etapa 1 de 3*

