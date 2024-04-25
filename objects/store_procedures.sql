USE coderhouse_generico;

DROP PROCEDURE IF EXISTS actualizar_reserva_cancelada_por_email;
DROP PROCEDURE IF EXISTS actualizar_tipo_reserva_por_email;
DROP PROCEDURE IF EXISTS crear_empleado;

DELIMITER //

CREATE PROCEDURE actualizar_reserva_cancelada_por_email(
    IN p_email VARCHAR(100)
)
BEGIN
    DECLARE cliente_id INT;
    
    -- Obtener el ID del cliente usando el correo electrónico proporcionado
    SELECT IDCLIENTE INTO cliente_id
        FROM CLIENTE
    WHERE CORREO = p_email;
    
    -- Actualizar la reserva si el cliente existe y tenía una reserva cancelada
    IF cliente_id IS NOT NULL THEN
        UPDATE RESERVA
        SET CANCELACION = NULL,
            FECHA = NOW()
        WHERE IDCLIENTE = cliente_id
        AND CANCELACION IS NOT NULL;
        
        SELECT 'La reserva cancelada del cliente con correo electrónico ', p_email, ' ha sido actualizada exitosamente.';
    ELSE
        SELECT 'No se encontró ningún cliente con el correo electrónico ', p_email, '.';
    END IF;
    
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE actualizar_tipo_reserva_por_email(
    IN p_email VARCHAR(100),
    IN p_nuevo_tipo VARCHAR(50)
)
BEGIN
    DECLARE cliente_id INT;
    DECLARE reserva_id INT;
    
    -- Obtener el ID del cliente usando el correo electrónico proporcionado
    SELECT IDCLIENTE INTO cliente_id
    FROM CLIENTE
    WHERE CORREO = p_email;
    
    -- Si se encontró el cliente, obtener la última reserva hecha
    IF cliente_id IS NOT NULL THEN
        SELECT IDRESERVA INTO reserva_id
        FROM RESERVA
        WHERE IDCLIENTE = cliente_id
        ORDER BY FECHA DESC
        LIMIT 1;
        
        -- Si se encontró la reserva, actualizar el tipo de reserva
        IF reserva_id IS NOT NULL THEN
            UPDATE RESERVA
            SET IDTIPORESERVA = (
                SELECT IDTIPORESERVA FROM TIPORESERVA WHERE TIPO = p_nuevo_tipo
            ) , FECHA = NOW()
            WHERE IDRESERVA = reserva_id;
            
            SELECT 'Se actualizó el tipo de reserva del cliente con correo electrónico ', p_email, ' a ', p_nuevo_tipo, '.';
        ELSE
            SELECT 'El cliente con correo electrónico ', p_email, ' no tiene reservas.';
        END IF;
    ELSE
        SELECT 'No se encontró ningún cliente con el correo electrónico ', p_email, '.';
    END IF;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE crear_empleado(
    IN p_nombre VARCHAR(100),
    IN p_telefono VARCHAR(20),
    IN p_correo VARCHAR(100),
    IN p_id_restaurante INT
)
BEGIN
    DECLARE restaurante_count INT;
    
    -- Verificar si el restaurante existe
    SELECT COUNT(*) INTO restaurante_count
    FROM RESTAURANTE
    WHERE IDRESTAURANTE = p_id_restaurante;
    
    -- Si el restaurante existe, insertar el empleado
    IF restaurante_count > 0 THEN
        INSERT INTO EMPLEADO (NOMBRE, TELEFONO, CORREO, IDRESTAURANTE)
        VALUES (p_nombre, p_telefono, p_correo, p_id_restaurante);
        
        SELECT 'Empleado creado exitosamente.';
    ELSE
        SELECT 'El restaurante especificado no existe. No se puede crear el empleado.';
    END IF;
END //

DELIMITER ;
