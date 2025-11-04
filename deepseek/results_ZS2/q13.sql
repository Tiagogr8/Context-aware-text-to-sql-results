WITH order_counts AS (
    SELECT c.c_custkey, COUNT(o.o_orderkey) AS order_count
    FROM customer c
    LEFT JOIN orders o ON c.c_custkey = o.o_custkey
    WHERE o.o_orderkey IS NULL 
       OR o.o_orderkey NOT IN (
           SELECT o2.o_orderkey 
           FROM orders o2 
           WHERE o2.o_comment LIKE '%unusual%accounts%'
       )
    GROUP BY c.c_custkey
)
SELECT order_count, COUNT(*) AS num_customers
FROM order_counts
GROUP BY order_count
ORDER BY order_count;