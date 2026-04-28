## REQUERIMIENTOS BASE DE DATOS

###### RF = REQUERIMIENTO FUNCIONAL

## 📋 Lista de Requerimientos

### 1. Gestión de Órdenes de Producción

- RF01 — Crear órdenes de producción con número único, fecha y producto a fabricar
- RF03 — Asociar cada orden a un producto terminado específico del catálogo
- RF04 — Registrar la fecha de inicio y fecha de cierre real de cada orden
- RF05 — Permitir consultar el historial completo de órdenes por producto o fecha

---

### 2. Materiales Directos por Orden

- RF06 — Registrar el consumo de materiales directos asociado a cada orden de producción
- RF07 — Permitir múltiples materiales directos por orden, con cantidad y unidad de medida
- RF08 — Obtener el costo de cada material directo del inventario de materiales al costo promedio vigente
- RF09 — Calcular el costo total de materiales directos por orden (cantidad × costo promedio por cada material)

---

### 3. Mano de Obra Directa por Orden

- RF10 — Registrar las horas trabajadas por operario en cada orden de producción
- RF11 — Definir la tarifa por hora de cada tipo de operario o categoría laboral
- RF12 — Calcular el costo de mano de obra directa por orden (horas × tarifa por hora)
- RF13 — Permitir múltiples operarios en una misma orden

---

### 4. Costo Total y Cierre de Orden

- RF14 — Calcular el costo total de producción por orden: Materiales Directos + Mano de Obra Directa
- RF15 — Calcular el costo unitario de producción al cerrar la orden (costo total ÷ unidades producidas)

---

### 5. Ingreso al Inventario de Producto Terminado

- RF16 — Ingresar al inventario de productos las unidades producidas de una orden de producción, actualizando la cantidad disponible del producto terminado y recalculando su costo promedio ponderado.

---

### 6. Consultas y Reportes

- RF17 — Reporte de costo por orden de producción: desglose de materiales directos y mano de obra
- RF18 — Reporte de inventario valorado: stock × costo promedio por producto (valor total en bodega)
- RF19 — Reporte de órdenes por período: órdenes abiertas, cerradas y costo acumulado

### 7. Inventario de Materiales

- RF20 - Mantener en el inventario de materiales el stock actual y su costo promedio ponderado, permitiendo su actualización cuando se registren entradas o consumos.
