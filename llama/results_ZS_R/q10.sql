SELECT 
  c.c_name, 
  c.c_address, 
  n.n_name, 
  c.c_phone, 
  c.c_acctbal, 
  c.c_comment, 
  SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue_lost
FROM 
  customer c
  JOIN nation n ON c.c_nationkey = n.n_nationkey
  JOIN orders o ON c.c_custkey = o.o_custkey
  JOIN lineitem l ON o.o_orderkey = l.l_orderkey
WHERE 
  l.l_returnflag = 'R' 
  AND l.l_shipdate >= '1993-08-01' 
  AND l.l_shipdate < '1993-09-01'
GROUP BY 
  c.c_name, 
  c.c_address, 
  n.n_name, 
  c.c_phone, 
  c.c_acctbal, 
  c.c_comment
ORDER BY 
  revenue_lost DESC
LIMIT 20;