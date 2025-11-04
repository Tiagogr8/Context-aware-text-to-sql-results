SELECT 
  (SUM(CASE WHEN l_shipdate >= DATE '1996-04-01' AND l_shipdate < DATE '1996-04-01' + INTERVAL '1 month' THEN l_extendedprice * (1 - l_discount) ELSE 0 END) /
  (SUM(l_extendedprice * (1 - l_discount))) * 100 AS promotion_percentage
FROM lineitem
WHERE l_shipdate >= DATE '1996-04-01' 
  AND l_shipdate < DATE '1996-04-01' + INTERVAL '1 month'<｜begin▁of▁sentence｜>