SELECT s.s_acctbal,
s.s_name,
n.n_name,
p.p_partkey,
p.p_mfgr,
s.s_address,
s.s_phone,
s.s_comment
FROM part p
JOIN partsupp ps ON p.p_partkey = ps.ps_partkey
JOIN supplier s ON s.s_suppkey = ps.ps_suppkey
JOIN nation n ON s.s_nationkey = n.n_nationkey
JOIN region r ON n.n_regionkey = r.r_regionkey
WHERE r.r_name = 'ASIA'
AND p.p_size = 2
AND p.p_type LIKE '%TIN'
AND ps.ps_supplycost = (
SELECT MIN(ps2.ps_supplycost)
FROM partsupp ps2
JOIN supplier s2 ON ps2.ps_suppkey = s2.s_suppkey
JOIN nation n2 ON s2.s_nationkey = n2.n_nationkey
JOIN region r2 ON n2.n_regionkey = r2.r_regionkey
WHERE ps2.ps_partkey = p.p_partkey
AND r2.r_name = 'ASIA'
)
ORDER BY s.s_acctbal DESC, n.n_name, s.s_name
LIMIT 100;
