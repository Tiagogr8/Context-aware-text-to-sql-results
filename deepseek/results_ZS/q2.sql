SELECT s_suppkey, s_name, s_acctbal, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment
FROM part, partsupp, supplier, nation, region
WHERE p_partkey = ps_partkey
  AND ps_suppkey = s_supkey
  AND s_nationkey = n_nationkey
  AND n_regionkey = r_regionkey
  AND r_name = 'ASIA'
  AND p_size = 2
  AND p_type LIKE '%TIN%'
  AND ps_suppkey IN (
    SELECT ps_suppkey
    FROM partsupp
    WHERE ps_partkey = p_partkey
    GROUP BY ps_suppkey
    HAVING MIN(ps_supplycost) = (
      SELECT MIN(ps_supplycost)
      FROM partsupp
      WHERE ps_partkey = p_partkey
    )
  )
ORDER BY s_acctbal DESC
LIMIT 100;