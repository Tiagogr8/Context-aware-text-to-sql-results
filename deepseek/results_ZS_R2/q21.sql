SELECT s.s_name, s.s_suppkey
FROM supplier s
JOIN nation n ON s.s_nationkey = n.n_nationkey
JOIN partsupp ps ON s.s_suppkey = ps.ps_suppkey
JOIN lineitem l ON ps.ps_partkey = l.l_partkey AND ps.ps_suppkey = l.l_suppkey
WHERE n.n_name = 'ETHIOPIA'
AND l.l_deliverydate > l.l_commitdate
AND l.l_orderkey IN (
    SELECT l2.l_orderkey
    FROM lineitem l2
    WHERE l2.l_orderkey = l.l_orderkey
    GROUP BY l2.l_orderkey
    HAVING COUNT(DISTINCT l2.l_suppkey) > 1
)
LIMIT 100;