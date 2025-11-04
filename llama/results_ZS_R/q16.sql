SELECT 
  p_brand, 
  p_type, 
  p_size, 
  COUNT(DISTINCT ps_suppkey) AS num_suppliers
FROM 
  part, 
  partsupp
WHERE 
  p_partkey = ps_partkey 
  AND p_brand != 'Brand#42' 
  AND p_type NOT LIKE 'LARGE PLATED%' 
  AND p_size IN (9, 7, 14, 41, 43, 38, 23, 34)
GROUP BY 
  p_brand, 
  p_type, 
  p_size
ORDER BY 
  num_suppliers DESC, 
  p_brand ASC, 
  p_type ASC, 
  p_size ASC;