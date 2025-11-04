WITH filtered_orders AS (
    SELECT 
        o.*, 
        l.l_extendedprice, 
        l.l_discount
    FROM 
        orders o
    JOIN 
        lineitem l ON o.o_orderkey = l.l_orderkey
    WHERE 
        o.o_orderdate < '1995-03-27'::date
        AND l.l_shipdate > '1995-03-27'::date
        AND o.o_custkey IN (
            SELECT c_custkey 
            FROM customer 
            WHERE c_mktsegment = 'FURNITURE'
        )
)
SELECT 
    o_orderkey, 
    SUM(l_extendedprice * (1 - l_discount)) AS revenue
FROM 
    filtered_orders
GROUP BY 
    o_orderkey
ORDER BY 
    revenue DESC
LIMIT 10;<｜begin▁of▁sentence｜>