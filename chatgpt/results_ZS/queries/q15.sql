SELECT
s.s_suppkey,
s.s_name,
s.s_address,
s.s_phone,
SUM(l.l_extendedprice * (1 - l.l_discount)) AS total_revenue
FROM
supplier s
JOIN lineitem l ON s.s_suppkey = l.l_suppkey
WHERE
l.l_shipdate >= DATE '1997-01-01'
AND l.l_shipdate < DATE '1997-04-01'
GROUP BY
s.s_suppkey,
s.s_name,
s.s_address,
s.s_phone
HAVING
SUM(l.l_extendedprice * (1 - l.l_discount)) = (
SELECT
MAX(supplier_revenue)
FROM (
SELECT
SUM(l2.l_extendedprice * (1 - l2.l_discount)) AS supplier_revenue
FROM
supplier s2
JOIN lineitem l2 ON s2.s_suppkey = l2.l_suppkey
WHERE
l2.l_shipdate >= DATE '1997-01-01'
AND l2.l_shipdate < DATE '1997-04-01'
GROUP BY
s2.s_suppkey
) AS revenues
)
ORDER BY
s.s_suppkey;
