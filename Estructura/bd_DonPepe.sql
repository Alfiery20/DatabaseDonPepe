--CREATE DATABASE bd_bodega_donPepe
--USE bd_bodega_donPepe
CREATE TABLE CATEGORIA
(
	id_Categoria SMALLINT IDENTITY(1,1),
	codigo VARCHAR(2),
	nombre VARCHAR(1000),
	estado CHAR(1), --A: ACTIVO, I: INACTIVO
	CONSTRAINT pk_categoria
		PRIMARY KEY(id_Categoria)
)

CREATE TABLE USUARIO
(
	id_Usuario SMALLINT IDENTITY(1,1),
	codigo VARCHAR(20),
	nombre VARCHAR(1000),
	apellido_Paterno VARCHAR(500),
	apellido_Materno VARCHAR(500),
	fecha_Nacimiento VARCHAR(10),
	telefono VARCHAR(9),
	direccion VARCHAR(5000),
	correoElectronico VARCHAR(5000)
	CONSTRAINT pk_usuario
		PRIMARY KEY(id_Usuario)
)

CREATE TABLE PRODUCTO
(
	id_Producto SMALLINT IDENTITY(1,1),
	codigo VARCHAR(4),
	nombre VARCHAR(1000),
	marca VARCHAR(1000),
	precio DECIMAL(3,3),
	stock SMALLINT,
	estado CHAR(1), --A: ACTIVO, I: INACTIVO
	usuario_Inserta SMALLINT,
	usuario_Actualiza SMALLINT,
	usuario_Elimina SMALLINT,
	CONSTRAINT pk_producto
		PRIMARY KEY(id_Producto),
	CONSTRAINT fk_producto_Usuario_I
		FOREIGN KEY(usuario_Inserta)
		REFERENCES USUARIO(id_Usuario),
	CONSTRAINT fk_producto_Usuario_A
		FOREIGN KEY(usuario_Actualiza)
		REFERENCES USUARIO(id_Usuario),
	CONSTRAINT fk_producto_Usuario_E
		FOREIGN KEY(usuario_Elimina)
		REFERENCES USUARIO(id_Usuario),
)

CREATE TABLE CATEGORIAXPRODUCTO
(
	id_Categoria SMALLINT,
	id_Producto SMALLINT,
	CONSTRAINT fk_categoriaxproducto_categoria
		FOREIGN KEY(id_Categoria)
		REFERENCES CATEGORIA(id_Categoria),
	CONSTRAINT fk_categoriaxproducto_producto
		FOREIGN KEY(id_Producto)
		REFERENCES PRODUCTO(id_Producto),
)