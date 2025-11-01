SELECT 
    l_orderkey, 
    o_orderpriority, 
    SUM(l_extendedprice * (1 - l_discount)) AS revenue
FROM 
    orders o
JOIN 
    lineitem l ON o.o_orderkey = l.l_orderkey
WHERE 
    o.o_orderdate >= '1995-03-01'
    AND o.o_orderdate < '1995-04-01'
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
    l_orderkey, 
    o_orderpriority
ORDER BY 
    revenue DESC
LIMIT 10;