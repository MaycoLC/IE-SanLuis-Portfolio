# Índice de Envejecimiento · Provincia de San Luis
### San Luis: el IE provincial se duplicó en 42 años — de 26 (1980) a 47 (2022)

Análisis del índice de envejecimiento por departamento · Censos 1980–2022  
**Fuente:** INDEC · Censo Nacional de Población, Hogares y Viviendas 2022 · Resultados definitivos  
**Etapas completadas:** Excel · SQL · Tableau

---

## ¿Qué es el índice de envejecimiento?

El índice de envejecimiento (IE) expresa cuántas personas de **65 años o más** existen por cada **100 personas de 0 a 14 años**. Un IE alto indica una población con mayor proporción de adultos mayores respecto a niños y jóvenes.

> IE = (Población de 65+ / Población de 0 a 14) × 100

---

## Preguntas que responde este análisis

- ¿Cuál es el nivel de envejecimiento actual de cada departamento en 2022?
- ¿Qué departamentos envejecieron más rápido entre 2010 y 2022?
- ¿Cuáles superan el índice provincial (47) y por cuánto?
- ¿En qué período intercensal fue más acelerado el proceso de envejecimiento?

---

## Hallazgos principales

- **Libertador General San Martín** es el departamento más envejecido (IE = 85 en 2022), más que duplicando el índice provincial.
- **Gobernador Dupuy** es el menos envejecido (IE = 38), el único de los nueve departamentos por debajo de 40.
- **6 de los 9 departamentos** superan el índice provincial de 47 en 2022.
- El período **2010–2022** fue el de mayor aceleración del envejecimiento en todos los departamentos sin excepción.
- **Coronel Pringles** registró la mayor variación relativa en ese período (+54,1%), superando a Libertador General San Martín en velocidad de cambio.

---

## Datos utilizados

| Campo | Detalle |
|---|---|
| Fuente original | INDEC · Cuadro 8.19 del Censo Nacional 2022 |
| Cobertura geográfica | 9 departamentos de la Provincia de San Luis |
| Años censales | 1980 · 1991 · 2001 · 2010 · 2022 |
| Variable analizada | Índice de envejecimiento por departamento |
| Nota metodológica | Los datos de 1970 solo están disponibles para el total provincial. El departamento Juan Martín de Pueyrredón se llamaba La Capital hasta el Censo 2022. |

---

## Etapa 1 · Microsoft Excel

### Estructura del archivo

El archivo `IE_SanLuis_FINAL.xlsx` contiene las siguientes hojas:

| Hoja | Contenido |
|---|---|
| `Datos base` | Tabla original del INDEC normalizada. Formato ancho: un año censal por columna. |
| `Datos_largo` | Tabla transformada con Power Query. Columnas: Departamento · Año · IE. Fuente de la tabla dinámica. |
| `Indicadores` | Variación absoluta, relativa (%) y ranking calculados con fórmulas vinculadas a Datos base. |
| `TD Evolución` | Tabla dinámica con evolución del IE por año y departamento. Slicers de Departamento y Año. |
| `Dashboard` | Los tres gráficos reunidos: ranking provincial, comparativa 2010 vs 2022 y evolución temporal. |

### Indicadores calculados

**Variación absoluta** — diferencia en puntos entre dos censos.
```
Var. absoluta = IE(2022) − IE(2010)
```
Ejemplo — Libertador General San Martín: 85 − 58 = **+27 puntos**

**Variación relativa** — cambio proporcional respecto al valor de partida.
```
Var. relativa = ((IE(2022) − IE(2010)) / IE(2010)) × 100
```
Ejemplo — Coronel Pringles: ((57 − 37) / 37) × 100 = **+54,1%**

**Ranking** — posición ordinal por IE 2022, de mayor a menor.
```excel
=JERARQUIA(D5, $D$5:$D$13, 0)
```

### Visualizaciones

| Gráfico | Tipo | Pregunta que responde |
|---|---|---|
| Ranking Provincial IE 2022 | Barras horizontales | ¿Cuál es el departamento más envejecido? |
| IE 2010 vs IE 2022 | Barras agrupadas + referencia | ¿Cuánto creció el IE en el último período? |
| Evolución temporal 1980–2022 | Líneas por departamento | ¿Cómo evolucionó cada departamento en el tiempo? |

Los gráficos de ranking y comparativa son estáticos. El gráfico de evolución temporal es interactivo mediante slicers de Departamento y Año.

### Decisiones metodológicas — Excel

**¿Por qué se excluyó el Total provincial del ranking?**  
El código 74 representa la provincia en su conjunto, no un departamento. Incluirlo distorsionaría la comparación entre unidades equivalentes.

**¿Por qué se compara 2010 vs 2022 y no 1980 vs 2022?**  
El período 2010–2022 es el más reciente y el de mayor aceleración. Es el intervalo más relevante para comprender la dinámica actual.

**¿Por qué los slicers solo controlan el gráfico de evolución temporal?**  
Los slicers filtran tablas dinámicas. El ranking y la comparativa se construyen sobre la hoja Indicadores, que no es una tabla dinámica. Esta distinción es intencional: los datos de situación actual son definitivos; los históricos se prestan a exploración interactiva.

---

## Etapa 2 · SQL / MySQL Workbench

### Estructura de la base de datos

```sql
CREATE TABLE indice_envejecimiento (
  codigo       INT,
  departamento VARCHAR(60),
  anio         INT,
  ie           INT,
  PRIMARY KEY (codigo, anio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

La clave primaria compuesta `(codigo, anio)` garantiza que no pueda existir más de un registro por departamento y año censal.

### Scripts disponibles

| Archivo | Descripción |
|---|---|
| `01_crear_base_datos.sql` | Crea la base `ie_sanluis` con charset utf8mb4 |
| `02_crear_tabla.sql` | Define la tabla con tipos de datos y PRIMARY KEY |
| `03_insertar_datos.sql` | Inserta los 50 registros con INSERT INTO directo |
| `04_queries_analisis.sql` | Las 7 queries analíticas del proyecto |

### Queries implementadas

| Query | Técnica SQL | Pregunta que responde |
|---|---|---|
| Q1 — Vista general | `SELECT`, `ORDER BY` | ¿Cómo están distribuidos los datos? |
| Q2 — Ranking 2022 | `RANK() OVER` | ¿Qué departamento tiene el IE más alto? |
| Q3 — Variación intercensal | `LAG() OVER PARTITION BY` | ¿Cuánto cambió el IE respecto al censo anterior? |
| Q4 — Mayor aceleración | Subconsulta + `MAX()` | ¿En qué período creció más cada departamento? |
| Q5 — Categorías | `CASE WHEN` | ¿Cómo clasificar los departamentos por nivel de envejecimiento? |
| Q6 — Comparativa 2010 vs 2022 | Self `JOIN` | ¿Qué variación hubo en el último período intercensal? |
| Q7 — Vista para Tableau | Window functions combinadas | Tabla consolidada lista para visualización |

### Decisiones metodológicas — SQL

**¿Por qué INSERT INTO en lugar del Import Wizard?**  
La importación mediante el Table Data Import Wizard generó problemas de encoding con caracteres especiales del español. Se optó por un script `INSERT INTO` con charset UTF-8 explícito, lo que garantiza reproducibilidad independiente del entorno: cualquier instalación de MySQL puede ejecutar el script y obtener los mismos datos sin configuración adicional.

**¿Por qué `PARTITION BY departamento` en `LAG()`?**  
Sin `PARTITION BY`, la función tomaría el valor del último registro del departamento anterior en lugar del censo previo del mismo departamento. La partición reinicia el cálculo para cada departamento, reproduciendo la lógica de la fórmula `=D5-C5` de la hoja Indicadores.

**¿Por qué un self JOIN en Q6?**  
Comparar dos años distintos de la misma tabla requiere unirla consigo misma, una instancia por año. Es el equivalente SQL de tener las columnas IE 2010 e IE 2022 en la misma fila de la hoja Indicadores.

---

## Estructura del repositorio

```
IE-SanLuis-Portfolio/
├── 01_datos/
│   ├── original/
│   │   └── c2022_sanluis_est_c8_19.xlsx    ← archivo INDEC sin modificar
│   └── procesados/
│       └── ie_sanluis_largo.csv      ← paso intermedio de transformación
├── 02_capturas/
│   ├── fase1_excel/                        ← CP01 a CP12
│   └── fase2_sql/                          ← SQL_CP01 a SQL_CP08
├── 03_sql/
│   ├── 01_crear_base_datos.sql
│   ├── 02_crear_tabla.sql
│   ├── 03_indertar_datos.sql
│   └── 04_queries_analisis.sql
└── README.md
```

---

### Etapa 3 · Tableau
Dashboard interactivo conectado a la hoja de cálculo 'Datos_largo' de la primer etapa. Incluye ranking de envejecimiento por departamento, línea de evolución temporal y filtros por año censal. Se encuentra publicado en Taleau Public en el siguiente link:

https://public.tableau.com/views/IE-SanLuis-Envejecimiento-Censos/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link

---

## Herramientas utilizadas

![Excel](https://img.shields.io/badge/Microsoft_Excel-217346?style=flat&logo=microsoft-excel&logoColor=white)
![Power Query](https://img.shields.io/badge/Power_Query-2E6DA4?style=flat&logo=microsoft&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white)
![Workbench](https://img.shields.io/badge/MySQL_Workbench-FF6600?style=flat&logo=mysql&logoColor=white)

---

*Proyecto de portafolio de análisis de datos · Etapas 1 y 2 de 3 completadas*
