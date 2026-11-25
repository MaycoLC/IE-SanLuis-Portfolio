<div align="center">

# 👥 Índice de Envejecimiento · Provincia de San Luis

**El índice provincial casi se duplicó en 42 años: de 26 (1980) a 47 (2022)**

Análisis por departamento · Censos 1980–2022

[![Dashboard en Tableau](https://img.shields.io/badge/Ver_dashboard-Tableau_Public-E97627?style=for-the-badge&logo=tableau&logoColor=white)](https://public.tableau.com/app/profile/mayco.luciano.correa/viz/IE-SanLuis-Envejecimiento-Censos/Dashboard1)
[![Portafolio](https://img.shields.io/badge/Portafolio-maycolc.github.io-0F766E?style=for-the-badge&logo=githubpages&logoColor=white)](https://maycolc.github.io)

![Excel](https://img.shields.io/badge/Microsoft_Excel-217346?style=flat&logo=microsoftexcel&logoColor=white)
![Power Query](https://img.shields.io/badge/Power_Query-2E6DA4?style=flat&logo=microsoft&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white)
![MySQL Workbench](https://img.shields.io/badge/MySQL_Workbench-00758F?style=flat&logo=mysql&logoColor=white)
![Tableau](https://img.shields.io/badge/Tableau-E97627?style=flat&logo=tableau&logoColor=white)
![Estado](https://img.shields.io/badge/estado-completo-success?style=flat)

<!--
  VISTA PREVIA: guardá una captura del dashboard de Tableau como
  02_capturas/dashboard_tableau.png y borrá estas líneas de comentario
  para que se muestre la imagen de abajo.
<a href="https://public.tableau.com/app/profile/mayco.luciano.correa/viz/IE-SanLuis-Envejecimiento-Censos/Dashboard1">
  <img src="02_capturas/dashboard_tableau.png" alt="Vista previa del dashboard de envejecimiento en Tableau" width="850">
</a>
-->

</div>

---

## 📌 Índice

- [Objetivo](#-objetivo)
- [Hallazgos principales](#-hallazgos-principales)
- [Datos utilizados](#-datos-utilizados)
- [Etapa 1 · Excel](#etapa-1--microsoft-excel)
- [Etapa 2 · SQL](#etapa-2--sql--mysql-workbench)
- [Etapa 3 · Tableau](#etapa-3--tableau)
- [Cómo ejecutarlo](#️-cómo-ejecutarlo)
- [Estructura del repositorio](#-estructura-del-repositorio)

---

## 🎯 Objetivo

Medir cómo envejeció la población de cada uno de los **9 departamentos de San Luis** entre los censos de 1980 y 2022, e identificar dónde y cuándo el proceso fue más rápido.

> **¿Qué es el índice de envejecimiento (IE)?**
> Cuántas personas de **65 años o más** hay por cada **100 personas de 0 a 14 años**.
>
> `IE = (Población de 65+ / Población de 0 a 14) × 100`
>
> Un IE alto indica más adultos mayores en relación con niños y jóvenes.

**Preguntas que responde:**

- ¿Cuál es el nivel de envejecimiento de cada departamento en 2022?
- ¿Qué departamentos envejecieron más rápido entre 2010 y 2022?
- ¿Cuáles superan el índice provincial (47) y por cuánto?
- ¿En qué período intercensal se aceleró más el envejecimiento?

---

## 🔍 Hallazgos principales

| | Hallazgo |
|---|---|
| 🥇 | **Libertador General San Martín** es el departamento más envejecido (**IE = 85** en 2022), casi el doble del índice provincial. |
| 🧒 | **Gobernador Dupuy** es el menos envejecido (**IE = 38**), el único por debajo de 40. |
| 📊 | **6 de los 9 departamentos** superan el índice provincial de 47. |
| ⏩ | **2010–2022** fue el período de mayor aceleración en **todos** los departamentos, sin excepción. |
| 🚀 | **Coronel Pringles** tuvo la mayor variación relativa en ese período (**+54,1 %**, de 37 a 57), por encima de Libertador General San Martín en velocidad de cambio. |

---

## 🗂 Datos utilizados

| Campo | Detalle |
|---|---|
| Fuente | **INDEC** · Censo Nacional de Población, Hogares y Viviendas 2022 · Resultados definitivos · Cuadro 8.19 |
| Cobertura | 9 departamentos de la provincia de San Luis |
| Años censales | 1980 · 1991 · 2001 · 2010 · 2022 |
| Variable | Índice de envejecimiento por departamento |
| Notas | Los datos de 1970 solo existen para el total provincial. El departamento Juan Martín de Pueyrredón se llamaba La Capital hasta el Censo 2022. |

---

## Etapa 1 · Microsoft Excel

El archivo `IE_SanLuis_FINAL.xlsx` contiene:

| Hoja | Contenido |
|---|---|
| `Datos base` | Tabla original del INDEC normalizada (formato ancho: un año censal por columna). |
| `Datos_largo` | Tabla transformada con **Power Query** (Departamento · Año · IE). Fuente de la tabla dinámica y de Tableau. |
| `Indicadores` | Variación absoluta, relativa (%) y ranking con fórmulas vinculadas a `Datos base`. |
| `TD Evolución` | Tabla dinámica con la evolución del IE, con segmentaciones de Departamento y Año. |
| `Dashboard` | Ranking provincial, comparativa 2010 vs. 2022 y evolución temporal. |

**Indicadores calculados**

```text
Variación absoluta = IE(2022) − IE(2010)                      → Lib. Gral. San Martín: 85 − 58 = +27 puntos
Variación relativa = (IE(2022) − IE(2010)) / IE(2010) × 100   → Coronel Pringles: (57 − 37) / 37 = +54,1 %
Ranking            = JERARQUIA(D5; $D$5:$D$13; 0)
```

<details>
<summary><b>Decisiones metodológicas en Excel</b></summary>
<br>

- **Se excluyó el total provincial del ranking.** El código 74 representa a toda la provincia; incluirlo distorsionaría la comparación entre departamentos.
- **Se compara 2010 vs. 2022 (y no 1980 vs. 2022)** porque es el período más reciente y el de mayor aceleración, el más útil para entender la situación actual.
- **Las segmentaciones solo controlan el gráfico de evolución.** Filtran tablas dinámicas, y el ranking y la comparativa se construyen sobre la hoja `Indicadores`. Es intencional: la foto actual es fija, la historia se explora.

</details>

---

## Etapa 2 · SQL / MySQL Workbench

```sql
CREATE TABLE indice_envejecimiento (
  codigo       INT,
  departamento VARCHAR(60),
  anio         INT,
  ie           INT,
  PRIMARY KEY (codigo, anio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

La clave primaria compuesta `(codigo, anio)` impide que haya más de un registro por departamento y año censal.

| Query | Técnica SQL | Pregunta que responde |
|---|---|---|
| Q1 · Vista general | `SELECT`, `ORDER BY` | ¿Cómo se distribuyen los datos? |
| Q2 · Ranking 2022 | `RANK() OVER` | ¿Qué departamento tiene el IE más alto? |
| Q3 · Variación intercensal | `LAG() OVER (PARTITION BY …)` | ¿Cuánto cambió el IE respecto del censo anterior? |
| Q4 · Mayor aceleración | Subconsulta + `MAX()` | ¿En qué período creció más cada departamento? |
| Q5 · Categorías | `CASE WHEN` | ¿Cómo clasificar los departamentos por nivel de envejecimiento? |
| Q6 · 2010 vs. 2022 | Self `JOIN` | ¿Cuánto varió en el último período intercensal? |
| Q7 · Vista para Tableau | Funciones de ventana combinadas | Tabla consolidada lista para visualizar |

<details>
<summary><b>Decisiones metodológicas en SQL</b></summary>
<br>

- **`INSERT INTO` en lugar del asistente de importación.** El *Table Data Import Wizard* rompía los caracteres especiales del español. Un script con UTF-8 explícito es reproducible en cualquier instalación de MySQL.
- **`PARTITION BY departamento` en `LAG()`.** Sin la partición, la función tomaría el último valor del departamento anterior en vez del censo previo del mismo departamento.
- **Self `JOIN` en Q6.** Comparar dos años de la misma tabla requiere unirla consigo misma, una instancia por año: el equivalente SQL de tener IE 2010 e IE 2022 en la misma fila.

</details>

---

## Etapa 3 · Tableau

Dashboard interactivo conectado a la hoja `Datos_largo`. Incluye el ranking por departamento, la evolución temporal y filtros por año censal.

👉 **[Abrir el dashboard en Tableau Public](https://public.tableau.com/app/profile/mayco.luciano.correa/viz/IE-SanLuis-Envejecimiento-Censos/Dashboard1)**

---

## ▶️ Cómo ejecutarlo

**Excel:** abrí `IE_SanLuis_FINAL.xlsx` (Excel 2016 o posterior, para Power Query).

**SQL:** con MySQL 8.0+ (necesario para las funciones de ventana), ejecutá los scripts en orden:

```bash
git clone https://github.com/MaycoLC/IE-SanLuis-Portfolio.git
cd IE-SanLuis-Portfolio

mysql -u root -p < 03_sql/01_crear_base_datos.sql
mysql -u root -p ie_sanluis < 03_sql/02_crear_tabla.sql
mysql -u root -p ie_sanluis < 03_sql/03_insertar_datos.sql
mysql -u root -p ie_sanluis < 03_sql/04_queries_analisis.sql
```

También podés abrirlos y ejecutarlos uno por uno desde **MySQL Workbench**.

---

## 📁 Estructura del repositorio

```
IE-SanLuis-Portfolio/
├── 01_datos/
│   ├── original/       ← c2022_sanluis_est_c8_19.xlsx (INDEC sin modificar)
│   └── procesados/     ← ie_sanluis_largo.csv
├── 02_capturas/
│   ├── fase1_excel/    ← CP01 a CP12
│   └── fase2_sql/      ← SQL_CP01 a SQL_CP08
├── 03_sql/             ← 01_crear_base_datos · 02_crear_tabla · 03_insertar_datos · 04_queries_analisis
└── README.md
```

---

<div align="center">

**Mayco Luciano Correa** · Estudiante de Ciencias de la Computación (UNSL)

[Portafolio](https://maycolc.github.io) · [LinkedIn](https://www.linkedin.com/in/maycolc/) · [Tableau Public](https://public.tableau.com/app/profile/mayco.luciano.correa/vizzes) · [GitHub](https://github.com/MaycoLC)

</div>
