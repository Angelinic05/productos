CREATE TABLE pais(
	codigo INT(10) PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(30) NOT NULL);

CREATE TABLE region(
	codigo INT(10) PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(30) NOT NULL,
	codigo_pais INT(10),
	CONSTRAINT FK_regionpais FOREIGN KEY (codigo_pais) REFERENCES pais(codigo));

CREATE TABLE ciudad(
	codigo INT(10) PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(30) NOT NULL,
	codigo_region INT(10),
	CONSTRAINT FK_ciudadregion FOREIGN KEY (codigo_region) REFERENCES region(codigo));

CREATE TABLE tipo_telefono(
	id INT(10) PRIMARY KEY AUTO_INCREMENT,
	descripcion VARCHAR(30) NOT NULL);

CREATE TABLE tipo_pago(
	id INT(10) PRIMARY KEY AUTO_INCREMENT,
	descripcion VARCHAR(30) NOT NULL);

CREATE TABLE proveedor(
	nit VARCHAR(20) PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL);

CREATE TABLE sucursal(
	id INT(10) PRIMARY KEY AUTO_INCREMENT,
	direccion VARCHAR(30) NOT NULL,
	codigo_ciudad INT(10) NOT NULL,
	nit_proveedor VARCHAR(20) NOT NULL,
	CONSTRAINT FK_sucursalciudad FOREIGN KEY (codigo_ciudad) REFERENCES ciudad(codigo),
	CONSTRAINT FK_sucursalproveedor FOREIGN KEY (nit_proveedor) REFERENCES proveedor(nit));

CREATE TABLE gama_producto(
	id INT(10) PRIMARY KEY AUTO_INCREMENT,
	descripcion_texto TEXT NOT NULL,
	descripcion_html TEXT NOT NULL,
	imagen VARCHAR(256) NOT NULL);

CREATE TABLE dimension(
	id INT(10) PRIMARY KEY AUTO_INCREMENT,
	altura VARCHAR(25) NOT NULL,
	anchura VARCHAR(25) NOT NULL,
	profundidad VARCHAR(25));

CREATE TABLE producto(
	codigo INT(10) PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(70) NOT NULL,
	descripcion VARCHAR(25),
	precio_venta DECIMAL(15,2),
	id_gama INT(10) NOT NULL,
	id_dimension INT(10) NOT NULL,	
	nit_proveedor VARCHAR(20) NOT NULL,
	CONSTRAINT FK_productogama FOREIGN KEY (id_gama) REFERENCES gama_producto(id),
	CONSTRAINT FK_productodimen FOREIGN KEY (id_dimension) REFERENCES dimension(id),
	CONSTRAINT FK_sucursalprovee FOREIGN KEY (nit_proveedor) REFERENCES proveedor(nit));

CREATE TABLE oficina(
	codigo INT(10) PRIMARY KEY AUTO_INCREMENT,
	codigo_postal VARCHAR(10) NOT NULL,
	linea_direccion1 VARCHAR(50) NOT NULL,
	linea_direccion2 VARCHAR(50),
	codigo_ciudad INT(10) NOT NULL,
	CONSTRAINT FK_oficinaciudad FOREIGN KEY (codigo_ciudad) REFERENCES ciudad(codigo));


CREATE TABLE inventario(
	id INT(10) PRIMARY KEY AUTO_INCREMENT,
	stock_min SMALLINT(6),
	stock_max SMALLINT(6),
	stock SMALLINT(6) NOT NULL,
	codigo_producto INT(10),
	CONSTRAINT FK_invproducto FOREIGN KEY (codigo_producto) REFERENCES producto(codigo));
	
CREATE TABLE empleado(
	cedula INT(10) PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellido1 VARCHAR(30) NOT NULL,
	apellido2 VARCHAR(30),
	extension VARCHAR(10) NOT NULL,
	puesto VARCHAR(50) NOT NULL,
	codigo_oficina INT(10) NOT NULL,
	jefe INT(10),
	email VARCHAR(100) NOT NULL,
	CONSTRAINT FK_empleadoficina FOREIGN KEY (codigo_oficina) REFERENCES oficina(codigo),
	CONSTRAINT FK_empleadojefe FOREIGN KEY (jefe) REFERENCES empleado(cedula));

	

CREATE TABLE cliente(
	cedula INT(10) NOT NULL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	linea_direccion1 VARCHAR(30) NOT NULL,
	linea_direccion2 VARCHAR(30) NOT NULL,
	codigo_postal VARCHAR(10),
	limite_credito DECIMAL(15,2),
	cedula_empleado INT(10),
	codigo_ciudad INT(10) NOT NULL,
	CONSTRAINT FK_clientempleado FOREIGN KEY (cedula_empleado) REFERENCES empleado(cedula),
	CONSTRAINT FK_clienteciudad FOREIGN KEY (codigo_ciudad) REFERENCES ciudad(codigo));


CREATE TABLE pedido(
	codigo INT(10) PRIMARY KEY AUTO_INCREMENT,
	fecha_pedido DATE NOT NULL,
	fecha_esperada DATE NOT NULL,
	fecha_entrega DATE,
	estado VARCHAR(15) NOT NULL,
	cedula_cliente INT(10) NOT NULL,
	comentarios TEXT,
	CONSTRAINT FK_pedidocliente FOREIGN KEY (cedula_cliente) REFERENCES cliente(cedula));


CREATE TABLE detalle_pedido(
	codigo_pedido INT(10) NOT NULL,
	codigo_producto INT(10) NOT NULL,
	cantidad INT(11) NOT NULL,
	precio_unidad DECIMAL(15,2) NOT NULL,
	numero_linea SMALLINT(6),
	PRIMARY KEY (codigo_pedido,codigo_producto),
	CONSTRAINT FK_detprodpedido FOREIGN KEY (codigo_pedido) REFERENCES pedido(codigo),	CONSTRAINT FK_detprodprod FOREIGN KEY (codigo_producto) REFERENCES producto(codigo));

CREATE TABLE pago(
	id INT(10) PRIMARY KEY AUTO_INCREMENT,
	fecha DATE NOT NULL,
	total DECIMAL(15,2) NOT NULL,
	cedula_cliente INT(10) NOT NULL,
	id_tipo_pago INT(10) NOT NULL,
	CONSTRAINT FK_pagocliente FOREIGN KEY (cedula_cliente) REFERENCES cliente(cedula),
	CONSTRAINT FK_pago_tipopago FOREIGN KEY (id_tipo_pago) REFERENCES tipo_pago(id));

CREATE TABLE contacto(
	id INT(10) PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	email VARCHAR(50),
	cedula_cliente INT(10),
	nit_proveedor VARCHAR(20),
	CONSTRAINT FK_contcliente FOREIGN KEY (cedula_cliente) REFERENCES cliente(cedula),
	CONSTRAINT FK_contprovee FOREIGN KEY (nit_proveedor) REFERENCES proveedor(nit));

CREATE TABLE telefono(
	id INT(10) PRIMARY KEY AUTO_INCREMENT,
	numero INT(10) NOT NULL,
	prefijo VARCHAR(5) NOT NULL,
	cedula_cliente INT(10),
	nit_proveedor VARCHAR(20),
	codigo_oficina INT(10),
	id_tipo_telefono INT(10),
	CONSTRAINT FK_telcliente FOREIGN KEY (cedula_cliente) REFERENCES cliente(cedula),
	CONSTRAINT FK_telprovee FOREIGN KEY (nit_proveedor) REFERENCES proveedor(nit),
	CONSTRAINT FK_teloficina FOREIGN KEY (codigo_oficina) REFERENCES oficina(codigo),
	CONSTRAINT FK_teltipo FOREIGN KEY (id_tipo_telefono) REFERENCES tipo_telefono(id));