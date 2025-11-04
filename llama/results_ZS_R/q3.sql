SELECT 
    l.l_orderkey, 
    o.o_orderpriority, 
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue
FROM 
    lineitem l
JOIN 
    orders o ON l.l_orderkey = o.o_orderkey
WHERE 
    o.o_orderdate >= '1995-03-01'
    AND o.o_orderdate < '1995-03-28'
    AND l.l_shipdate > '1995-03-27'
    AND o.o_totalprice > 0
    AND o.o_orderstatus = 'O'
    AND o.o_custkey IN (
        SELECT 
            c_custkey 
        FROM 
            customer 
        WHERE 
            c_mktsegment = 'FURNITURE'
    )
GROUP BY 
    l.l_orderkey, 
    o.o_orderpriority
ORDER BY 
    revenue DESC
LIMIT 10;