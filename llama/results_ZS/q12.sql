SELECT 
    l.l_shipmode,
    SUM(CASE WHEN o.o_orderpriority = '1-URGENT' OR o.o_orderpriority = '2-HIGH' THEN 1 ELSE 0 END) AS high_line_count,
    SUM(CASE WHEN o.o_orderpriority <> '1-URGENT' AND o.o_orderpriority <> '2-HIGH' THEN 1 ELSE 0 END) AS low_line_count
FROM 
    lineitem l
JOIN 
    orders o ON l.l_orderkey = o.o_orderkey
WHERE 
    l.l_receiptdate > l.l_commitdate 
    AND l.l_shipdate < l.l_commitdate 
    AND l.l_receiptdate >= '1996-01-01' 
    AND l.l_receiptdate < '1997-01-01' 
    AND l.l_shipmode IN ('FOB', 'MAIL')
GROUP BY 
    l.l_shipmode