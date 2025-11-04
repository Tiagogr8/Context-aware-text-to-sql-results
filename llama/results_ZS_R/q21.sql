SELECT 
    l.l_suppkey, 
    s.s_name, 
    l.l_orderkey, 
    o.o_orderdate, 
    o.o_totalprice
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
    AND l.l_commitdate > l.l_receiptdate
    AND l.l_suppkey IN (
        SELECT 
            l2.l_suppkey
        FROM 
            lineitem l2
        JOIN 
            orders o2 ON l2.l_orderkey = o2.o_orderkey
        WHERE 
            o2.o_orderstatus = 'F'
            AND l2.l_commitdate > l2.l_receiptdate
            AND l2.l_orderkey IN (
                SELECT 
                    l3.l_orderkey
                FROM 
                    lineitem l3
                GROUP BY 
                    l3.l_orderkey
                HAVING 
                    COUNT(DISTINCT l3.l_suppkey) > 1
            )
    )
LIMIT 100;