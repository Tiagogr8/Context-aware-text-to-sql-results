SELECT o_orderpriority, COUNT(*) AS count
FROM orders
JOIN lineitem ON o_orderkey = l_orderkey
WHERE l_receiptdate > l_commitdate
AND o_orderdate >= DATE '1997-01-01'
AND o_orderdate < DATE '1997-01-01' + INTERVAL '3 months'
GROUP BY o_orderpriority
ORDER BY o_orderpriority;