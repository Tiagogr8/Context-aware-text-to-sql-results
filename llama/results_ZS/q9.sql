SELECT 
  n.n_name, 
  EXTRACT(YEAR FROM l.l_shipdate) AS l_year, 
  SUM((l.l_extendedprice * (1 - l.l_discount)) - (ps.ps_supplycost * l.l_quantity)) AS profit
FROM 
  lineitem l
  JOIN part p ON l.l_partkey = p.p_partkey
  JOIN partsupp ps ON l.l_partkey = ps.ps_partkey AND l.l_suppkey = ps.ps_suppkey
  JOIN supplier s ON l.l_suppkey = s.s_suppkey
  JOIN nation n ON s.s_nationkey = n.n_nationkey
WHERE 
  p.p_name LIKE '%red%'
GROUP BY 
  n.n_name, 
  EXTRACT(YEAR FROM l.l_shipdate)
ORDER BY 
  n.n_name, 
  l_year DESC;