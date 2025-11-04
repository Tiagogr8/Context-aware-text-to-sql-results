SELECT s.s_name, s.s_acctbal, n.n_name, p.p_partkey, p.p_mfgr, s.s_address, s.s_phone, s.s_comment
FROM part p, supplier s, partsupp ps, nation n, region r
WHERE p.p_partkey = ps.ps_partkey
  AND ps.ps_suppkey = s.s_suppkey
  AND s.s_nationkey = n.n_nationkey
  AND n.n_regionkey = r.r_regionkey
  AND p.p_size = 2
  AND p.p_type LIKE '%TIN%'
  AND r.r_name = 'ASIA'
  AND ps.ps_supplycost = (
    SELECT MIN(ps2.ps_supplycost)
    FROM partsupp ps2
    WHERE ps2.ps_partkey = p.p_partkey
      AND ps2.ps_suppkey = s.s_suppkey
  )
ORDER BY s.s_acctbal DESC
LIMIT 100;