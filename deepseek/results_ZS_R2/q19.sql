WITH revenue_per_part AS (
  SELECT 
    l.l_partkey, 
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS discounted_revenue
  FROM 
    lineitem l
    JOIN part p ON l.l_partkey = p.p_partkey
    JOIN supplier s ON l.l_suppkey = s.s_suppkey
    JOIN nation n ON s.s_nationkey = n.n_nationkey
  WHERE 
    l.l_shipmode = 'AIR' -- shipped by air
    AND l.l_shipinstruct = 'DELIVER IN PERSON' -- delivered in person
    AND p.p_brand IN ('Brand#11', 'Brand#25', 'Brand#54')
    AND p.p_size IN (4, 16, 29) -- sizes corresponding to QUANTITY1, QUANTITY2, QUANTITY3
    AND p.p_container IN ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG') -- example containers, adjust as needed
  GROUP BY 
    l.l_partkey
)
SELECT 
  SUM(discounted_revenue) AS total_gross_discounted_revenue
FROM 
  revenue_per_part;<｜begin▁of▁sentence｜>