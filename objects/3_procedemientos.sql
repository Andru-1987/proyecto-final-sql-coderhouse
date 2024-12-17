-- El procedimiento GenerarInformeComprasYEmpleados genera un informe detallado de las compras realizadas en la tienda, incluyendo información sobre el cliente, el empleado que atendió la compra y el local donde se realizó. Permite filtrar las compras según su estado (Pendiente, Completada, Cancelada) y limitar la cantidad de registros */

USE es_deportes;
DROP PROCEDURE IF EXISTS GenerarInformeComprasYEmpleados;
DELIMITER //
CREATE PROCEDURE GenerarInformeComprasYEmpleados(
    IN estado_compra VARCHAR(200),
    IN limite INT
)
BEGIN
    SELECT 
        c.id_compra,
        c.precio,
        c.cantidad,
        c.fecha_de_compra,
        c.estado_de_compra,
        cl.nombre AS cliente_nombre,
        cl.apellido AS cliente_apellido,
        e.nombre AS empleado_nombre,
        e.apellido AS empleado_apellido,
        l.direccion AS direccion_local
    FROM 
        compra AS c
    LEFT JOIN cliente AS cl 
        ON c.id_cliente = cl.id_cliente
    LEFT JOIN `local` AS l 
        ON c.id_local = l.id_local
    LEFT JOIN empleados AS e
        ON l.id_empleados = e.id_empleados
    WHERE 
        c.estado_de_compra = estado_compra
    ORDER BY c.fecha_de_compra DESC
    LIMIT limite;
END //
DELIMITER ;

CALL GenerarInformeComprasYEmpleados('Pendiente', 5);


-- ---------------------------------------------------------------------------------------------------------

-- /* El procedimiento AgregarCliente sirve para insertar un nuevo cliente en la tabla cliente, recibiendo como parámetros el nombre, apellido y correo electrónico del cliente
--  */


USE es_deportes;
DROP PROCEDURE IF EXISTS AgregarCliente;
DELIMITER //

CREATE PROCEDURE AgregarCliente(
    IN p_nombre VARCHAR(100),
    IN p_apellido VARCHAR(100),
    IN p_email VARCHAR(254)
)
BEGIN
    -- Insertar el nuevo cliente en la tabla cliente
    INSERT INTO cliente (nombre, apellido, email)
    VALUES (p_nombre, p_apellido, p_email);
    
    -- Opcional: Seleccionar el cliente recién agregado para mostrarlo
    SELECT 
        id_cliente, 
        nombre, 
        apellido, 
        email 
    FROM cliente
    WHERE email = p_email;  
END //

DELIMITER ;
CALL AgregarCliente('Edgar', 'Steinberg', 'steinb@gmail.com');

