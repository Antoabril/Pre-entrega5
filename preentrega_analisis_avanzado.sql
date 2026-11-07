--Ejercicio 1:
--Utilizando las tablas de ventas, productos y categorías (o el dataset que has venido trabajando en el módulo 4):
--Define una CTE llamada ventas_mensuales que extraiga el año/mes, el nombre de la categoría y sume el total de ventas.

with ventas_mensuales AS (
    select 
    --transformo formato de fecha
    to_char(v.fecha,'YYYY-MM') AS fecha,
    nombre_categoria,
    SUM(cantidad) as total_ventas
    FROM ventas v
    inner join categorias c on v.categoria_id= c.categoria_id
    GROUP BY fecha, nombre_categoria
)
SELECT * 
FROM ventas_mensuales;

--En este caso se agrupan las ventas por fecha de ocurrencia, según categoria y cantidad de unidades.
--De esta forma podriamos saber que categoria es la menos vendida en un momento especifico del año y lanzar ofertas,
--o tambien, se podria ajustar el stock de forma premeditada para no tener sobrestock del que menos se vende
--o falta de stock del mas vendido.




--Ejercicio 2:
--Crea una segunda CTE llamada metricas_ventana que tome los datos de la anterior y calcule:
--El ranking de las categorías más vendidas por cada mes.
--El total acumulado (Running Total) de ventas por categoría a través del tiempo.
--En la consulta final (SELECT principal), utiliza un CASE WHEN para comparar la venta mensual contra el promedio de ventas 
--de esa misma categoría e indicar si fue un mes "Exitoso" o "Bajo el promedio".

with ventas_mensuales AS (
    select 
    to_char(v.fecha,'YYYY-MM') AS fecha_v,
    nombre_categoria,
    SUM(cantidad) as total_ventas
    FROM ventas v
    inner join categorias c on v.categoria_id= c.categoria_id
    GROUP BY fecha_v, nombre_categoria
),
metricas_ventana as (
select
fecha_v,
nombre_categoria,
total_ventas,
--ranking de categorias dentro de cada mes
dense_rank() over(
	partition by fecha_v
	order by total_ventas desc) 
	as ranking,
--acumulado por categoria a traves del tiempo
sum(total_ventas) over(
	partition by nombre_categoria
	order by fecha_v )
	as total_venta_acumulado,
--promedio mensual de esa categoria
avg(total_ventas) over(
	partition by nombre_categoria)
	as prom_cat
from ventas_mensuales 
)

select 
fecha_v,
nombre_Categoria,
total_ventas,
ranking,
total_venta_acumulado,
ROUND(prom_cat, 2) AS prom_cat,
	case
		when total_ventas>prom_cat then 'EXITOSO'
		else 'BAJO EL PROMEDIO'
	end as Desempeno_del_mes
from metricas_ventana
order by ranking;
	


