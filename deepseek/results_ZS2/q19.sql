SELECT SUM(l_extendedprice * (1 - l_discount)) AS total_revenue
FROM lineitem
JOIN part ON l_partkey = p_partkey
WHERE l_shipmode = 'AIR' 
  AND l_shipinstruct = 'DELIVER IN PERSON'
  AND p_brand IN ('Brand#11', 'Brand#25', 'Brand#54')
  AND p_container IN ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG', 'MD CASE', 'MD BOX', 'MD PACK', 'MD PKG', 'LG CASE', 'LG BOX', 'LG PACK', 'LG PKG')
  AND p_size BETWEEN 1 AND 50
  AND l_quantity < (
    CASE 
      WHEN p_brand = 'Brand#11' THEN 4
      WHEN p_brand = 'Brand#25' THEN 16 
      WHEN p_brand = 'Brand#54' THEN 29
    END
  );