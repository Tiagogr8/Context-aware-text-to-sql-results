SELECT
COALESCE(order_counts.num_orders, 0) AS num_orders,
COUNT(*) AS num_customers
FROM (
SELECT
c.c_custkey,
COUNT(o.o_orderkey) AS num_orders
FROM
customer c
LEFT JOIN
orders o
ON c.c_custkey = o.o_custkey
AND o.o_comment NOT LIKE '%unusual%'
AND o.o_comment NOT LIKE '%accounts%'
GROUP BY
c.c_custkey
) AS order_counts
GROUP BY
order_counts.num_orders
ORDER BY
num_orders;
