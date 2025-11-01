SELECT 
  n1.n_name, 
  SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue
FROM 
  lineitem l
  JOIN orders o ON l.l_orderkey = o.o_orderkey
  JOIN customer c ON o.o_custkey = c.c_custkey
  JOIN nation n1 ON c.c_nationkey = n1.n_nationkey
  JOIN supplier s ON l.l_suppkey = s.s_suppkey
  JOIN nation n2 ON s.s_nationkey = n2.n_nationkey
  JOIN region r ON n1.n_regionkey = r.r_regionkey
WHERE 
  r.r_name = 'EUROPE' 
  AND o.o_orderdate >= '1994-01-01' 
  AND o.o_orderdate < '1995-01-01' 
  AND n1.n_nationkey = n2.n_nationkey
GROUP BY 
  n1.n_name
ORDER BY 
  revenue DESC;