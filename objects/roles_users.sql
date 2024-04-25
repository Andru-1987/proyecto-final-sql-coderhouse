USE coderhouse_generico;

-- CREACIÓN DE ROLES
CREATE ROLE role_select_vistas;
CREATE ROLE role_crud_restaurantes;
CREATE ROLE role_creacion_usuarios;

-- ASIGNACIÓN DE PRIVILEGIOS AL ROL role_select_vistas
GRANT SELECT ON coderhouse_generico.CLIENTE TO role_select_vistas;
GRANT SELECT ON coderhouse_generico.DUENO TO role_select_vistas;
GRANT SELECT ON coderhouse_generico.TIPORESERVA TO role_select_vistas;
GRANT SELECT ON coderhouse_generico.EMPLEADO TO role_select_vistas;
GRANT SELECT ON coderhouse_generico.RESTAURANTE TO role_select_vistas;
GRANT SELECT ON coderhouse_generico.MESA TO role_select_vistas;
GRANT SELECT ON coderhouse_generico.RESERVA TO role_select_vistas;

-- ASIGNACIÓN DE PRIVILEGIOS AL ROL role_crud_restaurantes
GRANT ALL PRIVILEGES ON coderhouse_generico.RESTAURANTE TO role_crud_restaurantes;
GRANT ALL PRIVILEGES ON coderhouse_generico.MESA TO role_crud_restaurantes;
GRANT ALL PRIVILEGES ON coderhouse_generico.RESERVA TO role_crud_restaurantes;
GRANT ALL PRIVILEGES ON coderhouse_generico.TIPORESERVA TO role_crud_restaurantes;
GRANT ALL PRIVILEGES ON coderhouse_generico.DUENO TO role_crud_restaurantes;

-- ASIGNACIÓN DE PRIVILEGIOS AL ROL role_creacion_usuarios
GRANT CREATE USER TO role_creacion_usuarios;
GRANT DROP USER TO role_creacion_usuarios;

-- CREACIÓN DE USUARIOS Y ASIGNACIÓN A ROLES
CREATE USER 'usuario_select'@'%' IDENTIFIED BY 'password_select';
GRANT role_select_vistas TO 'usuario_select'@'%';

CREATE USER 'usuario_crud'@'%' IDENTIFIED BY 'password_crud';
GRANT role_crud_restaurantes TO 'usuario_crud'@'%';

CREATE USER 'usuario_creacion'@'%' IDENTIFIED BY 'password_creacion';
GRANT role_creacion_usuarios TO 'usuario_creacion'@'%';


FLUSH PRIVILEGES;

