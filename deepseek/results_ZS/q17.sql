SELECT AVG(l_quantity * l_extendedprice) * 12.0
FROM lineitem
JOIN part ON l_partkey = p_partkey
JOIN supplier ON l_suppkey = s_suppkey
WHERE p_brand = 'Brand#23'
  AND p_container = 'SM CAN'
  AND l_quantity < (0.2 * (
        SELECT AVG(l_quantity)
        FROM lineitem
        JOIN part ON l_partkey = p_partkey
        JOIN supplier ON l_suppkey = s_suppkey
        WHERE p_brand = 'Brand#23'
          AND p_container = 'SM CAN'
    ));