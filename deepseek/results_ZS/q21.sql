SELECT s_name
FROM supplier
JOIN nation ON s_nationkey = n_nationkey
JOIN partsupp ON s_suppkey = ps_suppkey
JOIN lineitem ON l_partkey = ps_partkey AND l_suppkey = ps_suppkey
JOIN orders ON l_orderkey = o_orderkey
WHERE n_name = 'ETHIOPIA'
  AND o_orderstatus = 'F'
  AND l_shipdate > l_commitdate
  AND l_returnflag = 'R'
GROUP BY s_name
LIMIT 100;