CREATE TABLE unidades_medida (
    id_unidad SERIAL PRIMARY KEY,
    codigo VARCHAR(10) UNIQUE NOT NULL,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE productos (
    id_producto SERIAL PRIMARY KEY,
    codigo VARCHAR(30) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    id_unidad INT NOT NULL REFERENCES unidades_medida (id_unidad),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    identificacion VARCHAR(20),
    telefono VARCHAR(20),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE estados_orden (
    id_estado SERIAL PRIMARY KEY,
    nombre VARCHAR(20) UNIQUE NOT NULL
);

INSERT INTO
    estados_orden (nombre)
VALUES ('CREADA'),
    ('EN_PROCESO'),
    ('FINALIZADA'),
    ('CANCELADA');

CREATE TABLE ordenes_produccion (
    id_orden_produccion SERIAL PRIMARY KEY,
    id_producto INT NOT NULL REFERENCES productos (id_producto),
    id_estado INT NOT NULL REFERENCES estados_orden (id_estado),
    id_cliente INT NOT NULL REFERENCES clientes (id_cliente),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_inicio TIMESTAMP,
    fecha_cierre TIMESTAMP,
    unidades_producidas NUMERIC(12, 2) DEFAULT 0 CHECK (unidades_producidas >= 0)
);

CREATE TABLE materiales (
    id_material SERIAL PRIMARY KEY,
    codigo VARCHAR(30) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    id_unidad INT NOT NULL REFERENCES unidades_medida (id_unidad),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE proveedores (
    id_proveedor SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    nit VARCHAR(20) UNIQUE,
    telefono VARCHAR(20),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ordenes_compra (
    id_orden_compra SERIAL PRIMARY KEY,
    id_proveedor INT NOT NULL REFERENCES proveedores (id_proveedor),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orden_compra_detalle (
    id_detalle SERIAL PRIMARY KEY,
    id_orden_compra INT NOT NULL REFERENCES ordenes_compra (id_orden_compra) ON DELETE CASCADE,
    id_material INT NOT NULL REFERENCES materiales (id_material),
    cantidad NUMERIC(12, 2) NOT NULL CHECK (cantidad > 0),
    costo_unitario NUMERIC(12, 2) NOT NULL CHECK (costo_unitario >= 0)
);

CREATE TABLE movimientos_material (
    id_movimiento SERIAL PRIMARY KEY,
    id_material INT NOT NULL REFERENCES materiales (id_material),
    tipo VARCHAR(10) NOT NULL CHECK (tipo IN ('ENTRADA', 'SALIDA')),
    cantidad NUMERIC(12, 2) NOT NULL CHECK (cantidad > 0),
    costo_unitario NUMERIC(12, 2) CHECK (costo_unitario >= 0),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_orden_produccion INT REFERENCES ordenes_produccion (id_orden_produccion),
    id_orden_compra INT REFERENCES ordenes_compra (id_orden_compra)
);

CREATE TABLE receta_producto (
    id_receta SERIAL PRIMARY KEY,
    id_producto INT NOT NULL REFERENCES productos (id_producto),
    id_material INT NOT NULL REFERENCES materiales (id_material),
    cantidad NUMERIC(12, 2) NOT NULL CHECK (cantidad > 0),
    UNIQUE (id_producto, id_material)
);

CREATE TABLE categorias_laborales (
    id_categoria SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tarifa_hora NUMERIC(12, 2) NOT NULL CHECK (tarifa_hora > 0)
);

CREATE TABLE operarios (
    id_operario SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_categoria INT NOT NULL REFERENCES categorias_laborales (id_categoria),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orden_mano_obra (
    id_registro SERIAL PRIMARY KEY,
    id_orden_produccion INT NOT NULL REFERENCES ordenes_produccion (id_orden_produccion),
    id_operario INT NOT NULL REFERENCES operarios (id_operario),
    horas_trabajadas NUMERIC(10, 2) NOT NULL CHECK (horas_trabajadas > 0),
    tarifa_hora NUMERIC(12, 2) NOT NULL CHECK (tarifa_hora > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE inventario_productos (
    id_inventario SERIAL PRIMARY KEY,
    id_producto INT NOT NULL REFERENCES productos (id_producto),
    cantidad_existencia NUMERIC(12, 2) NOT NULL DEFAULT 0 CHECK (cantidad_existencia >= 0),
    costo_promedio NUMERIC(12, 2) NOT NULL DEFAULT 0 CHECK (costo_promedio >= 0),
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_inventario_producto UNIQUE (id_producto)
);
