# PROYECTO - Productos

**Creación de la base de datos**

```mysql
CREATE DATABASES productos;
USE productos
```

**DER**

![image](C:\Users\57322\OneDrive\Documentos\Campuslands\BD\Taller3\DER_Taller3.png)

**Creación de las tablas**

```mysql
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
```



**Inserción de datos**

~~~sql
1. Tabla pais

INSERT INTO pais (nombre) VALUES
('España'),
('Francia'),
('Italia'),
('Alemania'),
('Reino Unido'),
('Portugal'),
('Suiza'),
('Holanda'),
('Bélgica'),
('Suecia');

2. Tabla region
INSERT INTO region (nombre, codigo_pais) VALUES
('Madrid', 1),
('Barcelona', 1),
('París', 2),
('Marsella', 2),
('Roma', 3),
('Milán', 3),
('Berlín', 4),
('Hamburgo', 4),
('Londres', 5),
('Liverpool', 5);
```

3. Tabla ciudad
INSERT INTO ciudad (nombre, codigo_region) VALUES
('Madrid', 1),
('Barcelona', 2),
('París', 3),
('Marsella', 4),
('Roma', 5),
('Milán', 6),
('Berlín', 7),
('Hamburgo', 8),
('Londres', 9),
('Liverpool', 10);
```

4. Tabla tipo_telefono

INSERT INTO tipo_telefono (descripcion) VALUES
('Móvil'),
('Fijo'),
('Fax'),
('Satélite'),
('IP');

5. Tabla `tipo_pago
INSERT INTO tipo_pago (descripcion) VALUES
('PayPal'),
('Transferencia'),
('Tarjeta de Crédito'),
('Cheque'),
('Efectivo');


6. Tabla proveedor

INSERT INTO proveedor (nit, nombre) VALUES
('123456789', 'Proveedor A'),
('987654321', 'Proveedor B'),
('111111111', 'Proveedor C'),
('222222222', 'Proveedor D'),
('333333333', 'Proveedor E'),
('444444444', 'Proveedor F'),
('555555555', 'Proveedor G'),
('666666666', 'Proveedor H'),
('777777777', 'Proveedor I'),
('888888888', 'Proveedor J');

7. Tabla sucursal

INSERT INTO sucursal (direccion, codigo_ciudad, nit_proveedor) VALUES
('Calle 123', 1, '123456789'),
('Calle 456', 2, '123456789'),
('Avenida X', 3, '987654321'),
('Avenida Y', 4, '987654321'),
('Calle Z', 5, '111111111'),
('Avenida W', 6, '111111111'),
('Calle 789', 7, '222222222'),
('Avenida 012', 8, '222222222'),
('Calle 345', 9, '333333333'),
('Avenida 678', 10, '333333333');

8. Tabla gama_producto
INSERT INTO gama_producto (descripcion_texto, descripcion_html, imagen) VALUES
('Ornamentales', 'Descripción de Ornamentales', 'imagen1.jpg'),
('Frutales', 'Descripción de Frutales', 'imagen2.jpg'),
('Juguetes', 'Descripción de Juguetes', 'imagen3.jpg'),
('Electrónicos', 'Descripción de Electrónicos', 'imagen4.jpg'),
('Muebles', 'Descripción de Muebles', 'imagen5.jpg'),
('Ropa', 'Descripción de Ropa', 'imagen6.jpg'),
('Libros', 'Descripción de Libros', 'imagen7.jpg'),
('Herramientas', 'Descripción de Herramientas', 'imagen8.jpg'),
('Deportes', 'Descripción de Deportes', 'imagen9.jpg'),
('Joyería', 'Descripción de Joyería', 'imagen10.jpg');


9. Tabla dimension

INSERT INTO dimension (altura, anchura, profundidad) VALUES
('10 cm', '5 cm', '2 cm'),
('20 cm', '10 cm', '5 cm'),
('30 cm', '15 cm', '8 cm'),
('40 cm', '20 cm', '10 cm'),
('50 cm', '25 cm', '12 cm'),
('60 cm', '30 cm', '15 cm'),
('70 cm', '35 cm', '18 cm'),
('80 cm', '40 cm', '20 cm'),
('90 cm', '45 cm', '22 cm'),
('100 cm', '50 cm', '25 cm');


10. Tabla producto

INSERT INTO producto (nombre, descripcion, precio_venta, id_gama, id_dimension, nit_proveedor) VALUES
('Producto 1', 'Descripción de Producto', 20.50, 1, 1, '123456789'),
('Producto 2', 'Descripción de Producto', 30.75, 2, 2, '987654321'),
('Producto 3', 'Descripción de Producto', 40.25, 3, 3, '111111111'),
('Producto 4', 'Descripción de Producto', 50.00, 4, 4, '222222222'),
('Producto 5', 'Descripción de Producto', 60.75, 5, 5, '333333333'),
('Producto 6', 'Descripción de Producto', 70.25, 6, 6, '444444444'),
('Producto 7', 'Descripción de Producto', 80.50, 7, 7, '555555555'),
('Producto 8', 'Descripción de Producto', 90.75, 8, 8, '666666666'),
('Producto 9', 'Descripción de Producto', 100.25, 9, 9, '777777777'),
('Producto 10', 'Descripción de Producto', 110.50, 10, 10, '888888888');



11. Tabla oficina

INSERT INTO oficina (codigo_postal, linea_direccion1, linea_direccion2, codigo_ciudad) VALUES
('28001', 'Calle Mayor 1', 'Piso 1', 1),
('28002', 'Fuenlabrada', 'Piso 2', 1), -- Aquí faltaba una comilla después de Fuenlabrada
('75001', 'Rue Principale 1', 'Étage 1', 3),
('75002', 'Fuenlabrada', 'Étage 2', 3),
('00100', 'Via Principale 1', 'Piano 1', 5),
('00101', 'Corso Secondario 2', 'Piano 2', 5),
('10001', 'Fuenlabrada', 'Stockwerk 1', 7),
('10002', 'Nebenstraße 2', 'Stockwerk 2', 7),
('E1 7AD', 'High Street 1', 'Floor 1', 9),
('L1 1AA', 'Water Street 2', 'Floor 2', 10);


12. Tabla inventario

INSERT INTO inventario (stock_min, stock_max, stock, codigo_producto) VALUES
(10, 50, 30, 11),
(20, 100, 50, 12),
(30, 150, 80, 13),
(40, 200, 120, 14),
(50, 250, 150, 15),
(60, 300, 180, 16),
(70, 350, 210, 17),
(80, 400, 240, 18),
(90, 450, 270, 19),
(100, 500, 300, 20);


13. Tabla `empleado`

INSERT INTO empleado (cedula, nombre, apellido1, apellido2, extension, puesto, codigo_oficina, jefe, email) VALUES
(1, 'Juan', 'González', 'Martínez', '123', 'Gerente', 1, NULL, 'juan.gonzalez@example.com'),
(2, 'María', 'López', 'Sánchez', '456', 'representante de ventas', 1, 1, 'maria.lopez@example.com'),
(3, 'Carlos', 'Rodríguez', 'Gómez', '789', 'Vendedor', 2, 1, 'carlos.rodriguez@example.com'),
(4, 'Laura', 'Pérez', 'Díaz', '101', 'representante de ventas', 2, 3, 'laura.perez@example.com'),
(5, 'Ana', 'Hernández', 'Vidal', '112', 'Técnico', 3, 1, 'ana.hernandez@example.com'),
(6, 'David', 'Martínez', 'Fernández', '131', 'Recepcionista', 3, 1, 'david.martinez@example.com'),
(7, 'Sara', 'Gómez', 'López', '141', 'Analista', 4, 2, 'sara.gomez@example.com'),
(8, 'Javier', 'Díaz', 'Ruiz', '151', 'representante de ventas', 4, 2, 'javier.diaz@example.com'),
(9, 'Elena', 'Vidal', 'Hernández', '161', 'Soporte', 5, 3, 'elena.vidal@example.com'),
(10, 'Pedro', 'Fernández', 'González', '171', 'Reclutador', 5, 3, 'pedro.fernandez@example.com'),
(11, 'Rosa', 'Fernández', 'González', '171', 'Reclutador', 5, 3, 'rosa.fernandez@example.com'),
(12, 'Angeli', 'Corredor', 'González', '171', 'Reclutador', 5, 3, 'angeli.corredor@example.com');


14. Tabla cliente

INSERT INTO cliente (cedula, nombre, linea_direccion1, linea_direccion2, codigo_postal, limite_credito, cedula_empleado, codigo_ciudad) VALUES
(1, 'Luis', 'Calle Principal 1', 'Piso 1', '28001', 500.00, 1, 1),
(2, 'Isabel', 'Avenida Central 2', 'Piso 2', '28002', 1000.00, 2, 1),
(3, 'Miguel', 'Rue Principale 1', 'Étage 1', '75001', 750.00, 3, 3),
(4, 'Elena', 'Via Principale 1', 'Piano 1', '00100', 800.00, 4, 5),
(5, 'Daniel', 'Hauptstraße 1', 'Stockwerk 1', '10001', 600.00, 5, 7),
(6, 'Carmen', 'High Street 1', 'Floor 1', 'E1 7AD', 900.00, 6, 9),
(7, 'Pablo', 'Calle Mayor 2', 'Piso 2', '28001', 700.00, 7, 1),
(8, 'Lucía', 'Avenida Central 3', 'Piso 3', '28002', 1200.00, 8, 1),
(9, 'Ricardo', 'Boulevard Central 2', 'Étage 2', '75002', 650.00, 9, 3),
(10, 'Sofía', 'Corso Secondario 2', 'Piano 2', '00101', 850.00, 10, 5);


15. Tabla pedido

INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, cedula_cliente, comentarios) VALUES
('2024-04-01', '2020-04-15', '2024-04-20', 'Entregado', 1, 'Entrega realizada a tiempo'),
('2024-04-02', '2012-04-16', '2024-04-25', 'Retrasado', 2, 'Entrega retrasada por problemas de logística'),
('2010-01-03', '2010-01-17', '2010-01-17', 'Entregado', 3, 'Pedido en espera de confirmación de inventario'),
('2024-04-04', '2024-04-18', NULL, 'Pendiente', 4, 'Pedido en espera de confirmación de inventario'),
('2024-04-05', '2009-01-19', NULL, 'Rechazado', 5, 'Pedido en espera de confirmación de inventario'),
('2024-04-06', '2010-04-20', NULL, 'Rechazado', 6, 'Pedido en espera de confirmación de inventario'),
('2024-04-07', '2024-01-21', NULL, 'Rechazado', 7, 'Pedido en espera de confirmación de inventario'),
('2023-01-08', '2023-01-22', '2010-01-18', 'Entregado', 8, 'Pedido en espera de confirmación de inventario'),
('2024-04-09', '2009-04-23', NULL, 'Rechazado', 9, 'Pedido en espera de confirmación de inventario'),
('2024-04-10', '2024-04-24', NULL, 'Pendiente', 10, 'Pedido en espera de confirmación de inventario');

```

16. Tabla detalle_pedido

INSERT INTO detalle_pedido (cantidad, precio_unidad, codigo_producto, codigo_pedido) VALUES
(5, 20.50, 11, 11),
(10, 30.75, 12, 12),
(15, 40.25, 13, 13),
(20, 50.00, 14, 14),
(25, 60.75, 15, 15),
(30, 70.25, 16, 16),
(35, 80.50, 17, 17),
(40, 90.75, 18, 18),
(45, 100.25, 19, 19),
(50, 110.50, 20, 20);


17. Tabla pago
INSERT INTO pago (total, fecha, cedula_cliente, id_tipo_pago) VALUES
(200.00, '2024-04-01', 1, 1),
(300.00, '2023-04-02', 2, 2),
(400.00, '2008-04-03', 3, 3),
(500.00, '2009-04-04', 4, 4),
(600.00, '2008-04-05', 5, 5),
(700.00, '2009-04-06', 6, 1),
(800.00, '2020-04-07', 7, 2),
(900.00, '2021-04-08', 8, 3),
(1000.00, '2009-04-09', 9, 4),
(1100.00, '2022-04-10', 10, 5);

18. Tabla contacto
INSERT INTO contacto (nombre, apellido, email, cedula_cliente, nit_proveedor) VALUES
('Juan', 'Pérez', 'juan.perez@example.com', 1, NULL),
('María', 'López', 'maria.lopez@example.com', 2, NULL),
('Pedro', 'Gómez', 'pedro.gomez@example.com', NULL, '123456789'),
('Ana', 'Martínez', 'ana.martinez@example.com', NULL, '987654321');


19. Tabla telefono
INSERT INTO telefono (numero, prefijo, cedula_cliente, nit_proveedor, codigo_oficina, id_tipo_telefono) VALUES
(123456789, '+34', 1, NULL, NULL, 1),
(234567890, '+34', 2, NULL, NULL, 2),
(345678901, '+34', NULL, '123456789', NULL, 3),
(456789012, '+34', NULL, '987654321', NULL, 4),
(567890123, '+34', NULL, NULL, 1, 5),
(678901234, '+34', NULL, NULL, 2, 1),
(789012345, '+34', NULL, '123456789', NULL, 2),
(890123456, '+34', NULL, NULL, 3, 3),
(901234567, '+34', NULL, NULL, 4, 4),
(123456789, '+44', NULL, NULL, 5, 5);

~~~

#### **Consultas sobre una tabla**

1. **Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.**

   ```sql
   SELECT oficina.codigo, ciudad.nombre AS ciudad
   FROM oficina
   INNER JOIN ciudad ON oficina.codigo_ciudad = ciudad.codigo;
   
   +--------+-----------+
   | codigo | ciudad	 |
   +--------+-----------+
   |  	1    | Madrid	 |
   |  	2 	 | Madrid	 |
   |  	3 	 | París 	 |
   |  	4 	 | París 	 |
   |  	5 	 | Roma  	 |
   |  	6 	 | Roma  	 |
   |  	7 	 | Berlín	 |
   |  	8 	 | Berlín	 |
   |  	9 	 | Londres   |
   | 	10 	 | Liverpool |
   +--------+-----------+
   
   ```

   

2. **Devuelve un listado con la ciudad y el teléfono de las oficinas de España.**

   ```sql
   SELECT ciudad.nombre AS ciudad, telefono.numero
   FROM oficina
   INNER JOIN ciudad ON oficina.codigo_ciudad = ciudad.codigo
   INNER JOIN telefono ON oficina.codigo = telefono.codigo_oficina
   INNER JOIN pais ON ciudad.codigo_region = pais.codigo
   WHERE pais.nombre = 'España';
   
   +--------+-----------+
   | ciudad | numero    |
   +--------+-----------+
   | Madrid | 567890123 |
   | Madrid | 678901234 |
   +--------+-----------+
   ```

   

3. **Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.**

  ```sql
  SELECT empleado.nombre, empleado.apellido1, empleado.apellido2, empleado.email
  FROM empleado
  WHERE empleado.cedula = 7;
  
  +--------+-----------+-----------+------------------------+
  | nombre | apellido1 | apellido2 | email              	|
  +--------+-----------+-----------+------------------------+
  | Sara   | Gómez 	| López 	| sara.gomez@example.com |
  +--------+-----------+-----------+------------------------+
  
  ```

  

4. **Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la**
    **empresa.**

  ```sql
  SELECT empleado.puesto, empleado.nombre, empleado.apellido1, empleado.apellido2, empleado.email
  FROM empleado
  WHERE empleado.cedula = (SELECT jefe FROM empleado WHERE jefe IS NULL);
  ```

  

5. **Devuelve un listado con el nombre, apellidos y puesto de aquellos**
    **empleados que no sean representantes de ventas.**

  ```sql
  SELECT nombre, apellido1, apellido2, puesto
  FROM empleado
  WHERE puesto != 'representante de ventas';
  
  +--------+------------+------------+---------------+
  | nombre | apellido1  | apellido2  | puesto        |
  +--------+------------+------------+---------------+
  | Juan   | González   | Martínez   | Gerente       |
  | Carlos | Rodríguez  | Gómez      | Vendedor      |
  | Ana    | Hernández  | Vidal      | Técnico       |
  | David  | Martínez   | Fernández  | Recepcionista |
  | Sara   | Gómez      | López      | Analista      |
  | Elena  | Vidal      | Hernández  | Soporte       |
  | Pedro  | Fernández  | González   | Reclutador    |
  | Rosa   | Fernández  | González   | Reclutador    |
  | Angeli | Corredor   | González   | Reclutador    |
  +--------+------------+------------+---------------+
  
  ```

  

6. **Devuelve un listado con el nombre de los todos los clientes españoles.**

   ```sql
   SELECT cliente.nombre, pais.nombre
   FROM cliente
   INNER JOIN ciudad ON cliente.codigo_ciudad = ciudad.codigo
   INNER JOIN region ON ciudad.codigo_region = region.codigo
   INNER JOIN pais ON region.codigo_pais = pais.codigo
   WHERE pais.nombre = 'España';
   +--------+
   | nombre |
   +--------+
   | Luis   |
   | Isabel |
   | Pablo  |
   | Lucía  |
   +--------+
   
   ```

   

7. **Devuelve un listado con los distintos estados por los que puede pasar un**
    **pedido.**

  ```sql
  SELECT DISTINCT estado
  FROM pedido;
  
  +-----------+
  | estado	|
  +-----------+
  | Entregado |
  | Retrasado |
  | Pendiente |
  | Rechazado |
  +-----------+
  
  ```

  

8. **Devuelve un listado con el código de cliente de aquellos clientes que**
    **realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar**
    **aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:**
    **• Utilizando la función YEAR de MySQL.**

  ```sql
  SELECT DISTINCT cedula_cliente
  FROM pago
  WHERE YEAR(fecha) = 2008;
  +----------------+
  | cedula_cliente |
  +----------------+
  |          	3    |
  |          	5    |
  +----------------+
  
  ```

  **• Utilizando la función DATE_FORMAT de MySQL.**

  ```sql
  SELECT DISTINCT cedula_cliente
  FROM pago
  WHERE DATE_FORMAT(fecha, '%Y') = '2008';
  
  +----------------+
  | cedula_cliente |
  +----------------+
  |          	3    |
  |          	5    |
  +----------------+
  ```

  **• Sin utilizar ninguna de las funciones anteriores.**

  ```sql
  SELECT DISTINCT cedula_cliente
  FROM pago
  WHERE fecha >= '2008-01-01' AND fecha < '2009-01-01';
  
  +----------------+
  | cedula_cliente |
  +----------------+
  |          	3    |
  |          	5    |
  +----------------+
  ```

  

9. **Devuelve un listado con el código de pedido, código de cliente, fecha**
    **esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.**

  ```sql
  SELECT codigo, cedula_cliente, fecha_esperada, fecha_entrega
  FROM pedido
  WHERE estado != 'Entregado' AND fecha_entrega > fecha_esperada;
  
  +--------+----------------+----------------+---------------+
  | codigo | cedula_cliente | fecha_esperada | fecha_entrega |
  +--------+----------------+----------------+---------------+
  | 	12 |          	2 | 2012-04-16 	| 2024-04-25	|
  +--------+----------------+----------------+---------------+
  
  ```

  

10. **Devuelve un listado con el código de pedido, código de cliente, fecha**
    **esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al**
    **menos dos días antes de la fecha esperada.**
    **• Utilizando la función ADDDATE de MySQL.**

    ```sql
    SELECT codigo, cedula_cliente, fecha_esperada, fecha_entrega
    FROM pedido
    WHERE DATEDIFF(fecha_entrega, fecha_esperada) <= -2;
    +--------+----------------+----------------+---------------+
    | codigo | cedula_cliente | fecha_esperada | fecha_entrega |
    +--------+----------------+----------------+---------------+
    | 	18   |          	8 | 2023-01-22 	   | 2010-01-18	   |
    +--------+----------------+----------------+---------------+
    
    ```

    **• Utilizando la función DATEDIFF de MySQL.**

    ```sql
    SELECT codigo, cedula_cliente, fecha_esperada, fecha_entrega
    FROM pedido
    WHERE ADDDATE(fecha_esperada, -2) >= fecha_entrega;
    +--------+----------------+----------------+---------------+
    | codigo | cedula_cliente | fecha_esperada | fecha_entrega |
    +--------+----------------+----------------+---------------+
    | 	18   |          	8 | 2023-01-22 	   | 2010-01-18	   |
    +--------+----------------+----------------+---------------+
    
    ```

    **• ¿Sería posible resolver esta consulta utilizando el operador de suma + o resta -?**

    ```sql
    SELECT codigo, cedula_cliente, fecha_esperada, fecha_entrega
    FROM pedido
    WHERE fecha_entrega <= fecha_esperada - INTERVAL 2 DAY;
    +--------+----------------+----------------+---------------+
    | codigo | cedula_cliente | fecha_esperada | fecha_entrega |
    +--------+----------------+----------------+---------------+
    | 	18   |          	8 | 2023-01-22 	   | 2010-01-18	   |
    +--------+----------------+----------------+---------------+
    
    ```

11. **Devuelve un listado de todos los pedidos que fueron rechazados en 2009.**

    ```sql
    SELECT *
    FROM pedido
    WHERE estado = 'Rechazado' AND YEAR(fecha_esperada) = 2009;
    
    | codigo | fecha_pedido | fecha_esperada | fecha_entrega | estado	| cedula_cliente | comentarios                                 	|
    +--------+--------------+----------------+---------------+-----------+----------------+-------------------------------------------------+
    | 	15 | 2024-04-05   | 2009-01-19 	| NULL      	| Rechazado |          	5 | Pedido en espera de confirmación de inventario  |
    | 	19 | 2024-04-09   | 2009-04-23 	| NULL      	| Rechazado |          	9 | Pedido en espera de confirmación de inventario  |
    +--------+--------------+----------------+---------------+-----------+----------------+-------------------------------------------------+
    
    ```

    

12. **Devuelve un listado de todos los pedidos que han sido entregados en el**
    **mes de enero de cualquier año.**

    ```sql
    SELECT *
    FROM pedido
    WHERE estado = 'Entregado' AND MONTH(fecha_entrega) = 1;
    
    +--------+--------------+----------------+---------------+-----------+----------------+-------------------------------------------------+
    | codigo | fecha_pedido | fecha_esperada | fecha_entrega | estado	| cedula_cliente | comentarios                                 	|
    +--------+--------------+----------------+---------------+-----------+----------------+-------------------------------------------------+
    | 	13 | 2010-01-03   | 2010-01-17 	| 2010-01-17	| Entregado |          	3 | Pedido en espera de confirmación de inventario  |
    | 	18 | 2023-01-08   | 2023-01-22 	| 2010-01-18	| Entregado |          	8 | Pedido en espera de confirmación de inventario  |
    +--------+--------------+----------------+---------------+-----------+----------------+-------------------------------------------------+
    
    ```

    

13. **Devuelve un listado con todos los pagos que se realizaron en el**
    **año 2008 mediante Paypal. Ordene el resultado de mayor a menor.**

    ```sql
    SELECT p.*
    FROM pago p JOIN tipo_pago tp ON p.id_tipo_pago=tp.id
    WHERE YEAR(p.fecha) = 2009 AND tp.descripcion = 'PayPal'
    ORDER BY p.total DESC;
    
    +----+------------+--------+----------------+--------------+
    | id | fecha  	| total  | cedula_cliente | id_tipo_pago |
    +----+------------+--------+----------------+--------------+
    |  6 |2009-04-06| 700.00 |          	6 |        	1    |
    +----+------------+--------+----------------+--------------+
    
    ```

    

14. **Devuelve un listado con todas las formas de pago que aparecen en la**
    **tabla pago. Tenga en cuenta que no deben aparecer formas de pago**
    **repetidas.**

    ```sql
    SELECT DISTINCT id_tipo_pago
    FROM pago;
    
    +--------------+
    | id_tipo_pago |
    +--------------+
    |        	1 |
    |        	2 |
    |        	3 |
    |        	4 |
    |        	5 |
    +--------------+
    
    ```

    

15. **Devuelve un listado con todos los productos que pertenecen a la**
    **gama Ornamentales y que tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.**

    ```sql
    SELECT producto.*
    FROM producto
    INNER JOIN gama_producto ON producto.id_gama = gama_producto.id
    INNER JOIN inventario ON producto.codigo = inventario.codigo_producto
    WHERE gama_producto.descripcion_texto = 'Ornamentales' AND inventario.stock > 100
    ORDER BY producto.precio_venta DESC;
    
    ```

    

16. **Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y  cuyo representante de ventas tenga el código de empleado 11 o 30.**

    ```sql
    SELECT cliente.*
    FROM cliente
    INNER JOIN ciudad ON cliente.codigo_ciudad = ciudad.codigo
    INNER JOIN empleado ON cliente.cedula_empleado = empleado.cedula
    WHERE ciudad.nombre = 'Madrid' AND (empleado.cedula = 11 OR empleado.cedula = 30);
    ```

    

#### Consultas multitabla (Composición interna)

Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.

1. **Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.**

  ```sql
  SELECT cliente.nombre, empleado.nombre, empleado.apellido1
  FROM cliente, empleado
  WHERE cliente.cedula_empleado = empleado.cedula;
  
  +---------+--------+------------+
  | nombre  | nombre | apellido1  |
  +---------+--------+------------+
  | Luis	| Juan   | González   |
  | Isabel  | María  | López  	|
  | Miguel  | Carlos | Rodríguez  |
  | Elena   | Laura  | Pérez  	|
  | Daniel  | Ana	| Hernández  |
  | Carmen  | David  | Martínez   |
  | Pablo   | Sara   | Gómez  	|
  | Lucía   | Javier | Díaz   	|
  | Ricardo | Elena  | Vidal  	|
  | Sofía   | Pedro  | Fernández  |
  +---------+--------+------------+
  
  ```

  

2. **Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.**

  ```sql
  SELECT cliente.nombre, empleado.nombre, empleado.apellido1
  FROM cliente, empleado, pago
  WHERE cliente.cedula = pago.cedula_cliente AND cliente.cedula_empleado = empleado.cedula;
  
  +---------+--------+------------+
  | nombre  | nombre | apellido1  |
  +---------+--------+------------+
  | Luis	  | Juan   | González   |
  | Isabel  | María  | López  	|
  | Miguel  | Carlos | Rodríguez  |
  | Elena   | Laura  | Pérez  	|
  | Daniel  | Ana	   | Hernández  |
  | Carmen  | David  | Martínez   |
  | Pablo   | Sara   | Gómez  	|
  | Lucía   | Javier | Díaz   	|
  | Ricardo | Elena  | Vidal  	|
  | Sofía   | Pedro  | Fernández  |
  +---------+--------+------------+
  
  ```

  

3. **Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.**

  ```sql
  SELECT cliente.nombre, empleado.nombre, empleado.apellido1
  FROM cliente, empleado
  WHERE cliente.cedula_empleado = empleado.cedula AND cliente.cedula NOT IN (SELECT cedula_cliente FROM pago);
  ```

  

4. **Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.**

  ```sql
  SELECT cliente.nombre, empleado.nombre, empleado.apellido1, ciudad.nombre
  FROM cliente, empleado, pago, oficina, ciudad
  WHERE cliente.cedula = pago.cedula_cliente AND cliente.cedula_empleado = empleado.cedula AND empleado.codigo_oficina = oficina.codigo AND oficina.codigo_ciudad = ciudad.codigo;
  
  +---------+--------+------------+--------+
  | nombre  | nombre | apellido1  | nombre |
  +---------+--------+------------+--------+
  | Luis	  | Juan   | González   | Madrid |
  | Isabel  | María  | López  	| Madrid |
  | Miguel  | Carlos | Rodríguez  | Madrid |
  | Elena   | Laura  | Pérez  	| Madrid |
  | Daniel  | Ana	   | Hernández  | París  |
  | Carmen  | David  | Martínez   | París  |
  | Pablo   | Sara   | Gómez  	| París  |
  | Lucía   | Javier | Díaz   	| París  |
  | Ricardo | Elena  | Vidal  	| Roma   |
  | Sofía   | Pedro  | Fernández  | Roma   |
  +---------+--------+------------+--------+
  
  ```

  

5. **Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.**

  ```sql
  SELECT cliente.nombre, empleado.nombre, empleado.apellido1, ciudad.nombre
  FROM cliente, empleado, oficina, ciudad
  WHERE cliente.cedula_empleado = empleado.cedula AND empleado.codigo_oficina = oficina.codigo AND oficina.codigo_ciudad = ciudad.codigo AND cliente.cedula NOT IN (SELECT cedula_cliente FROM pago);
  ```

  

6. **Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.**

   ```sql
   SELECT DISTINCT o.linea_direccion1, o.linea_direccion2
   FROM cliente AS c
   JOIN empleado AS e ON c.cedula_empleado = e.cedula
   JOIN oficina AS o ON e.codigo_oficina = o.codigo
   WHERE o.linea_direccion1 = 'Fuenlabrada';
   
   +------------------+------------------+
   | linea_direccion1 | linea_direccion2 |
   +------------------+------------------+
   | Fuenlabrada  	   | Piso 2        	  |
   | Fuenlabrada  	   | Étage 2      	  |
   +------------------+------------------+
   
   ```

   

7. **Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.**

  ```sql
  SELECT cliente.nombre, empleado.nombre, empleado.apellido1, ciudad.nombre
  FROM cliente, empleado, oficina, ciudad
  WHERE cliente.cedula_empleado = empleado.cedula AND empleado.codigo_oficina = oficina.codigo AND oficina.codigo_ciudad = ciudad.codigo;
  
  +---------+--------+------------+--------+
  | nombre  | nombre | apellido1  | nombre |
  +---------+--------+------------+--------+
  | Luis	| Juan   | González   | Madrid |
  | Isabel  | María  | López  	| Madrid |
  | Miguel  | Carlos | Rodríguez  | Madrid |
  | Elena   | Laura  | Pérez  	| Madrid |
  | Daniel  | Ana	| Hernández  | París  |
  | Carmen  | David  | Martínez   | París  |
  | Pablo   | Sara   | Gómez  	| París  |
  | Lucía   | Javier | Díaz   	| París  |
  | Ricardo | Elena  | Vidal  	| Roma   |
  | Sofía   | Pedro  | Fernández  | Roma   |
  +---------+--------+------------+--------+
  
  ```

  

8. **Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.**

  ```sql
  c
  ```

  

9. **Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.**

  ```sql
  c
  ```

  

10. **Devuelve el nombre de los clientes a los que no se les ha entregado a**
    **tiempo un pedido.**

    ```sql
    c
    ```

    

11. **Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.**

    ```sql
    c
    ```

    

#### Consultas multitabla (Composición externa)

Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL LEFT JOIN y NATURAL RIGHT JOIN.

1. **Devuelve un listado que muestre solamente los clientes que no han**
    **realizado ningún pago.**

  ```sql
  SELECT cliente.nombre
  FROM cliente
  LEFT JOIN pago ON cliente.cedula = pago.cedula_cliente
  WHERE pago.cedula_cliente IS NULL;
  ```

  

2. **Devuelve un listado que muestre solamente los clientes que no han**
    **realizado ningún pedido.**

  ```sql
  SELECT cliente.nombre
  FROM cliente
  LEFT JOIN pedido ON cliente.cedula = pedido.cedula_cliente
  WHERE pedido.cedula_cliente IS NULL;
  ```

  

3. **Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.**

  ```sql
  SELECT cliente.nombre
  FROM cliente
  LEFT JOIN pago ON cliente.cedula = pago.cedula_cliente
  LEFT JOIN pedido ON cliente.cedula = pedido.cedula_cliente
  WHERE pago.cedula_cliente IS NULL AND pedido.cedula_cliente IS NULL;
  ```

  

4. **Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.**

  ```sql
  SELECT empleado.nombre
  FROM empleado
  LEFT JOIN oficina ON empleado.codigo_oficina = oficina.codigo
  WHERE oficina.codigo IS NULL;
  ```

  

5. **Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.**

  ```sql
  SELECT empleado.nombre
  FROM empleado
  LEFT JOIN cliente ON empleado.cedula = cliente.cedula_empleado
  WHERE cliente.cedula_empleado IS NULL;
  
  +--------+
  | nombre |
  +--------+
  | Rosa   |
  | Angeli |
  +--------+
  ```

  

6. **Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.**

  ```sql
  SELECT empleado.nombre, oficina.linea_direccion1 AS nombre_oficina, oficina.linea_direccion2
  FROM empleado
  LEFT JOIN cliente ON empleado.cedula = cliente.cedula_empleado
  LEFT JOIN oficina ON empleado.codigo_oficina = oficina.codigo
  WHERE cliente.cedula_empleado IS NULL;
  +--------+------------------+------------------+
  | nombre | nombre_oficina   | linea_direccion2 |
  +--------+------------------+------------------+
  | Rosa   | Via Principale 1 | Piano 1      	|
  | Angeli | Via Principale 1 | Piano 1      	|
  +--------+------------------+------------------+
  
  ```

  

7. **Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.**

  ```sql
  SELECT empleado.nombre
  FROM empleado
  LEFT JOIN oficina ON empleado.codigo_oficina = oficina.codigo
  LEFT JOIN cliente ON empleado.cedula = cliente.cedula_empleado
  WHERE oficina.codigo IS NULL OR cliente.cedula_empleado IS NULL;
  
  +--------+
  | nombre |
  +--------+
  | Rosa   |
  | Angeli |
  +--------+
  
  ```

  

8. **Devuelve un listado de los productos que nunca han aparecido en un**
    **pedido.**

  ```sql
  SELECT producto.nombre
  FROM producto
  LEFT JOIN detalle_pedido ON producto.codigo = detalle_pedido.codigo_producto
  WHERE detalle_pedido.codigo_producto IS NULL;
  
  ```

  

9. **Devuelve un listado de los productos que nunca han aparecido en un**
    **pedido. El resultado debe mostrar el nombre, la descripción y la imagen del producto.**

  ```sql
  SELECT producto.nombre, producto.descripcion, gama_producto.imagen
  FROM producto
  LEFT JOIN detalle_pedido ON producto.codigo = detalle_pedido.codigo_producto
  LEFT JOIN gama_producto ON producto.id_gama = gama_producto.id
  WHERE detalle_pedido.codigo_producto IS NULL;
  
  ```

  

10. **Devuelve las oficinas donde no trabajan ninguno de los empleados que**
    **hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.**

    ```sql
    SELECT oficina.codigo
    FROM oficina
    LEFT JOIN empleado ON oficina.codigo = empleado.codigo_oficina
    LEFT JOIN cliente ON empleado.cedula = cliente.cedula_empleado
    LEFT JOIN pedido ON cliente.cedula = pedido.cedula_cliente
    LEFT JOIN detalle_pedido ON pedido.codigo = detalle_pedido.codigo_pedido
    LEFT JOIN producto ON detalle_pedido.codigo_producto = producto.codigo
    LEFT JOIN gama_producto ON producto.id_gama = gama_producto.id
    WHERE gama_producto.descripcion_texto = 'Frutales' AND empleado.puesto = 'Representante de ventas'
    GROUP BY oficina.codigo
    HAVING COUNT(empleado.cedula) = 0;
    
    ```

    

11. **Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.**

    ```sql
    SELECT cliente.nombre
    FROM cliente
    LEFT JOIN pedido ON cliente.cedula = pedido.cedula_cliente
    LEFT JOIN pago ON cliente.cedula = pago.cedula_cliente
    GROUP BY cliente.nombre
    HAVING COUNT(DISTINCT pedido.codigo) > 0 AND COUNT(DISTINCT pago.id) = 0;
    
    ```

    

12. **Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.**

    ```sql
    SELECT empleado.nombre, empleado.apellido1, empleado.jefe, jefe.nombre AS nombre_jefe
    FROM empleado
    LEFT JOIN cliente ON empleado.cedula = cliente.cedula_empleado
    LEFT JOIN empleado AS jefe ON empleado.jefe = jefe.cedula
    WHERE cliente.cedula_empleado IS NULL;
    
    +--------+------------+------+-------------+
    | nombre | apellido1  | jefe | nombre_jefe |
    +--------+------------+------+-------------+
    | Rosa   | Fernández  |	3 | Carlos  	|
    | Angeli | Corredor   |	3 | Carlos  	|
    +--------+------------+------+-------------+
    
    ```

    

#### Consultas resumen

1. **¿Cuántos empleados hay en la compañía?**

   ```sql
   SELECT COUNT(*) AS total_empleados
   FROM empleado;
   
   +-----------------+
   | total_empleados |
   +-----------------+
   |          	12 |
   +-----------------+
   
   ```

   

2. **¿Cuántos clientes tiene cada país?**

   ```sql
   SELECT p.nombre AS pais, COUNT(*) AS total_clientes
   FROM cliente c
   INNER JOIN ciudad ci ON c.codigo_ciudad = ci.codigo
   INNER JOIN region r ON ci.codigo_region = r.codigo
   INNER JOIN pais p ON r.codigo_pais = p.codigo
   GROUP BY p.nombre;
   
   +-------------+----------------+
   | pais    	| total_clientes |
   +-------------+----------------+
   | España  	|          	4 |
   | Francia 	|          	2 |
   | Italia  	|          	2 |
   | Alemania	|          	1 |
   | Reino Unido |          	1 |
   +-------------+----------------+
   
   ```

   

3. **¿Cuál fue el pago medio en 2009?**

   ```sql
   SELECT AVG(total) AS pago_medio_2009
   FROM pago
   WHERE YEAR(fecha) = 2009;
   
   +-----------------+
   | pago_medio_2009 |
   +-----------------+
   |  	733.333333    |
   +-----------------+
   
   ```

   

4. **¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma**
    **descendente por el número de pedidos.**

  ```sql
  SELECT estado, COUNT(*) AS total_pedidos
  FROM pedido
  GROUP BY estado
  ORDER BY total_pedidos DESC;
  +-----------+---------------+
  | estado	| total_pedidos |
  +-----------+---------------+
  | Rechazado |         	4   |
  | Entregado |         	3   |
  | Pendiente |         	2   |
  | Retrasado |         	1   |
  +-----------+---------------+
  
  ```

  

5. **Calcula el precio de venta del producto más caro y más barato en una**
    **misma consulta.**

  ```sql
  SELECT MAX(precio_venta) AS precio_mas_caro, MIN(precio_venta) AS precio_mas_barato
  FROM producto;
  
  +-----------------+-------------------+
  | precio_mas_caro | precio_mas_barato |
  +-----------------+-------------------+
  |      	110.50    |         	20.50 |
  +-----------------+-------------------+
  
  ```

  

6. **Calcula el número de clientes que tiene la empresa.**

   ```sql
   SELECT COUNT(*) AS total_clientes
   FROM cliente;
   
   +----------------+
   | total_clientes |
   +----------------+
   |         	10 |
   +----------------+
   
   ```

   

7. **¿Cuántos clientes existen con domicilio en la ciudad de Madrid?**

   ```sql
   SELECT COUNT(*) AS clientes_en_madrid
   FROM cliente c
   JOIN ciudad ci ON c.codigo_ciudad = ci.codigo
   WHERE ci.nombre = 'Madrid';
   
   +--------------------+
   | clientes_en_madrid |
   +--------------------+
   |              	4 |
   +--------------------+
   
   ```

   

8. **¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan**
    **por M?**

  ```sql
  SELECT LEFT(ci.nombre, 1) AS primera_letra_ciudad, COUNT(*) AS total_clientes
  FROM cliente cl
  JOIN ciudad ci ON cl.codigo_ciudad = ci.codigo
  WHERE LEFT(ci.nombre, 1) = 'M'
  GROUP BY ci.nombre;
  
  +----------------------+----------------+
  | primera_letra_ciudad | total_clientes |
  +----------------------+----------------+
  | M                	   |          	4   |
  +----------------------+----------------+
  
  ```

  

9. **Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.**

  ```sql
  SELECT empleado.nombre, CONCAT(empleado.apellido1, ' ', empleado.apellido2) AS apellidos, COUNT(cliente.cedula) AS clientes_atendidos
  FROM empleado
  LEFT JOIN cliente ON empleado.cedula = cliente.cedula_empleado
  WHERE empleado.puesto = 'Representante de ventas'
  GROUP BY empleado.cedula;
  
  --------+-----------------+--------------------+
  | nombre | apellidos   	| clientes_atendidos |
  +--------+-----------------+--------------------+
  | María  | López Sánchez|              	1    |
  | Laura  | Pérez Díaz  	|              	1    |
  | Javier | Díaz Ruiz   	|              	1    |
  +--------+-----------------+--------------------+
  
  ```

  

10. **Calcula el número de clientes que no tiene asignado representante de**
    **ventas.**

    ```sql
    SELECT COUNT(*) AS clientes_sin_representante
    FROM cliente
    WHERE cedula_empleado IS NULL;
    
    +----------------------------+
    | clientes_sin_representante |
    +----------------------------+
    |                      	0 |
    +----------------------------+
    
    ```

    

11. **Calcula la fecha del primer y último pago realizado por cada uno de los**
    **clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.**

    ```sql
    SELECT cliente.nombre, MIN(pago.fecha) AS primer_pago, MAX(pago.fecha) AS ultimo_pago
    FROM cliente
    LEFT JOIN pago ON cliente.cedula = pago.cedula_cliente
    GROUP BY cliente.cedula;
    
    +---------+-------------+-------------+
    | nombre  | primer_pago | ultimo_pago |
    +---------+-------------+-------------+
    | Luis	| 2024-04-01  | 2024-04-01  |
    | Isabel  | 2023-04-02  | 2023-04-02  |
    | Miguel  | 2008-04-03  | 2008-04-03  |
    | Elena   | 2009-04-04  | 2009-04-04  |
    | Daniel  | 2008-04-05  | 2008-04-05  |
    | Carmen  | 2009-04-06  | 2009-04-06  |
    | Pablo   | 2020-04-07  | 2020-04-07  |
    | Lucía   | 2021-04-08  | 2021-04-08  |
    | Ricardo | 2009-04-09  | 2009-04-09  |
    | Sofía   | 2022-04-10  | 2022-04-10  |
    +---------+-------------+-------------+
    
    ```

    

12. **Calcula el número de productos diferentes que hay en cada uno de los**
    **pedidos.**

    ```sql
    SELECT codigo_pedido, COUNT(DISTINCT codigo_producto) AS productos_diferentes
    FROM detalle_pedido
    GROUP BY codigo_pedido;
    
    +---------------+----------------------+
    | codigo_pedido | productos_diferentes |
    +---------------+----------------------+
    |        	11 |                	1 |
    |        	12 |                	1 |
    |        	13 |                	1 |
    |        	14 |                	1 |
    |        	15 |                	1 |
    |        	16 |                	1 |
    |        	17 |                	1 |
    |        	18 |                	1 |
    |        	19 |                	1 |
    |        	20 |                	1 |
    +---------------+----------------------+
    
    ```

    

13. **Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.**

    ```sql
    SELECT codigo_pedido, SUM(cantidad) AS cantidad_total_productos
    FROM detalle_pedido
    GROUP BY codigo_pedido;
    
    +---------------+--------------------------+
    | codigo_pedido | cantidad_total_productos |
    +---------------+--------------------------+
    |        	11 |                    	5 |
    |        	12 |                   	10 |
    |        	13 |                   	15 |
    |        	14 |                   	20 |
    |        	15 |                   	25 |
    |        	16 |                   	30 |
    |        	17 |                   	35 |
    |        	18 |                   	40 |
    |        	19 |                   	45 |
    |        	20 |                   	50 |
    +---------------+--------------------------+
    
    ```

    

14. **Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. El listado deberá estar ordenado por el número total de unidades vendidas.**

    ```sql
    SELECT codigo_producto, SUM(cantidad) AS total_unidades_vendidas
    FROM detalle_pedido
    GROUP BY codigo_producto
    ORDER BY total_unidades_vendidas DESC
    LIMIT 20;
    +-----------------+-------------------------+
    | codigo_producto | total_unidades_vendidas |
    +-----------------+-------------------------+
    |          	20 |                  	50 |
    |          	19 |                  	45 |
    |          	18 |                  	40 |
    |          	17 |                  	35 |
    |          	16 |                  	30 |
    |          	15 |                  	25 |
    |          	14 |                  	20 |
    |          	13 |                  	15 |
    |          	12 |                  	10 |
    |          	11 |                   	5 |
    +-----------------+-------------------------+
    
    ```

    

15. **La facturación que ha tenido la empresa en toda la historia, indicando la**
    **base imponible, el IVA y el total facturado. La base imponible se calcula**
    **sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.**

    ```sql
    SELECT SUM(producto.precio_venta * detalle_pedido.cantidad) AS base_imponible,
    	SUM(producto.precio_venta * detalle_pedido.cantidad) * 0.21 AS iva,
    	SUM(producto.precio_venta * detalle_pedido.cantidad) + (SUM(producto.precio_venta * detalle_pedido.cantidad) * 0.21) AS total_facturado
    FROM detalle_pedido
    JOIN producto ON detalle_pedido.codigo_producto = producto.codigo;
    
    +----------------+-----------+-----------------+
    | base_imponible | iva   	| total_facturado |
    +----------------+-----------+-----------------+
    |   	22123.75 | 4645.9875 |  	26769.7375 |
    +----------------+-----------+-----------------+
    
    ```

    

16. **La misma información que en la pregunta anterior, pero agrupada por**
    **código de producto.**

    ```sql
    SELECT detalle_pedido.codigo_producto,
    	SUM(producto.precio_venta * detalle_pedido.cantidad) AS base_imponible,
    	SUM(producto.precio_venta * detalle_pedido.cantidad) * 0.21 AS iva,
    	SUM(producto.precio_venta * detalle_pedido.cantidad) + (SUM(producto.precio_venta * detalle_pedido.cantidad) * 0.21) AS total_facturado
    FROM detalle_pedido
    JOIN producto ON detalle_pedido.codigo_producto = producto.codigo
    GROUP BY detalle_pedido.codigo_producto;
    
    +-----------------+----------------+-----------+-----------------+
    | codigo_producto | base_imponible | iva   	| total_facturado |
    +-----------------+----------------+-----------+-----------------+
    |          	11 |     	102.50 |   21.5250 |    	124.0250 |
    |          	12 |     	307.50 |   64.5750 |    	372.0750 |
    |          	13 |     	603.75 |  126.7875 |    	730.5375 |
    |          	14 |    	1000.00 |  210.0000 |   	1210.0000 |
    |          	15 |    	1518.75 |  318.9375 |   	1837.6875 |
    |          	16 |    	2107.50 |  442.5750 |   	2550.0750 |
    |          	17 |    	2817.50 |  591.6750 |   	3409.1750 |
    |          	18 |    	3630.00 |  762.3000 |   	4392.3000 |
    |          	19 |    	4511.25 |  947.3625 |   	5458.6125 |
    |          	20 |    	5525.00 | 1160.2500 |   	6685.2500 |
    +-----------------+----------------+-----------+-----------------+
    
    ```

    

17. **La misma información que en la pregunta anterior, pero agrupada por**
    **código de producto filtrada por los códigos que empiecen por OR.**

    ```sql
    SELECT detalle_pedido.codigo_producto,
    	SUM(producto.precio_venta * detalle_pedido.cantidad) AS base_imponible,
    	SUM(producto.precio_venta * detalle_pedido.cantidad) * 0.21 AS iva,
    	SUM(producto.precio_venta * detalle_pedido.cantidad) + (SUM(producto.precio_venta * detalle_pedido.cantidad) * 0.21) AS total_facturado
    FROM detalle_pedido
    JOIN producto ON detalle_pedido.codigo_producto = producto.codigo
    WHERE detalle_pedido.codigo_producto LIKE 'OR%'
    GROUP BY detalle_pedido.codigo_producto;
    
    ```

    

18. **Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).**

    ```sql
    SELECT producto.nombre,
    	SUM(detalle_pedido.cantidad) AS unidades_vendidas,
    	SUM(producto.precio_venta * detalle_pedido.cantidad) AS total_facturado,
    	SUM(producto.precio_venta * detalle_pedido.cantidad) * 0.21 AS total_iva,
    	SUM(producto.precio_venta * detalle_pedido.cantidad) + (SUM(producto.precio_venta * detalle_pedido.cantidad) * 0.21) AS total_facturado_con_iva
    FROM detalle_pedido
    JOIN producto ON detalle_pedido.codigo_producto = producto.codigo
    GROUP BY producto.codigo
    HAVING total_facturado > 3000;
    
    +-------------+-------------------+-----------------+-----------+-------------------------+
    | nombre  	| unidades_vendidas | total_facturado | total_iva | total_facturado_con_iva |
    +-------------+-------------------+-----------------+-----------+-------------------------+
    | Producto 8  |            	40 |     	3630.00 |  762.3000 |           	4392.3000 |
    | Producto 9  |            	45 |     	4511.25 |  947.3625 |           	5458.6125 |
    | Producto 10 |            	50 |     	5525.00 | 1160.2500 |           	6685.2500 |
    +-------------+-------------------+-----------------+-----------+-------------------------+
    
    ```

    

19. **Muestre la suma total de todos los pagos que se realizaron para cada uno de los años que aparecen en la tabla pagos.**

    ```sql
    SELECT YEAR(fecha) AS año, SUM(total) AS suma_total_pagos
    FROM pago
    GROUP BY YEAR(fecha);
    
    +------+------------------+
    | año  | suma_total_pagos |
    +------+------------------+
    | 2024 |       	200.00 |
    | 2023 |       	300.00 |
    | 2008 |      	1000.00 |
    | 2009 |      	2200.00 |
    | 2020 |       	800.00 |
    | 2021 |       	900.00 |
    | 2022 |      	1100.00 |
    +------+------------------+
    
    ```

    



#### Subconsultas

Con operadores básicos de comparación

1. **Devuelve el nombre del cliente con mayor límite de crédito.**

   ```sql
   SELECT nombre
   FROM cliente
   WHERE limite_credito = (SELECT MAX(limite_credito) FROM cliente);
   
   +--------+
   | nombre |
   +--------+
   | Lucía  |
   +--------+
   
   ```

   

2. **Devuelve el nombre del producto que tenga el precio de venta más caro.**

   ```sql
   SELECT nombre
   FROM producto
   WHERE precio_venta = (SELECT MAX(precio_venta) FROM producto);
   
   +-------------+
   | nombre  	|
   +-------------+
   | Producto 10 |
   +-------------+
   
   ```

   

3. **Devuelve el nombre del producto del que se han vendido más unidades.**
   **(Tenga en cuenta que tendrá que calcular cuál es el número total de**
   **unidades que se han vendido de cada producto a partir de los datos de la tabla detalle_pedido)**

   ```sql
   SELECT p.nombre
   FROM producto p
   JOIN (
   	SELECT codigo_producto
   	FROM detalle_pedido
   	GROUP BY codigo_producto
   	ORDER BY SUM(cantidad) DESC
   	LIMIT 1
   ) AS dp ON p.codigo = dp.codigo_producto;
   
   +-------------+
   | nombre  	|
   +-------------+
   | Producto 10 |
   +-------------+
   
   ```

   

4. **Los clientes cuyo límite de crédito sea mayor que los pagos que haya**
   **realizado. (Sin utilizar INNER JOIN).**

   ```sql
   SELECT nombre
   FROM cliente
   WHERE limite_credito > (SELECT SUM(total) FROM pago WHERE cedula_cliente = cliente.cedula);
   
   +--------+
   | nombre |
   +--------+
   | Luis   |
   | Isabel |
   | Miguel |
   | Elena  |
   | Carmen |
   | Lucía  |
   +--------+
   
   ```

   

5. **Devuelve el producto que más unidades tiene en stock.**

   ```sql
   SELECT p.nombre
   FROM producto p
   JOIN inventario i ON p.codigo = i.codigo_producto
   ORDER BY i.stock DESC
   LIMIT 1;
   
   +-------------+
   | nombre  	|
   +-------------+
   | Producto 10 |
   +-------------+
   
   ```

   

6. **Devuelve el producto que menos unidades tiene en stock.**

   ```sql
   SELECT p.nombre
   FROM producto p
   JOIN (
   	SELECT codigo_producto
   	FROM inventario
   	ORDER BY stock DESC
   	LIMIT 1
   ) AS i ON p.codigo = i.codigo_producto;
   
   +-------------+
   | nombre  	|
   +-------------+
   | Producto 10 |
   +-------------+
   
   ```

   

7. **Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.**

   ```sql
   SELECT nombre, apellido1, apellido2, email
   FROM empleado
   WHERE jefe = (SELECT cedula FROM empleado WHERE nombre = 'Alberto' AND apellido1 = 'Soria');
   ```

   



#### Subconsultas con ALL y ANY

1. **Devuelve el nombre del cliente con mayor límite de crédito.**

   ```sql
   SELECT nombre
   FROM cliente
   WHERE limite_credito >= ALL (SELECT limite_credito FROM cliente);
   +--------+
   | nombre |
   +--------+
   | Lucía  |
   +--------+
   
   ```

   

2. **Devuelve el nombre del producto que tenga el precio de venta más caro.**

   ```sql
   SELECT nombre
   FROM producto
   WHERE precio_venta >= ALL (SELECT precio_venta FROM producto);
   
   +-------------+
   | nombre      |
   +-------------+
   | Producto 10 |
   +-------------+
   
   ```

   

3. **Devuelve el producto que menos unidades tiene en stock.**

   ```sql
   SELECT nombre
   FROM producto
   WHERE codigo IN (SELECT codigo_producto FROM inventario WHERE stock <= ALL (SELECT stock FROM inventario));
   +------------+
   | nombre 	|
   +------------+
   | Producto 1 |
   +------------+
   
   ```

   



#### Subconsultas con IN y NOT IN

1. **Devuelve el nombre, apellido1 y cargo de los empleados que no**
   **representen a ningún cliente.**

   ```sql
   SELECT nombre, apellido1, puesto
   FROM empleado
   WHERE cedula NOT IN (SELECT DISTINCT cedula_empleado FROM cliente);
   
   +--------+------------+------------+
   | nombre | apellido1  | puesto 	|
   +--------+------------+------------+
   | Rosa   | Fernández  | Reclutador |
   | Angeli | Corredor   | Reclutador |
   +--------+------------+------------+
   
   ```

   

2. **Devuelve un listado que muestre solamente los clientes que no han**
   **realizado ningún pago.**

   ```sql
   SELECT nombre
   FROM cliente
   WHERE cedula NOT IN (SELECT DISTINCT cedula_cliente FROM pago);
   ```

   

3. **Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.**

   ```sql
   SELECT nombre
   FROM cliente
   WHERE cedula IN (SELECT DISTINCT cedula_cliente FROM pago);
   
   +---------+
   | nombre  |
   +---------+
   | Luis	|
   | Isabel  |
   | Miguel  |
   | Elena   |
   | Daniel  |
   | Carmen  |
   | Pablo   |
   | Lucía   |
   | Ricardo |
   | Sofía   |
   +---------+
   
   ```

   

4. **Devuelve un listado de los productos que nunca han aparecido en un**
   **pedido.**

   ```sql
   SELECT nombre
   FROM producto
   WHERE codigo NOT IN (SELECT DISTINCT codigo_producto FROM detalle_pedido);
   
   ```

   

5. **Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.**

   ```sql
   SELECT e.nombre, CONCAT(e.apellido1, ' ', e.apellido2) AS apellidos, e.puesto, t.numero
   FROM empleado e
   JOIN oficina o ON e.codigo_oficina = o.codigo
   JOIN telefono t ON o.codigo = t.codigo_oficina
   WHERE e.cedula NOT IN (
   	SELECT DISTINCT cedula_empleado
   	FROM cliente
   	WHERE puesto = 'Representante de ventas'
   );
   +--------+----------------------+---------------+-----------+
   | nombre | apellidos        	| puesto    	| numero	|
   +--------+----------------------+---------------+-----------+
   | Juan   | González Martínez	| Gerente   	| 567890123 |
   | Carlos | Rodríguez Gómez  	| Vendedor  	| 678901234 |
   | Ana	| Hernández Vidal  	| Técnico   	| 890123456 |
   | David  | Martínez Fernández   | Recepcionista | 890123456 |
   | Sara   | Gómez López      	| Analista  	| 901234567 |
   | Elena  | Vidal Hernández  	| Soporte   	| 123456789 |
   | Pedro  | Fernández González   | Reclutador	| 123456789 |
   | Rosa   | Fernández González   | Reclutador	| 123456789 |
   | Angeli | Corredor González	| Reclutador	| 123456789 |
   +--------+----------------------+---------------+-----------+
   
   ```

   

6. **Devuelve las oficinas donde no trabajan ninguno de los empleados que**
   **hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.**

   ```sql
   SELECT *
   FROM oficina
   WHERE codigo NOT IN (
   	SELECT DISTINCT codigo_oficina
   	FROM empleado
   	WHERE cedula IN (
       	SELECT DISTINCT cedula_empleado
       	FROM cliente JOIN pedido ON cliente.cedula=pedido.cedula_cliente 
   	JOIN detalle_pedido dp ON pedido.codigo=dp.codigo_pedido 
   	JOIN producto p ON p.codigo=dp.codigo_producto 
   	JOIN gama_producto gp ON p.id_gama=gp.id
       	WHERE cedula_empleado IS NOT NULL AND gp.descripcion_texto= 'Frutales'
   	)
   );
   
   +--------+---------------+--------------------+------------------+---------------+
   | codigo | codigo_postal | linea_direccion1   | linea_direccion2 | codigo_ciudad |
   +--------+---------------+--------------------+------------------+---------------+
   |  	2 | 28002     	| Fuenlabrada    	| Piso 2       	|         	1 |
   |  	3 | 75001     	| Rue Principale 1   | Étage 1      	|         	3 |
   |  	4 | 75002     	| Fuenlabrada    	| Étage 2      	|         	3 |
   |  	5 | 00100     	| Via Principale 1   | Piano 1      	|         	5 |
   |  	6 | 00101     	| Corso Secondario 2 | Piano 2      	|         	5 |
   |  	7 | 10001     	| Fuenlabrada    	| Stockwerk 1  	|         	7 |
   |  	8 | 10002     	| Nebenstraße 2  	| Stockwerk 2  	|         	7 |
   |  	9 | E1 7AD    	| High Street 1  	| Floor 1      	|         	9 |
   | 	10 | L1 1AA    	| Water Street 2 	| Floor 2      	|        	10 |
   +--------+---------------+--------------------+------------------+---------------+
   
   ```
   
   
   
7. **Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.**

   ```sql
   SELECT nombre
   FROM cliente
   WHERE cedula IN (
   	SELECT DISTINCT cedula_cliente
   	FROM pedido
   ) AND cedula NOT IN (
   	SELECT DISTINCT cedula_cliente
   	FROM pago
   );
   ```
   
   

#### Subconsultas con EXISTS y NOT EXISTS

18. **Devuelve un listado que muestre solamente los clientes que no han**
    **realizado ningún pago.**

    ```sql
    SELECT nombre
    FROM cliente c
    WHERE NOT EXISTS (
    	SELECT *
    	FROM pago p
    	WHERE p.cedula_cliente = c.cedula
    );
    ```
    
    
    
19. **Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.**

    ```sql
    SELECT nombre
    FROM cliente c
    WHERE EXISTS (
    	SELECT *
    	FROM pago p
    	WHERE p.cedula_cliente = c.cedula
    );
    
    +---------+
    | nombre  |
    +---------+
    | Luis	|
    | Isabel  |
    | Miguel  |
    | Elena   |
    | Daniel  |
    | Carmen  |
    | Pablo   |
    | Lucía   |
    | Ricardo |
    | Sofía   |
    +---------+
    
    ```

    

20. **Devuelve un listado de los productos que nunca han aparecido en un**
    **pedido.**

    ```sql
    SELECT nombre
    FROM producto p
    WHERE NOT EXISTS (
    	SELECT *
    	FROM detalle_pedido dp
    	WHERE dp.codigo_producto = p.codigo
    );
    
    ```
    
    
    
21. **Devuelve un listado de los productos que han aparecido en un pedido**
    **alguna vez.**

    ```sql
    SELECT nombre
    FROM producto p
    WHERE EXISTS (
    	SELECT *
    	FROM detalle_pedido dp
    	WHERE dp.codigo_producto = p.codigo
    );
    
    +-------------+
    | nombre  	|
    +-------------+
    | Producto 1  |
    | Producto 2  |
    | Producto 3  |
    | Producto 4  |
    | Producto 5  |
    | Producto 6  |
    | Producto 7  |
    | Producto 8  |
    | Producto 9  |
    | Producto 10 |
    +-------------+
    
    ```
    
    



#### Consultas variadas

1. **Devuelve el listado de clientes indicando el nombre del cliente y cuántos**
   **pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.**

   ```sql
   SELECT c.nombre AS nombre_cliente, COUNT(p.codigo) AS total_pedidos
   FROM cliente c
   LEFT JOIN pedido p ON c.cedula = p.cedula_cliente
   GROUP BY c.nombre;
   +----------------+---------------+
   | nombre_cliente | total_pedidos |
   +----------------+---------------+
   | Luis       	|         	1 |
   | Isabel     	|         	1 |
   | Miguel     	|         	1 |
   | Elena      	|         	1 |
   | Daniel     	|         	1 |
   | Carmen     	|         	1 |
   | Pablo      	|         	1 |
   | Lucía      	|         	1 |
   | Ricardo    	|         	1 |
   | Sofía      	|         	1 |
   +----------------+---------------+
   
   ```
   
   
   
2. **Devuelve un listado con los nombres de los clientes y el total pagado por**
   **cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han realizado ningún pago.**

   ```sql
   SELECT c.nombre AS nombre_cliente, COALESCE(SUM(pa.total), 0) AS total_pagado
   FROM cliente c
   LEFT JOIN pago pa ON c.cedula = pa.cedula_cliente
   GROUP BY c.nombre;
   +----------------+--------------+
   | nombre_cliente | total_pagado |
   +----------------+--------------+
   | Luis       	|   	200.00 |
   | Isabel     	|   	300.00 |
   | Miguel     	|   	400.00 |
   | Elena      	|   	500.00 |
   | Daniel     	|   	600.00 |
   | Carmen     	|   	700.00 |
   | Pablo      	|   	800.00 |
   | Lucía      	|   	900.00 |
   | Ricardo    	|  	1000.00 |
   | Sofía      	|  	1100.00 |
   +----------------+--------------+
   
   ```
   
   
   
3. **Devuelve el nombre de los clientes que hayan hecho pedidos en 2008**
   **ordenados alfabéticamente de menor a mayor.**

   ```sql
   SELECT DISTINCT c.nombre AS nombre_cliente
   FROM cliente c
   INNER JOIN pedido p ON c.cedula = p.cedula_cliente
   WHERE YEAR(p.fecha_pedido) = 2008
   ORDER BY c.nombre;
   
   ```
   
   
   
4. **Devuelve el nombre del cliente, el nombre y primer apellido de su**
   **representante de ventas y el número de teléfono de la oficina del**
   **representante de ventas, de aquellos clientes que no hayan realizado ningún pago.**

   ```sql
   SELECT c.nombre AS nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante, t.numero AS telefono_oficina
   FROM cliente c
   LEFT JOIN empleado e ON c.cedula_empleado = e.cedula
   LEFT JOIN telefono t ON e.codigo_oficina = t.codigo_oficina
   LEFT JOIN pago p ON c.cedula = p.cedula_cliente
   WHERE p.id IS NULL;
   
   ```
   
   
   
5. **Devuelve el listado de clientes donde aparezca el nombre del cliente, el**
   **nombre y primer apellido de su representante de ventas y la ciudad donde está su oficina.**

   ```sql
   SELECT c.nombre AS nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante, ci.nombre AS ciudad_oficina
   FROM cliente c
   LEFT JOIN empleado e ON c.cedula_empleado = e.cedula
   LEFT JOIN oficina o ON e.codigo_oficina = o.codigo
   LEFT JOIN ciudad ci ON o.codigo_ciudad = ci.codigo;
   
   
   +----------------+----------------------+------------------------+----------------+
   | nombre_cliente | nombre_representante | apellido_representante | ciudad_oficina |
   +----------------+----------------------+------------------------+----------------+
   | Luis       	| Juan             	| González           	| Madrid     	|
   | Isabel     	| María            	| López              	| Madrid     	|
   | Miguel     	| Carlos           	| Rodríguez          	| Madrid     	|
   | Elena      	| Laura            	| Pérez              	| Madrid     	|
   | Daniel     	| Ana              	| Hernández          	| París      	|
   | Carmen     	| David            	| Martínez           	| París      	|
   | Pablo      	| Sara             	| Gómez              	| París      	|
   | Lucía      	| Javier           	| Díaz               	| París      	|
   | Ricardo    	| Elena            	| Vidal              	| Roma       	|
   | Sofía      	| Pedro            	| Fernández          	| Roma       	|
   +----------------+----------------------+------------------------+----------------+
   
   ```
   
   
   
6. **Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.**

   ```sql
   SELECT e.nombre, e.apellido1, e.apellido2, e.puesto, t.numero AS telefono_oficina
   FROM empleado e
   LEFT JOIN telefono t ON e.codigo_oficina = t.codigo_oficina
   WHERE e.cedula NOT IN (SELECT DISTINCT cedula_empleado FROM cliente);
   ```

   

7. **Devuelve un listado indicando todas las ciudades donde hay oficinas y el**
   **número de empleados que tiene.**

   ```sql
   SELECT ci.nombre AS nombre_ciudad, COUNT(e.cedula) AS numero_empleados
   FROM ciudad ci
   LEFT JOIN oficina o ON ci.codigo = o.codigo_ciudad
   LEFT JOIN empleado e ON o.codigo = e.codigo_oficina
   GROUP BY ci.nombre;
   +---------------+------------------+
   | nombre_ciudad | numero_empleados |
   +---------------+------------------+
   | Madrid    	|            	4 |
   | Barcelona 	|            	0 |
   | París     	|            	4 |
   | Marsella  	|            	0 |
   | Roma      	|            	4 |
   | Milán     	|            	0 |
   | Berlín    	|            	0 |
   | Hamburgo  	|            	0 |
   | Londres   	|            	0 |
   | Liverpool 	|            	0 |
   +---------------+------------------+
   
   ```
   
   