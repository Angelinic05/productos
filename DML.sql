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


INSERT INTO tipo_telefono (descripcion) VALUES
('Móvil'),
('Fijo'),
('Fax'),
('Satélite'),
('IP');

INSERT INTO tipo_pago (descripcion) VALUES
('PayPal'),
('Transferencia'),
('Tarjeta de Crédito'),
('Cheque'),
('Efectivo');


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


INSERT INTO contacto (nombre, apellido, email, cedula_cliente, nit_proveedor) VALUES
('Juan', 'Pérez', 'juan.perez@example.com', 1, NULL),
('María', 'López', 'maria.lopez@example.com', 2, NULL),
('Pedro', 'Gómez', 'pedro.gomez@example.com', NULL, '123456789'),
('Ana', 'Martínez', 'ana.martinez@example.com', NULL, '987654321');


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

INSERT INTO cliente (cedula, nombre, linea_direccion1, linea_direccion2, codigo_postal, limite_credito, cedula_empleado, codigo_ciudad) VALUES
(11, 'Julia', 'Calle Principal 3', 'Piso 3', '28003', 700.00, 4, 1),
(12, 'Antonio', 'Avenida Central 4', 'Piso 4', '28004', 1200.00, 5, 1);

INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, cedula_cliente, comentarios) VALUES
('2024-04-11', '2024-04-25', NULL, 'Pendiente', 11, 'Pedido en proceso'),
('2024-04-12', '2024-04-26', NULL, 'Pendiente', 12, 'Pedido en proceso');

INSERT INTO detalle_pedido (cantidad, precio_unidad, codigo_producto, codigo_pedido) VALUES
(5, 20.50, 11, 21),
(10, 30.75, 12, 22);

INSERT INTO pago (total, fecha, cedula_cliente, id_tipo_pago) VALUES
(200.00, '2024-04-13', 11, 1),
(300.00, '2024-04-14', 12, 2);

INSERT INTO empleado (cedula, nombre, apellido1, apellido2, extension, puesto, codigo_oficina, jefe, email) VALUES
(13, 'Alberto', 'Soria', 'González', '123', 'Gerente', 1, NULL, 'alberto.soria@example.com'),
(14, 'Sandra', 'Martínez', 'López', '456', 'representante de ventas', 1, 13, 'sandra.martinez@example.com');

INSERT INTO cliente (cedula, nombre, linea_direccion1, linea_direccion2, codigo_postal, limite_credito, cedula_empleado, codigo_ciudad) VALUES
(13, 'Roberto', 'Calle Principal 4', 'Piso 4', '28004', 700.00, 13, 1);


INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, cedula_cliente, comentarios) VALUES
('2024-04-15', '2024-04-29', NULL, 'Pendiente', 13, 'Pedido en proceso');


INSERT INTO detalle_pedido (cantidad, precio_unidad, codigo_producto, codigo_pedido) VALUES
(5, 20.50, 11, 23);


INSERT INTO pago (total, fecha, cedula_cliente, id_tipo_pago) VALUES
(400.00, '2024-04-16', 13, 3);
INSERT INTO empleado (cedula, nombre, apellido1, apellido2, email, puesto, jefe, codigo_oficina, extension)
VALUES
(101, 'Luisa', 'González', 'Pérez', 'luisa@example.com', 'Gerente', NULL, 1, '101'),
(102, 'Andrés', 'Rodríguez', 'López', 'andres@example.com', 'Vendedor', 101, 1, '102'),
(103, 'Ana', 'Martínez', 'Sánchez', 'ana@example.com', 'Vendedor', 101, 1, '103');


INSERT INTO cliente (cedula, nombre, linea_direccion1, linea_direccion2, codigo_postal, limite_credito, cedula_empleado, codigo_ciudad)
VALUES
(1001, 'Carlos', 'Calle Principal', 'Número 123', '28001', 1000.00, 101, 1),
(1002, 'Laura', 'Avenida Central', 'Piso 5', '08001', 1500.00, 102, 2),
(1003, 'Antonio', 'Plaza Mayor', 'Apartamento 3B', '28002', 800.00, 103, 1);