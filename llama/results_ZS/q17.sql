WITH avg_quantity AS (
  SELECT AVG(l.l_quantity) AS avg_qty
  FROM lineitem l
  JOIN part p ON l.l_partkey = p.p_partkey
  WHERE p.p_brand = 'Brand#23' AND p.p_container = 'SM CAN'
),
small_orders AS (
  SELECT l.l_extendedprice * l.l_quantity AS revenue
  FROM lineitem l
  JOIN part p ON l.l_partkey = p.p_partkey
  WHERE p.p_brand = 'Brand#23' AND p.p_container = 'SM CAN' AND l.l_quantity < (SELECT avg_qty * 0.2 FROM avg_quantity)
)
SELECT SUM(revenue) / 7 AS avg_yearly_loss
FROM small_orders;