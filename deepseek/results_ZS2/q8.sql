WITH nation_suppliers AS (
  SELECT s_suppkey
  FROM supplier
  JOIN nation ON s_nationkey = n_nationkey
  WHERE n_name = 'KENYA'
),
region_filter AS (
  SELECT r_regionkey
  FROM region
  WHERE r_name = 'AFRICA'
),
year_1995 AS (
  SELECT 
    SUM(l_extendedprice * (1 - l_discount)) AS total_revenue
  FROM lineitem
  JOIN part ON l_partkey = p_partkey
  JOIN partsupp ON l_partkey = ps_partkey AND l_suppkey = ps_suppkey
  JOIN nation ON s_nationkey = n_nationkey
  JOIN region ON n_regionkey = r_regionkey
  WHERE p_type = 'ECONOMY PLATED BRASS'
    AND EXTRACT(YEAR FROM l_shipdate) = 1995
    AND s_suppkey IN (SELECT s_suppkey FROM nation_suppliers)
    AND r_regionkey IN (SELECT r_regionkey FROM region_filter)
),
year_1996 AS (
  SELECT 
    SUM(l_extendedprice * (1 - l_discount)) AS total_revenue
  FROM lineitem
  JOIN part ON l_partkey = p_partkey
  JOIN partsupp ON l_partkey = ps_partkey AND l_suppkey = ps_suppkey
  JOIN nation ON s_nationkey = n_nationkey
  JOIN region ON n_regionkey = r_regionkey
  WHERE p_type = 'ECONOMY PLATED BRASS'
    AND EXTRACT(YEAR FROM l_shipdate) = 1996
    AND s_suppkey IN (SELECT s_suppkey FROM nation_suppliers)
    AND r_regionkey IN (SELECT r_regionkey FROM region_filter)
)
SELECT 
  (SELECT total_revenue FROM year_1995) AS revenue_1995,
  (SELECT total_revenue FROM year_1996) AS revenue_1996;