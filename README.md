# Requerimientos Base de Datos

**Integrantes:**
- Jose Daniel Carvajal Montañez
- Juan Manuel Gil Quiroga

**Link del diagrama relacional:** *(se mueve apretando tecla espacio y arrastrando con el cursor)*
[https://dbdiagram.io/d/inventario-69f4e6a0c6a36f9c1bdbda63](https://dbdiagram.io/d/inventario-69f4e6a0c6a36f9c1bdbda63)

---

> **Nota:** La lógica de actualizar promedios y cantidades al hacer operaciones se haría desde Java o con triggers en SQL.

---

## 1. Gestión Básica

El sistema debe permitir registrar:

- Unidades de medida
- Productos
- Materiales
- Clientes
- Proveedores

Todos los registros deben tener identificadores únicos y datos obligatorios válidos.

---

## 2. Compras de Materiales

El sistema debe permitir crear órdenes de compra con materiales, cantidades y costos.

---

## 3. Inventario de Materiales (Valoración por Promedio)

El sistema debe:

- Mantener existencias por material.
- Calcular el costo promedio con cada entrada *(se puede hacer esta lógica desde Java o con un trigger en SQL)*:

$$\text{Costo Promedio} = \frac{(\text{stock anterior} \times \text{costo anterior}) + (\text{cantidad comprada} \times \text{costo unitario compra})}{\text{stock anterior} + \text{cantidad comprada}}$$

- Las nuevas órdenes de producción usarán el precio promedio nuevo.

---

## 4. Producción

El sistema debe permitir crear órdenes de producción con:

- Producto
- Cliente
- Estado

Y debe registrar:

- Consumo de materiales (salidas de inventario)
- Unidades producidas

---

## 5. Receta

El sistema debe definir qué materiales y cantidades requiere cada producto.

Esta receta debe usarse como base para el consumo en producción.

---

## 6. Mano de Obra Directa

El sistema debe registrar:

- Operario
- Horas trabajadas
- Tarifa por hora

Debe calcular el **costo total de mano de obra** por orden.

---

## 7. Costo de Producción

El sistema debe calcular el costo total de cada orden:

$$\text{Costo Total} = \text{valor total materiales} + \text{valor total mano de obra}$$

Y el costo unitario:

$$\text{Costo Unitario} = \frac{\text{Costo Total}}{\text{unidades producidas}}$$

---

## 8. Inventario de Productos Terminados

El sistema debe:

- Mantener existencias por producto.
- Actualizar el costo promedio al ingresar producción terminada.
