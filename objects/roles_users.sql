USE mysql;

-- CREATE USER IF NOT EXISTS
CREATE USER IF NOT EXISTS 'admin_super'@'%' IDENTIFIED BY 'password';

-- GRANT ALL PRIVILEGES ON coderhouse_generico.* TO 'admin_super'@'%'
GRANT ALL PRIVILEGES ON coderhouse_generico.* TO 'admin_super'@'%' WITH GRANT OPTION;

FLUSH PRIVILEGES;

USE coderhouse_generico;

-- CREACIÓN DE ROLES
CREATE ROLE role_select_vistas;
CREATE ROLE role_crud_restaurantes;
CREATE ROLE role_creacion_usuarios;

-- ASIGNACIÓN DE PRIVILEGIOS AL ROL role_select_vistas
GRANT SELECT ON CLIENTE TO role_select_vistas;
GRANT SELECT ON DUENO TO role_select_vistas;
GRANT SELECT ON TIPORESERVA TO role_select_vistas;
GRANT SELECT ON EMPLEADO TO role_select_vistas;
GRANT SELECT ON RESTAURANTE TO role_select_vistas;
GRANT SELECT ON MESA TO role_select_vistas;
GRANT SELECT ON RESERVA TO role_select_vistas;

-- ASIGNACIÓN DE PRIVILEGIOS AL ROL role_crud_restaurantes
GRANT ALL PRIVILEGES ON RESTAURANTE TO role_crud_restaurantes;
GRANT ALL PRIVILEGES ON MESA TO role_crud_restaurantes;
GRANT ALL PRIVILEGES ON RESERVA TO role_crud_restaurantes;
GRANT ALL PRIVILEGES ON TIPORESERVA TO role_crud_restaurantes;
GRANT ALL PRIVILEGES ON DUENO TO role_crud_restaurantes;



-- CREACIÓN DE USUARIOS Y ASIGNACIÓN A ROLES
CREATE USER 'usuario_select'@'%' IDENTIFIED BY 'password_select';
GRANT role_select_vistas TO 'usuario_select'@'%';

CREATE USER 'usuario_crud'@'%' IDENTIFIED BY 'password_crud';
GRANT role_crud_restaurantes TO 'usuario_crud'@'%';

FLUSH PRIVILEGES;
