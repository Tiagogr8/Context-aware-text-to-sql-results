WITH AvgLineitemQuantity AS (
    SELECT AVG(l_quantity) AS avg_qty
    FROM lineitem
    JOIN part ON l_partkey = p_partkey
    WHERE p_brand = 'Brand#23' 
      AND p_container = 'SM CAN'
)
SELECT COALESCE(SUM(l_quantity * l_extendedprice), 0) AS annual_loss
FROM lineitem
JOIN part ON l_partkey = p_partkey
WHERE p_brand = 'Brand#23' 
  AND p_container = 'SM CAN'
  AND l_quantity < 0.2 * (SELECT avg_qty FROM AvgLineitemQuantity);