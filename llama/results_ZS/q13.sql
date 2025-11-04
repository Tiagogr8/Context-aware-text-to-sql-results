SELECT 
    num_orders,
    COUNT(*) AS num_customers
FROM 
(
    SELECT 
        c.c_custkey,
        COUNT(o.o_orderkey) AS num_orders
    FROM 
        customer c
    LEFT JOIN 
        orders o ON c.c_custkey = o.o_custkey
    WHERE 
        o.o_comment NOT LIKE '%unusual accounts%' OR o.o_comment IS NULL
    GROUP BY 
        c.c_custkey
) AS subquery
GROUP BY 
    num_orders
ORDER BY 
    num_orders;