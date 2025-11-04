SELECT 
    o_orderpriority, 
    COUNT(o_orderkey) 
FROM 
    orders 
WHERE 
    o_orderdate >= '1997-01-01' 
    AND o_orderdate < '1997-04-01' 
    AND o_orderkey IN (
        SELECT 
            l_orderkey 
        FROM 
            lineitem 
        WHERE 
            l_commitdate < l_receiptdate
    )
GROUP BY 
    o_orderpriority 
ORDER BY 
    o_orderpriority;