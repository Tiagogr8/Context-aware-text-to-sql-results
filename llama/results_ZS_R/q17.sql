WITH avg_quantity AS (
  SELECT AVG(l.l_quantity) AS avg_qty
  FROM lineitem l
  JOIN part p ON l.l_partkey = p.p_partkey
  WHERE p.p_brand = 'Brand#23' AND p.p_container = 'SM CAN'
),
small_orders AS (
  SELECT l.l_quantity, l.l_extendedprice
  FROM lineitem l
  JOIN part p ON l.l_partkey = p.p_partkey
  WHERE p.p_brand = 'Brand#23' AND p.p_container = 'SM CAN'
    AND l.l_quantity < (SELECT 0.2 * avg_qty FROM avg_quantity)
),
yearly_revenue AS (
  SELECT EXTRACT(YEAR FROM l_shipdate) AS year, SUM(l.l_extendedprice) AS revenue
  FROM lineitem l
  JOIN part p ON l.l_partkey = p.p_partkey
  WHERE p.p_brand = 'Brand#23' AND p.p_container = 'SM CAN'
    AND l.l_quantity < (SELECT 0.2 * avg_qty FROM avg_quantity)
  GROUP BY EXTRACT(YEAR FROM l_shipdate)
)
SELECT AVG(revenue) AS avg_yearly_loss
FROM yearly_revenue;