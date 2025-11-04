WITH order_counts AS (
    SELECT 
        c.c_custkey,
        COUNT(DISTINCT o.o_orderkey) AS num_orders
    FROM 
        customer c
    LEFT JOIN 
        orders o ON c.c_custkey = o.o_custkey
    WHERE 
        o.o_orderkey IS NULL 
        OR NOT EXISTS (
            SELECT 1 
            FROM lineitem 
            WHERE l_orderkey = o.o_orderkey 
            AND l_comment LIKE '%unusual accounts%'
        )
    GROUP BY 
        c.c_custkey
)
SELECT 
    CASE 
        WHEN num_orders = 0 THEN '0'
        ELSE CAST(num_orders AS VARCHAR)
    END AS order_count,
    COUNT(*) AS customer_count
FROM 
    order_counts
GROUP BY 
    num_orders
ORDER BY 
    num_orders<｜begin▁of▁sentence｜>