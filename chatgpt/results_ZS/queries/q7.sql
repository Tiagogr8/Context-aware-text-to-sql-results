SELECT
n1.n_name AS supp_nation,
n2.n_name AS cust_nation,
EXTRACT(YEAR FROM l.l_shipdate) AS l_year,
SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue
FROM
supplier s
JOIN nation n1 ON s.s_nationkey = n1.n_nationkey
JOIN partsupp ps ON s.s_suppkey = ps.ps_suppkey
JOIN part p ON ps.ps_partkey = p.p_partkey
JOIN lineitem l ON l.l_partkey = p.p_partkey AND l.l_suppkey = s.s_suppkey
JOIN orders o ON l.l_orderkey = o.o_orderkey
JOIN customer c ON o.o_custkey = c.c_custkey
JOIN nation n2 ON c.c_nationkey = n2.n_nationkey
WHERE
(
(n1.n_name = 'ARGENTINA' AND n2.n_name = 'KENYA')
OR
(n1.n_name = 'KENYA' AND n2.n_name = 'ARGENTINA')
)
AND l.l_shipdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
GROUP BY
n1.n_name,
n2.n_name,
EXTRACT(YEAR FROM l.l_shipdate)
ORDER BY
supp_nation,
cust_nation,
l_year;
