WITH average_quantity AS (
  SELECT AVG(l.l_quantity) AS avg_quantity
  FROM lineitem l
  JOIN part p ON l.l_partkey = p.p_partkey
  WHERE p.p_brand = 'Brand#23' AND p.p_container = 'SM CAN'
),
small_quantity_orders AS (
  SELECT l.l_quantity, l.l_extendedprice
  FROM lineitem l
  JOIN part p ON l.l_partkey = p.p_partkey
  WHERE p.p_brand = 'Brand#23' AND p.p_container = 'SM CAN'
  AND l.l_quantity < (SELECT avg_quantity * 0.2 FROM average_quantity)
),
yearly_revenue_loss AS (
  SELECT EXTRACT(YEAR FROM l_shipdate) AS year, SUM(l.l_extendedprice) AS revenue_loss
  FROM lineitem l
  JOIN part p ON l.l_partkey = p.p_partkey
  WHERE p.p_brand = 'Brand#23' AND p.p_container = 'SM CAN'
  AND l.l_quantity < (SELECT avg_quantity * 0.2 FROM average_quantity)
  GROUP BY EXTRACT(YEAR FROM l_shipdate)
)
SELECT AVG(revenue_loss) AS average_yearly_revenue_loss
FROM yearly_revenue_loss;