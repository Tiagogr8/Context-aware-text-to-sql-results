SELECT 
    l.l_suppkey, 
    s.s_name, 
    l.l_orderkey, 
    o.o_orderdate, 
    l.l_commitdate
FROM 
    lineitem l
JOIN 
    orders o ON l.l_orderkey = o.o_orderkey
JOIN 
    supplier s ON l.l_suppkey = s.s_suppkey
JOIN 
    nation n ON s.s_nationkey = n.n_nationkey
WHERE 
    n.n_name = 'ETHIOPIA'
    AND o.o_orderstatus = 'F'
    AND l.l_receiptdate > l.l_commitdate
    AND l.l_orderkey IN (
        SELECT 
            l1.l_orderkey
        FROM 
            lineitem l1
        GROUP BY 
            l1.l_orderkey
        HAVING 
            COUNT(DISTINCT l1.l_suppkey) > 1
    )
LIMIT 100;