CREATE TABLE unidades_medida (
   id_unidad SERIAL PRIMARY KEY,
   codigo VARCHAR(10) UNIQUE NOT NULL,
   nombre VARCHAR(50) NOT NULL
);

CREATE TABLE productos (
   id_producto SERIAL PRIMARY KEY,
   codigo VARCHAR(30) UNIQUE NOT NULL,
   nombre VARCHAR(100) NOT NULL,
   cantidad NUMERIC(12,2) NOT NULL,
   costo_promedio NUMERIC(12,2) NOT NULL,
   fecha_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
   id_unidad INT REFERENCES unidades_medida(id_unidad)
);


CREATE TABLE ordenes_produccion (
   id_orden SERIAL PRIMARY KEY,
   id_producto INT NOT NULL REFERENCES productos(id_producto),
   id_estado INT NOT NULL REFERENCES estados_orden(id),


   fecha_creacion DATE NOT NULL DEFAULT CURRENT_DATE,
   fecha_inicio DATE,
   fecha_cierre DATE,


   unidades_producidas NUMERIC(12,2) DEFAULT 0
);

CREATE TABLE materiales (
   id_material SERIAL PRIMARY KEY,
   codigo VARCHAR(30) UNIQUE NOT NULL,
   nombre VARCHAR(100) NOT NULL,


   id_unidad INT REFERENCES unidades_medida(id_unidad),


   stock_actual NUMERIC(12,2) DEFAULT 0,
   costo_promedio NUMERIC(12,2) DEFAULT 0
);


CREATE TABLE entradas_materiales(
id_entrada SERIAL PRIMARY KEY,
id_material INT REFERENCES materiales(id_material),
cantidad NUMERIC(12,2),
costo_unitario NUMERIC(12,2),
fecha DATE DEFAULT CURRENT_DATE
);

CREATE TABLE orden_materiales (
   id_consumo SERIAL PRIMARY KEY,


   id_orden INT NOT NULL REFERENCES ordenes_produccion(id_orden),
   id_material INT NOT NULL REFERENCES materiales(id_material),


   cantidad NUMERIC(12,2) NOT NULL,
   costo_unitario NUMERIC(12,2) NOT NULL
);

CREATE TABLE categorias_laborales (
   id_categoria SERIAL PRIMARY KEY,
   nombre VARCHAR(50) NOT NULL,
   tarifa_hora NUMERIC(12,2) NOT NULL
);


CREATE TABLE operarios (
   id_operario SERIAL PRIMARY KEY,
   nombre VARCHAR(100) NOT NULL,
   id_categoria INT REFERENCES categorias_laborales(id_categoria)
);

CREATE TABLE orden_mano_obra (
   id_registro SERIAL PRIMARY KEY,

   id_orden INT NOT NULL REFERENCES ordenes_produccion(id_orden),
   id_operario INT NOT NULL REFERENCES operarios(id_operario),

   horas_trabajadas NUMERIC(10,2) NOT NULL,
   tarifa_hora NUMERIC(12,2) NOT NULL
);

CREATE TABLE inventario_productos (
   id_lote SERIAL PRIMARY KEY,

   id_producto INT NOT NULL UNIQUE REFERENCES productos(id_producto),

   cantidad NUMERIC(12,2) NOT NULL,
   costo_unitario NUMERIC(12,2) NOT NULL
);

