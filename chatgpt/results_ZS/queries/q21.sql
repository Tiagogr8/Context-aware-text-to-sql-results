SELECT
s_name,
s_address,
n_name AS nation,
o_orderkey
FROM
supplier s
JOIN nation n ON s.s_nationkey = n.n_nationkey
JOIN lineitem l ON s.s_suppkey = l.l_suppkey
JOIN orders o ON l.l_orderkey = o.o_orderkey
WHERE
n.n_name = 'ETHIOPIA'
AND o.o_orderstatus = 'F'
AND l.l_receiptdate > l.l_commitdate
AND EXISTS (
SELECT 1
FROM lineitem l2
WHERE l2.l_orderkey = l.l_orderkey
AND l2.l_suppkey <> l.l_suppkey
)
AND NOT EXISTS (
SELECT 1
FROM lineitem l3
WHERE l3.l_orderkey = l.l_orderkey
AND l3.l_suppkey <> l.l_suppkey
AND l3.l_receiptdate > l3.l_commitdate
)
LIMIT 100;
