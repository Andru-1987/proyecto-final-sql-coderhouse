
USE coderhouse_generico;

-- Función para verificar si una mesa está cancelada:
DROP FUNCTION IF EXISTS mesa_cancelada;
DROP FUNCTION IF EXISTS contar_reservas_cliente;
DROP FUNCTION IF EXISTS cantidad_mesas_por_restaurante;

DELIMITER //

CREATE FUNCTION mesa_cancelada(mesa_id INT) RETURNS BOOLEAN
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE cancelacion_date DATETIME;
    DECLARE is_cancelada BOOLEAN;
    
    SELECT CANCELACION INTO cancelacion_date
        FROM RESERVA
        WHERE IDMESA = mesa_id
        AND CANCELACION IS NOT NULL
        LIMIT 1;
    
    IF cancelacion_date IS NOT NULL THEN
        SET is_cancelada = TRUE;
    ELSE
        SET is_cancelada = FALSE;
    END IF;

    RETURN is_cancelada;
END //

DELIMITER ;

-- Función para contar las reservas de un cliente en un intervalo de tiempo:

DELIMITER //

CREATE FUNCTION contar_reservas_cliente(cliente_id INT, fecha_inicio DATETIME, fecha_fin DATETIME) RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE reservas_count INT;
    
    SELECT COUNT(*) INTO reservas_count
    FROM RESERVA
    WHERE IDCLIENTE = cliente_id
    AND FECHA >= fecha_inicio
    AND FECHA <= fecha_fin;
    
    RETURN reservas_count;
END //

DELIMITER ;

-- Función para obtener la cantidad de mesas por restaurante:
DELIMITER //

CREATE FUNCTION cantidad_mesas_por_restaurante(restaurante_id INT) RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE mesas_count INT;
    
    SELECT COUNT(*) INTO mesas_count
    FROM MESA
    WHERE IDRESTAURANTE = restaurante_id;
    
    RETURN mesas_count;
END //

DELIMITER ;



