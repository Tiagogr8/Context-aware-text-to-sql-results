WITH late_orders AS (
  SELECT 
    l_shipmode,
    o_orderpriority,
    COUNT(*) as cnt
  FROM 
    lineitem
    JOIN orders ON l_orderkey = o_orderkey
  WHERE 
    l_shipmode IN ('FOB', 'MAIL')
    AND l_receiptdate > l_commitdate
    AND l_shipdate < l_commitdate
    AND l_shipdate >= DATE '1996-01-01'
    AND l_shipdate < DATE '1996-01-01' + INTERVAL '1 year'
  GROUP BY 
    l_shipmode, o_orderpriority
)
SELECT 
  l_shipmode, 
  o_orderpriority, 
  SUM(cnt) AS order_count
FROM 
  late_orders
GROUP BY 
  l_shipmode, o_orderpriority
ORDER BY 
  l_shipmode, o_orderpriority;