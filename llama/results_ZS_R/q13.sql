SELECT 
    COUNT(DISTINCT CASE WHEN o_orderkey IS NULL THEN c_custkey END) AS no_orders,
    COUNT(DISTINCT CASE WHEN num_orders = 1 THEN c_custkey END) AS one_order,
    COUNT(DISTINCT CASE WHEN num_orders = 2 THEN c_custkey END) AS two_orders,
    COUNT(DISTINCT CASE WHEN num_orders = 3 THEN c_custkey END) AS three_orders,
    COUNT(DISTINCT CASE WHEN num_orders = 4 THEN c_custkey END) AS four_orders
FROM 
    customer 
    LEFT JOIN 
    (
        SELECT 
            o_custkey, 
            COUNT(o_orderkey) AS num_orders
        FROM 
            orders
        WHERE 
            o_comment NOT LIKE '%unusual%accounts%'
        GROUP BY 
            o_custkey
    ) AS orders_count
    ON customer.c_custkey = orders_count.o_custkey;