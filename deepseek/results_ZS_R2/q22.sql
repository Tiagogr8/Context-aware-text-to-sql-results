SELECT 
    SUBSTRING(c_phone FROM 1 FOR 2) AS country_code, 
    COUNT(*) AS num_customers, 
    SUM(c_acctbal) AS total_balance
FROM 
    customer
WHERE 
    SUBSTRING(c_phone FROM 1 FOR 2) IN ('30', '31', '28', '21', '26', '33', '10')
    AND c_custkey NOT IN (
        SELECT o_custkey 
        FROM orders 
        WHERE o_orderdate >= CURRENT_DATE - INTERVAL '7 years'
    )
    AND c_acctbal > (
        SELECT AVG(c_acctbal) 
        FROM customer
    )
GROUP BY 
    country_code
ORDER BY 
    total_balance DESC;
```<｜begin▁of▁sentence｜>