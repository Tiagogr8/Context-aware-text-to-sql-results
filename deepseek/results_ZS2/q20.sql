SELECT s_suppkey
FROM supplier
JOIN nation ON n_nationkey = s_nationkey
JOIN partsupp ON ps_suppkey = s_suppkey
JOIN part ON p_partkey = ps_partkey
WHERE n_name = 'SAUDI ARABIA'
  AND p_name LIKE 'brown%'
  AND ps_availqty > (
    SELECT 0.5 * SUM(l_quantity)
    FROM lineitem
    JOIN orders ON l_orderkey = o_orderkey
    JOIN supplier ON s_suppkey = l_suppkey
    WHERE s_nationkey = (SELECT n_nationkey FROM nation WHERE n_name = 'SAUDI ARABIA')
      AND l_shipdate >= DATE '1994-01-01'
      AND l_shipdate < DATE '1994-01-01' + INTERVAL '1 year'
      AND p_partkey = ps_partkey
  )
GROUP BY s_suppkey
HAVING COUNT(*) > 0;