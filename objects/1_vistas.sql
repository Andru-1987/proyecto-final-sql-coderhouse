-- Descripción de la Vista vw_ventas_empleado_local.
-- La vista vw_ventas_empleado_local fue creada para facilitar la consulta de las ventas totales realizadas por cada empleado, mostrando su nombre y apellido, junto con el total de ventas de los locales donde trabajan. Esta vista consolida la información necesaria para analizar el rendimiento de los empleados y los locales en una sola consulta. */

USE es_deportes; 

DROP VIEW IF EXISTS es_deportes.vw_ventas_empleado_local;

CREATE OR REPLACE VIEW es_deportes.vw_ventas_empleado_local AS
SELECT 
    e.nombre AS empleado_nombre,
    e.apellido AS empleado_apellido,
    SUM(c.precio * c.cantidad) AS total_ventas_empleado,
    SUM(c2.precio * c2.cantidad) AS total_ventas_local
FROM empleados AS e
LEFT JOIN local_empleados AS le
    ON e.id_empleados = le.id_empleados
LEFT JOIN compra AS c 
    ON le.id_local = c.id_local
LEFT JOIN compra AS c2 
    ON c2.id_local = le.id_local
GROUP BY e.id_empleados
ORDER BY total_ventas_empleado DESC;

SELECT * FROM es_deportes.vw_ventas_empleado_local;



-- -------------------------------------------------------------------------------------------------------


/* Descripción de la Vista vw_compras_completadas.

La vista vw_compras_completadas proporciona un análisis claro y detallado del desempeño de los locales. Responde a preguntas clave como:
¿Cuántas compras completadas ha realizado cada local?
¿Cuál es el total de ventas generado por estas compras?. */


USE es_deportes; 

DROP VIEW IF EXISTS es_deportes.vw_compras_completadas;
CREATE 
	OR REPLACE
    VIEW es_deportes.vw_compras_completadas AS
SELECT 
    l.direccion,
    COUNT(c.id_compra) AS cantidad_compras,
    SUM(c.precio * c.cantidad) AS total_ventas
FROM local l
LEFT JOIN compra c 
    ON l.id_local = c.id_local
WHERE c.estado_de_compra = 'Completada'
GROUP BY l.id_local
ORDER BY total_ventas DESC;

SELECT * FROM es_deportes.vw_compras_completadas;



