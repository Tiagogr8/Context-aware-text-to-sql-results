SELECT 
    l_shipmode, 
    SUM(CASE WHEN o_orderpriority = '1-URGENT' OR o_orderpriority = '2-HIGH' THEN 1 ELSE 0 END) AS high_line_count,
    SUM(CASE WHEN o_orderpriority <> '1-URGENT' AND o_orderpriority <> '2-HIGH' THEN 1 ELSE 0 END) AS low_line_count
FROM 
    lineitem, 
    orders
WHERE 
    l_orderkey = o_orderkey 
    AND l_shipmode IN ('FOB', 'MAIL') 
    AND l_receiptdate > l_commitdate 
    AND l_shipdate < l_commitdate 
    AND l_receiptdate >= '1996-01-01' 
    AND l_receiptdate < '1997-01-01'
GROUP BY 
    l_shipmode