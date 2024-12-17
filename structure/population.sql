USE es_deportes;

-- Insertar datos en tablas sin FK

-- Insertar datos en la tabla 'cliente'
INSERT INTO cliente (nombre, apellido, email) VALUES
('Juan', 'Pérez', 'juan.perez@example.com'),
('Ana', 'González', 'ana.gonzalez@example.com'),
('Carlos', 'Ramírez', 'carlos.ramirez@example.com'),
('Laura', 'López', 'laura.lopez@example.com'),
('Pedro', 'Martínez', 'pedro.martinez@example.com');

-- Insertar datos en la tabla 'metodo_de_pago'
INSERT INTO metodo_de_pago (tipo) VALUES
('Efectivo'),
('Tarjeta'),
('Aplicación');

-- Insertar datos en la tabla 'categoria_productos'
INSERT INTO categoria_productos (nombre, descripcion) VALUES
('Electrónica', 'Productos electrónicos'),
('Deportes', 'Artículos deportivos'),
('Hogar', 'Productos para el hogar'),
('Ropa', 'Ropa y accesorios'),
('Juguetes', 'Juguetes y entretenimiento');

-- Insertar datos en la tabla 'proveedores'
INSERT INTO proveedores (nombre, direccion) VALUES
('Proveedor 1', 'Calle Ficticia 1'),
('Proveedor 2', 'Calle Ficticia 2'),
('Proveedor 3', 'Calle Ficticia 3'),
('Proveedor 4', 'Calle Ficticia 4'),
('Proveedor 5', 'Calle Ficticia 5');

-- Insertar datos en la tabla 'empleados'
INSERT INTO empleados (nombre, apellido, fecha_de_nacimiento, dni) VALUES
('Sofía', 'Molina', '1990-02-20', '12345678'),
('Luis', 'Martín', '1985-05-12', '23456789'),
('Marta', 'Gómez', '1992-08-14', '34567890'),
('Raúl', 'Torres', '1980-11-01', '45678901'),
('Elena', 'Fernández', '1987-03-10', '56789012');

-- Insertar datos en la tabla 'categoria_empleado'
INSERT INTO categoria_empleado (rol) VALUES
('Vendedor'),
('Encargado');

-- Insertar datos en la tabla 'local'
INSERT INTO local (direccion, encargado, horarios, id_empleados) VALUES
('Av. Principal 1', 'Sofia Molina', '9', 1),
('Av. Secundaria 2', 'Luis Martin', '21', 2),
('Calle Tercera 3', 'Marta Gomez', '9', 3),
('Calle Cuarta 4', 'Raul Torres', '21', 4),
('Av. Quinta 5', 'Elena Fernandez', '9', 5);

-- Insertar datos en tablas con FK

-- Insertar datos en la tabla 'productos'
INSERT INTO productos (nombre, descripcion, stock, id_categoria_productos, id_proveedores) VALUES
('Producto 1', 'Descripción producto 1', 10, 1, 1),
('Producto 2', 'Descripción producto 2', 5, 2, 2),
('Producto 3', 'Descripción producto 3', 8, 3, 3),
('Producto 4', 'Descripción producto 4', 3, 4, 4),
('Producto 5', 'Descripción producto 5', 12, 5, 5);

-- Insertar datos en la tabla 'compra'
INSERT INTO compra (precio, cantidad, estado_de_compra, id_cliente, id_local, id_productos) VALUES
(100, 2, 'Pendiente', 1, 1, 1),
(200, 1, 'Completada', 2, 2, 2),
(150, 5, 'Cancelada', 3, 3, 3),
(120, 3, 'Pendiente', 4, 4, 4),
(180, 4, 'Completada', 5, 5, 5);

-- Insertar datos en la tabla 'compra_metodo_de_pago'
INSERT INTO compra_metodo_de_pago (id_compra, id_metodo_de_pago) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 1),
(5, 2),
(1, 3),
(2, 1),
(3, 2),
(4, 3),
(5, 1);

-- Insertar datos en la tabla 'empleados_categoria'
INSERT INTO empleados_categoria (id_empleados, id_categoria_empleado) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 2),
(5, 1),
(1, 2),
(2, 1),
(3, 2),
(4, 1),
(5, 2);

-- Insertar datos en la tabla 'local_empleados'
INSERT INTO local_empleados (id_local, id_empleados) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 1);


-- Insertar datos en la tabla 'detalle_de_compra'
INSERT INTO detalle_de_compra (id_compra, id_productos) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 1);

