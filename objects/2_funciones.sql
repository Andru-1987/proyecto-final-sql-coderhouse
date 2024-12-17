-- /* Descripción de la Función fx_total_ventas_por_metodo.

-- Esta función permite calcular el total de ventas asociadas a un método de pago específico. Al recibir como parámetro el nombre del método de pago (_metodo_pago), realiza una consulta sobre las tablas relacionadas para determinar cuántas compras se han realizado utilizando ese método.

-- La función es útil para analizar tendencias de pago y evaluar la preferencia de los clientes por ciertos métodos, como "Efectivo", "Tarjeta", o "Aplicacion". */

USE es_deportes; 

DROP FUNCTION IF EXISTS es_deportes.fx_total_ventas_por_metodo;

DELIMITER //
CREATE FUNCTION es_deportes.fx_total_ventas_por_metodo(_metodo_pago VARCHAR(200))
    RETURNS INT
    READS SQL DATA
BEGIN
    DECLARE valor_retorno INT DEFAULT 0;

  
    SELECT 
        COUNT(*) INTO valor_retorno
    FROM compra AS c
    LEFT JOIN compra_metodo_de_pago AS cmp
        ON c.id_compra = cmp.id_compra
    LEFT JOIN metodo_de_pago AS mp
        ON cmp.id_metodo_de_pago = mp.id_metodo_de_pago
    WHERE mp.tipo LIKE _metodo_pago;

    RETURN valor_retorno;
END //
DELIMITER ;

SELECT es_deportes.fx_total_ventas_por_metodo('Efectivo');

-- --------------------------------------------------------------------------------------------------

/* Descripción de la Función fx_total_stock_producto.

Esta función calcula el stock total de un producto específico basado en su nombre. Si el producto no existe o no tiene stock disponible, devuelve un mensaje informativo indicando esta situación. Es útil para consultas rápidas sobre la disponibilidad de inventario. */

USE es_deportes; 

DROP FUNCTION IF EXISTS es_deportes.fx_total_stock_producto;

DELIMITER //
CREATE FUNCTION es_deportes.fx_total_stock_producto(_nombre_producto VARCHAR(200))
    RETURNS VARCHAR(255)
    READS SQL DATA
BEGIN
    DECLARE total_stock INT DEFAULT 0;

   
    SELECT 
        SUM(p.stock) INTO total_stock
    FROM productos AS p
    WHERE p.nombre LIKE _nombre_producto;

  
    IF total_stock IS NULL THEN
        RETURN 'El producto no existe o no tiene stock';
    END IF;

    RETURN CONCAT('Stock disponible: ', total_stock);
END //
DELIMITER ;



SELECT es_deportes.fx_total_stock_producto('Producto 5') AS stock_total;
