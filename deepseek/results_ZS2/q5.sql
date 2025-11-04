SELECT
    n.n_name AS nation,
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue_volume
FROM
    lineitem l
    JOIN supplier s ON l.l_suppkey = s.s_suppkey
    JOIN nation n ON s.s_nationkey = n.n_nationkey
    JOIN region r ON n.n_regionkey = r.r_regionkey
    JOIN orders o ON l.l_orderkey = o.o_orderkey
    JOIN customer c ON o.o_custkey = c.c_custkey
WHERE
    r.r_name = 'EUROPE'
    AND l.l_shipdate >= DATE '1994-01-01'
    AND l.l_shipdate < DATE '1995-01-01'
    AND c.c_nationkey = n.n_nationkey
GROUP BY
    n.n_name
ORDER BY
    revenue_volume DESC;