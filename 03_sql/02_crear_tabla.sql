-- Script: 04_queries_analisis.sql

SELECT departamento, anio, ie
FROM indice_envejecimiento
WHERE departamento != 'Total provincial'
ORDER BY departamento, anio;