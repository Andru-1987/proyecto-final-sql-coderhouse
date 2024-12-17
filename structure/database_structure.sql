DROP DATABASE IF EXISTS es_deportes;
CREATE DATABASE es_deportes;
USE es_deportes;

CREATE TABLE cliente (
    id_cliente INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    email VARCHAR(254) UNIQUE,
    PRIMARY KEY (id_cliente)
);

CREATE TABLE compra (
    id_compra INT NOT NULL AUTO_INCREMENT,
    precio INT,
    cantidad DECIMAL(10, 2),
    fecha_de_compra DATETIME DEFAULT(NOW()),
    estado_de_compra ENUM('Pendiente', 'Completada', 'Cancelada'),
    id_cliente INT, -- FK
    id_local INT, -- FK
    id_productos INT, -- FK
    PRIMARY KEY (id_compra)
);

CREATE TABLE metodo_de_pago (
    id_metodo_de_pago INT NOT NULL AUTO_INCREMENT,
    tipo ENUM('Efectivo', 'Tarjeta', 'Aplicación'),
    PRIMARY KEY (id_metodo_de_pago)
);

CREATE TABLE productos (
    id_productos INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(254),
    descripcion VARCHAR(254),
    stock INT,
    id_categoria_productos INT,
    id_proveedores iNT,
    PRIMARY KEY (id_productos)
);

CREATE TABLE categoria_productos (
    id_categoria_productos INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(200),
    descripcion VARCHAR(255),
    PRIMARY KEY (id_categoria_productos)
);

CREATE TABLE proveedores (
    id_proveedores INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(200),
    direccion VARCHAR(255) UNIQUE NOT NULL,
    PRIMARY KEY (id_proveedores)
);

CREATE TABLE local (
    id_local INT NOT NULL AUTO_INCREMENT,
    direccion VARCHAR(255) UNIQUE NOT NULL,
    encargado VARCHAR(255) NOT NULL,
    horarios ENUM('9', '21'),
    id_empleados INT,
    PRIMARY KEY (id_local)
);

CREATE TABLE empleados (
    id_empleados INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(255),
    apellido VARCHAR(255),
    fecha_de_nacimiento DATE,
    dni VARCHAR(20),
    PRIMARY KEY (id_empleados)
);

CREATE TABLE categoria_empleado (
    id_categoria_empleado INT NOT NULL AUTO_INCREMENT,
    rol ENUM('Vendedor', 'Encargado'),
    PRIMARY KEY (id_categoria_empleado)
);

-- Tablas intermedias

CREATE TABLE compra_metodo_de_pago (
    id_compra_metodo_de_pago INT NOT NULL AUTO_INCREMENT,
    id_compra INT,
    id_metodo_de_pago INT,
    PRIMARY KEY (id_compra_metodo_de_pago)
);

CREATE TABLE detalle_de_compra (
    id_detalle_de_compra INT NOT NULL AUTO_INCREMENT,
    id_compra INT,
    id_productos INT,
    PRIMARY KEY (id_detalle_de_compra)
);

CREATE TABLE local_empleados (
    id_local_empleados INT NOT NULL AUTO_INCREMENT,
    id_local INT,
    id_empleados INT,
    PRIMARY KEY (id_local_empleados)
);

CREATE TABLE empleados_categoria (
    id_empleados_categoria INT NOT NULL AUTO_INCREMENT,
    id_empleados INT,
    id_categoria_empleado INT,
    PRIMARY KEY (id_empleados_categoria)
);


-- FK TABLA COMPRA

 ALTER TABLE compra
    ADD CONSTRAINT fk_constraint_id_cliente
    FOREIGN KEY(id_cliente) REFERENCES cliente(id_cliente);
    
    ALTER TABLE compra
    ADD CONSTRAINT fk_constraint_id_local
    FOREIGN  KEY(id_local) REFERENCES local(id_local);

    ALTER TABLE compra
    ADD CONSTRAINT fk_constraint_id_productos
    FOREIGN  KEY(id_productos) REFERENCES productos(id_productos);

-- FK TABLA PRODUCTOS
    ALTER TABLE productos
    ADD CONSTRAINT fk_constraint_id_categoria_productos
    FOREIGN KEY (id_categoria_productos) REFERENCES categoria_productos(id_categoria_productos);
    
    ALTER TABLE productos
    ADD CONSTRAINT fk_constraint_id_proveedor
    FOREIGN KEY (id_proveedores) REFERENCES proveedores(id_proveedores);
    
-- FK TABLA LOCAL
	ALTER TABLE local
    ADD CONSTRAINT fk_constraint_id_empleados
    FOREIGN KEY (id_empleados) REFERENCES empleados(id_empleados);

 -- FK TABLA INTERMEDIA compra_metodo_de_pago
ALTER TABLE compra_metodo_de_pago
    ADD CONSTRAINT fk_constraint_id_compra
    FOREIGN KEY (id_compra) REFERENCES compra(id_compra);

ALTER TABLE compra_metodo_de_pago
    ADD CONSTRAINT fk_constraint_id_metodo_de_pago
    FOREIGN KEY (id_metodo_de_pago) REFERENCES metodo_de_pago(id_metodo_de_pago);
    
 -- FK TABLA INTERMEDIA detalle_de_compra
 ALTER TABLE detalle_de_compra
    ADD CONSTRAINT fk_constraint_id_detalle_compra
    FOREIGN KEY (id_compra) REFERENCES compra(id_compra);

ALTER TABLE detalle_de_compra
    ADD CONSTRAINT fk_constraint_id_detalle_producto
    FOREIGN KEY (id_productos) REFERENCES productos(id_productos);

 -- FK TABLA INTERMEDIA local_empleados
 ALTER TABLE local_empleados
    ADD CONSTRAINT fk_constraint_id_local_empleados
    FOREIGN KEY (id_local) REFERENCES local(id_local);

ALTER TABLE local_empleados
    ADD CONSTRAINT fk_constraint_id_empleados_local
    FOREIGN KEY (id_empleados) REFERENCES empleados(id_empleados);
    

-- FK TABLA INTERMEDIA empleados_categoria
ALTER TABLE empleados_categoria
    ADD CONSTRAINT fk_constraint_id_empleados_categoria
    FOREIGN KEY (id_empleados) REFERENCES empleados(id_empleados);

ALTER TABLE empleados_categoria
    ADD CONSTRAINT fk_empleados_categoria
    FOREIGN KEY (id_categoria_empleado) REFERENCES categoria_empleado(id_categoria_empleado);