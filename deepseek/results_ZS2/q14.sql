SELECT 100.0 * SUM(CASE WHEN l_shipdate >= DATE '1996-04-01' AND l_shipdate < DATE '1996-04-01' + INTERVAL '1 month' AND l_returnflag = 'A' THEN l_extendedprice * (1 - l_discount) ELSE 0.0 END) / NULLIF(SUM(CASE WHEN l_shipdate >= DATE '1996-04-01' AND l_shipdate < DATE '1996-04-01' + INTERval '1 month' THEN l_extendedprice * (1 - l_discount) ELSE 0.0 END), 0) AS promotion_revenue_percentage
FROM lineitem
WHERE l_shipdate >= DATE '1996-04-01'
  AND l_shipdate < DATE '1996-04-01' + INTERVAL '1 month'