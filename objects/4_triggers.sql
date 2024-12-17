USE es_deportes;


-- Descripción del Trigger trigger_bi_stock.
-- El trigger trigger_bi_stock valida que el valor del stock de un producto sea mayor a 0 antes de insertarlo en la tabla productos. Si se intenta insertar un producto con un stock menor o igual a 0, el trigger genera un error personalizado con el mensaje: "El stock debe ser mayor a 0". Esto asegura que solo se registren productos con disponibilidad real en el inventario, garantizando la consistencia y utilidad de los datos. */

DELIMITER //

DROP TRIGGER IF EXISTS es_deportes.trigger_bi_stock //

CREATE TRIGGER es_deportes.trigger_bi_stock
BEFORE INSERT 
ON es_deportes.productos 
FOR EACH ROW
BEGIN
    -- Mensaje de error personalizado
    SET @msg = "El stock debe ser mayor a 0";

    -- Verificar si el stock es menor o igual a 0
    IF NEW.stock <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;
    END IF;
END //

DELIMITER ;


-- Inserción válida
INSERT INTO productos (nombre, descripcion, stock, id_categoria_productos, id_proveedores) 
VALUES ('Producto Prueba', 'Descripción válida', 10, 1, 1);

-- Inserción inválida: genera error
INSERT INTO productos (nombre, descripcion, stock, id_categoria_productos, id_proveedores) 
VALUES ('Producto Inválido', 'Stock negativo', -5, 1, 1);


-- ----------------------------------------------------------------------------------------------------

USE es_deportes;

CREATE TABLE cliente_auditoria (
    id_auditoria INT NOT NULL AUTO_INCREMENT,
    id_cliente INT,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    email VARCHAR(254),
    accion ENUM('INSERT', 'UPDATE', 'DELETE'),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_auditoria)
);

DELIMITER //

CREATE TRIGGER trg_cliente_insert
AFTER INSERT ON cliente
FOR EACH ROW
BEGIN
    INSERT INTO cliente_auditoria (id_cliente, nombre, apellido, email, accion)
    VALUES
     (
        NEW.id_cliente,
        NEW.nombre,
        NEW.apellido,
        NEW.email,
        'INSERT'
    );
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER trg_cliente_update
AFTER UPDATE ON cliente
FOR EACH ROW
BEGIN
    INSERT INTO cliente_auditoria (id_cliente, nombre, apellido, email, accion)
    VALUES 
    (
        OLD.id_cliente,
        OLD.nombre,
        OLD.apellido,
        OLD.email,
        'UPDATE'
    );
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER trg_cliente_delete
AFTER DELETE ON cliente
FOR EACH ROW
BEGIN
    INSERT INTO cliente_auditoria (id_cliente, nombre, apellido, email, accion)
    VALUES
     (
        OLD.id_cliente,
        OLD.nombre,
        OLD.apellido,
        OLD.email,
        'DELETE'
     );
END;
//

DELIMITER ;

INSERT INTO cliente (nombre, apellido, email) 
VALUES ('Luis', 'García', 'luis.garcia@example.com');

UPDATE cliente 
SET nombre = 'Luis Eduardo' 
WHERE email = 'luis.garcia@example.com';

DELETE FROM cliente 
WHERE email = 'luis.garcia@example.com';

