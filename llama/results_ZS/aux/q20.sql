SELECT s.s_name, s.s_address
FROM supplier AS s
JOIN partsupp AS ps ON s.s_suppkey = ps.ps_suppkey
JOIN part AS p ON ps.ps_partkey = p.p_partkey
JOIN nation AS n ON s.s_nationkey = n.n_nationkey
WHERE n.n_name = 'SAUDI ARABIA'
AND p.p_name LIKE 'brown%'
AND ps.ps_availqty > (
  SELECT AVG(ps1.ps_availqty)
  FROM partsupp AS ps1
  JOIN part AS p1 ON ps1.ps_partkey = p1.p_partkey
  WHERE p1.p_name LIKE 'brown%'
  AND ps1.ps_suppkey = ps.ps_suppkey
  AND EXTRACT(YEAR FROM l_shipdate) = 1994
)
AND ps.ps_partkey IN (
  SELECT l.l_partkey
  FROM lineitem AS l
  WHERE EXTRACT(YEAR FROM l.l_shipdate) = 1994
)
ORDER BY s.s_name;