-- Script: 02_crear_tabla.sql

CREATE TABLE indice_envejecimiento(
	codigo INT,
    departamento VARCHAR(60),
    anio INT, 
    ie INT,
    PRIMARY KEY (codigo, anio)
);

    