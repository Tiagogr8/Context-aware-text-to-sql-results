SELECT
s.s_name,
s.s_address
FROM
supplier s
JOIN nation n ON s.s_nationkey = n.n_nationkey
JOIN region r ON n.n_regionkey = r.r_regionkey
JOIN partsupp ps ON s.s_suppkey = ps.ps_suppkey
JOIN part p ON ps.ps_partkey = p.p_partkey
WHERE
n.n_name = 'SAUDI ARABIA'
AND p.p_name LIKE 'brown%'
AND ps.ps_availqty > 0.5 * (
SELECT
SUM(l.l_quantity)
FROM
lineitem l
JOIN orders o ON l.l_orderkey = o.o_orderkey
JOIN supplier s2 ON l.l_suppkey = s2.s_suppkey
JOIN nation n2 ON s2.s_nationkey = n2.n_nationkey
WHERE
l.l_partkey = ps.ps_partkey
AND s2.s_suppkey = s.s_suppkey
AND n2.n_name = 'SAUDI ARABIA'
AND EXTRACT(YEAR FROM o.o_orderdate) = 1994
)
ORDER BY
s.s_name;
