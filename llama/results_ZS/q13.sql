SELECT 
    COUNT(o_orderkey) AS num_orders, 
    COUNT(DISTINCT c_custkey) AS num_customers
FROM 
    customer 
LEFT JOIN 
    orders ON c_custkey = o_custkey 
    AND o_comment NOT LIKE '%unusual%accounts%'
GROUP BY 
    COUNT(o_orderkey)
ORDER BY 
    num_orders;