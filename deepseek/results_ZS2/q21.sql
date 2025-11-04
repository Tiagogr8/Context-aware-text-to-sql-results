SELECT s.s_name, s.s_phone, s.s_address
FROM supplier s
JOIN nation n ON s.s_nationkey = n.n_nationkey
JOIN partsupp ps ON s.s_suppkey = ps.ps_suppkey
JOIN lineitem l ON ps.ps_partkey = l.l_partkey AND ps.ps_suppkey = l.l_suppkey
JOIN orders o ON l.l_orderkey = o.o_orderkey
WHERE n.n_name = 'ETHIOPIA'
AND o.o_orderstatus = 'F'
AND l.l_shipdate > o.o_orderdate + INTERVAL '90 days'
ORDER BY s.s_name
LIMIT 100;