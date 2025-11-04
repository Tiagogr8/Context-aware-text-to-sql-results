SELECT s.s_name, s.s_address
FROM supplier AS s
WHERE s.s_nationkey = (
  SELECT n.n_nationkey
  FROM nation AS n
  WHERE n.n_name = 'SAUDI ARABIA'
)
AND s.s_suppkey IN (
  SELECT ps.ps_suppkey
  FROM partsupp AS ps
  JOIN part AS p ON ps.ps_partkey = p.p_partkey
  WHERE p.p_name LIKE 'brown%'
  AND ps.ps_availqty > (
    SELECT AVG(ps1.ps_availqty)
    FROM partsupp AS ps1
    JOIN part AS p1 ON ps1.ps_partkey = p1.p_partkey
    JOIN lineitem AS l ON ps1.ps_partkey = l.l_partkey
    WHERE l.l_shipdate >= '1994-01-01'
    AND l.l_shipdate < '1995-01-01'
    AND p1.p_name LIKE 'brown%'
    AND ps1.ps_suppkey = ps.ps_suppkey
  ) * 1.5
)