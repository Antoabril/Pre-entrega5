Pre-entrega5: 
Script de análisis avanzado con Window Functions
Qué construir / entregar
Debes entregar la URL de un repositorio público de GitHub o GitLab que contenga el script preentrega_analisis_avanzado.sql. El script resuelve un escenario de análisis de ventas con una consulta avanzada estructurada en CTEs, y debe generar un reporte con estas cinco columnas:

Identificadores: Mes de la venta y Categoría del producto.
Métrica Base: Venta total del mes/categoría.
Ranking: Posición de la categoría en ese mes basada en ventas (usando RANK o DENSE_RANK).
Acumulado (Running Total): Ventas acumuladas de la categoría a lo largo de los meses.
Comparativa: Un mensaje condicional (usando CASE WHEN) que compare la venta del mes contra el promedio histórico de esa categoría y devuelva exactamente Exitoso o Bajo el promedio.
