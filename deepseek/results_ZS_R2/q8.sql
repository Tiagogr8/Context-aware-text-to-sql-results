WITH nation_region AS (
    SELECT n.n_nationkey, n.n_name, r.r_regionkey, r.r_name
    FROM nation n
    JOIN region r ON n.n_regionkey = r.r_regionkey
    WHERE n.n_name = 'KENYA'
),
supplier_nation AS (
    SELECT s_suppkey
    FROM supplier
    JOIN nation_region ON supplier.s_nationkey = nation_region.n_nationkey
),
part_type AS (
    SELECT p_partkey
    FROM part
    WHERE p_type = 'ECONOMY PLATED BRASS'
),
relevant_lineitems AS (
    SELECT l.l_extendedprice, l.l_discount, l.l_shipdate
    FROM lineitem l
    JOIN orders o ON l.l_orderkey = o.o_orderkey
    JOIN supplier_nation ON l.l_suppkey = supplier_nation.s_suppkey
    JOIN part_type ON l.l_partkey = part_type.p_partkey
),
revenue_by_year AS (
    SELECT
        EXTRACT(YEAR FROM l_shipdate) AS year,
        SUM(l_extendedprice * (1 - l_discount)) AS revenue
    FROM relevant_lineitems
    GROUP BY EXTRACT(YEAR FROM l_shipdate)
)
SELECT revenue FROM revenue_by_year WHERE year IN (1995, 1996) ORDER BY year;