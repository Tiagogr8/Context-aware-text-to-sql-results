WITH customer_nation AS (
    SELECT
        n.n_nationkey AS nation_key,
        n.n_name AS nation_name
    FROM nation n
    WHERE n.n_name IN ('ARGENTINA', 'KENYA')
),
supplier_nation AS (
    SELECT
        s.s_suppkey,
        n.n_nationkey AS supplier_nation_key,
        n.n_name AS supplier_nation_name
    FROM supplier s
    JOIN nation n ON s.s_nationkey = n.n_nationkey
),
customer_nation AS (
    SELECT
        c.c_custkey,
        n.n_nationkey AS customer_nation_key,
        n.n_name AS customer_nation_name
    FROM customer c
    JOIN nation n ON c.c_nationkey = n.n_nationkey
)
SELECT
    sup.supplier_nation_name,
    cust.customer_nation_name,
    EXTRACT(YEAR FROM l.l_shipdate) AS year,
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue
FROM
    lineitem l
    JOIN orders o ON l.l_orderkey = o.o_orderkey
    JOIN customer_nation cust ON o.o_custkey = cust.c_custkey
    JOIN supplier_nation sup ON l.l_suppkey = sup.s_suppkey
    JOIN partsupp ps ON l.l_partkey = ps.ps_partkey AND l.l_suppkey = ps.ps_suppkey
WHERE
    (cust.customer_nation_name = 'ARGENTINA' AND sup.supplier_nation_name = 'KENYA')
    OR (cust.customer_nation_name = 'KENYA' AND sup.supplier_nation_name = 'ARGENTINA')
    AND l.l_shipdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
GROUP BY
    sup.supplier_nation_name,
    cust.customer_nation_name,
    EXTRACT(YEAR FROM l.l_shipdate)
ORDER BY
    sup.supplier_nation_name,
    cust.customer_nation_name,
    year;