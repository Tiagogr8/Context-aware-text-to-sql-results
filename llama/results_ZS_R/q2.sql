WITH ranked_suppliers AS (
  SELECT 
    s.s_acctbal,
    s.s_name,
    n.n_name AS s_nation,
    p.p_partkey,
    p.p_mfgr,
    s.s_address,
    s.s_phone,
    s.s_comment,
    ps.ps_supplycost,
    ROW_NUMBER() OVER (PARTITION BY p.p_partkey ORDER BY ps.ps_supplycost, s.s_acctbal DESC) AS rank
  FROM 
    supplier s
  JOIN 
    nation n ON s.s_nationkey = n.n_nationkey
  JOIN 
    partsupp ps ON s.s_suppkey = ps.ps_suppkey
  JOIN 
    part p ON ps.ps_partkey = p.p_partkey
  WHERE 
    p.p_size = 2
    AND p.p_type LIKE '%TIN'
    AND n.n_regionkey IN (SELECT r_regionkey FROM region WHERE r_name = 'ASIA')
)
SELECT 
  s_acctbal,
  s_name,
  s_nation,
  p_partkey,
  p_mfgr,
  s_address,
  s_phone,
  s_comment
FROM 
  ranked_suppliers
WHERE 
  rank = 1
ORDER BY 
  ps_supplycost, s_acctbal DESC
LIMIT 100;