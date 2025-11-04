WITH late_items AS (
  SELECT 
    l_shipmode, 
    o_orderpriority,
    COUNT(*) as count_late
  FROM 
    lineitem
  JOIN 
    orders ON l_orderkey = o_orderkey
  WHERE 
    l_receiptdate > l_commitdate
    AND l_shipdate < l_commitdate
    AND l_shipdate >= DATE '1996-01-01' - INTERVAL '1 year'
    AND l_shipdate < DATE '1996-01-01' + INTERVAL '1 year'
    AND (l_shipmode = 'FOB' OR l_shipmode = 'MAIL')
  GROUP BY 
    l_shipmode, o_orderpriority
)
SELECT 
  l_shipmode, 
  o_orderpriority, 
  SUM(count_late) AS total_late
FROM 
  late_items
GROUP BY 
  l_shipmode, o_orderpriority
ORDER BY 
  l_shipmode, o_orderpriority;