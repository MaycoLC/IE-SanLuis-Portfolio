-- ============================================================
-- Script: 04_insertar_datos.sql
-- Proyecto: Índice de Envejecimiento · Provincia de San Luis
-- Fuente: INDEC · Censo Nacional 2022
-- ============================================================

USE ie_sanluis;

-- Limpiar datos existentes
TRUNCATE TABLE indice_envejecimiento;

-- Insertar 50 registros (10 departamentos × 5 censos)
INSERT INTO indice_envejecimiento (codigo, departamento, anio, ie)
VALUES
  (74, 'Total provincial', 1980, 26),
  (74, 'Total provincial', 1991, 22),
  (74, 'Total provincial', 2001, 25),
  (74, 'Total provincial', 2010, 31),
  (74, 'Total provincial', 2022, 47),
  (74007, 'Ayacucho', 1980, 28),
  (74007, 'Ayacucho', 1991, 28),
  (74007, 'Ayacucho', 2001, 34),
  (74007, 'Ayacucho', 2010, 36),
  (74007, 'Ayacucho', 2022, 54),
  (74014, 'Belgrano', 1980, 26),
  (74014, 'Belgrano', 1991, 37),
  (74014, 'Belgrano', 2001, 49),
  (74014, 'Belgrano', 2010, 55),
  (74014, 'Belgrano', 2022, 66),
  (74028, 'Chacabuco', 1980, 25),
  (74028, 'Chacabuco', 1991, 26),
  (74028, 'Chacabuco', 2001, 28),
  (74028, 'Chacabuco', 2010, 40),
  (74028, 'Chacabuco', 2022, 61),
  (74021, 'Coronel Pringles', 1980, 25),
  (74021, 'Coronel Pringles', 1991, 25),
  (74021, 'Coronel Pringles', 2001, 31),
  (74021, 'Coronel Pringles', 2010, 37),
  (74021, 'Coronel Pringles', 2022, 57),
  (74035, 'General Pedernera', 1980, 25),
  (74035, 'General Pedernera', 1991, 22),
  (74035, 'General Pedernera', 2001, 25),
  (74035, 'General Pedernera', 2010, 30),
  (74035, 'General Pedernera', 2022, 43),
  (74042, 'Gobernador Dupuy', 1980, 19),
  (74042, 'Gobernador Dupuy', 1991, 22),
  (74042, 'Gobernador Dupuy', 2001, 22),
  (74042, 'Gobernador Dupuy', 2010, 28),
  (74042, 'Gobernador Dupuy', 2022, 38),
  (74056, 'Juan Martín de Pueyrredón', 1980, 25),
  (74056, 'Juan Martín de Pueyrredón', 1991, 18),
  (74056, 'Juan Martín de Pueyrredón', 2001, 20),
  (74056, 'Juan Martín de Pueyrredón', 2010, 27),
  (74056, 'Juan Martín de Pueyrredón', 2022, 44),
  (74049, 'Junín', 1980, 30),
  (74049, 'Junín', 1991, 31),
  (74049, 'Junín', 2001, 37),
  (74049, 'Junín', 2010, 49),
  (74049, 'Junín', 2022, 62),
  (74063, 'Libertador General San Martín', 1980, 32),
  (74063, 'Libertador General San Martín', 1991, 44),
  (74063, 'Libertador General San Martín', 2001, 47),
  (74063, 'Libertador General San Martín', 2010, 58),
  (74063, 'Libertador General San Martín', 2022, 85);

-- ============================================================
-- Verificación: debe devolver 50
SELECT COUNT(*) AS total_registros FROM indice_envejecimiento;

-- Vista previa ordenada
SELECT codigo, departamento, anio, ie
FROM indice_envejecimiento
ORDER BY codigo, anio;
