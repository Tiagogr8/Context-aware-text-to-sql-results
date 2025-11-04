WITH ranked_suppliers AS (
  SELECT 
    s.s_acctbal,
    s.s_name,
    n.n_name,
    p.p_partkey,
    p.p_mfgr,
    s.s_address,
    s.s_phone,
    s.s_comment,
    ps.ps_supplycost,
    ROW_NUMBER() OVER (PARTITION BY p.p_partkey ORDER BY ps.ps_supplycost, s.s_acctbal DESC) AS row_num
  FROM 
    supplier s
  JOIN 
    nation n ON s.s_nationkey = n.n_nationkey
  JOIN 
    region r ON n.n_regionkey = r.r_regionkey
  JOIN 
    partsupp ps ON s.s_suppkey = ps.ps_suppkey
  JOIN 
    part p ON ps.ps_partkey = p.p_partkey
  WHERE 
    r.r_name = 'ASIA'
    AND p.p_size = 2
    AND p.p_type LIKE '%TIN'
)
SELECT 
  s_acctbal,
  s_name,
  n_name,
  p_partkey,
  p_mfgr,
  s_address,
  s_phone,
  s_comment,
  ps_supplycost
FROM 
  ranked_suppliers
WHERE 
  row_num <= 100;