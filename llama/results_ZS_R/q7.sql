SELECT 
  l.l_shipdate::date::text::integer / 10000 AS l_year,
  sn.n_name AS sup_nation,
  cn.n_name AS cust_nation,
  SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue
FROM 
  lineitem l
  JOIN supplier s ON l.l_suppkey = s.s_suppkey
  JOIN nation sn ON s.s_nationkey = sn.n_nationkey
  JOIN orders o ON l.l_orderkey = o.o_orderkey
  JOIN customer c ON o.o_custkey = c.c_custkey
  JOIN nation cn ON c.c_nationkey = cn.n_nationkey
WHERE 
  (sn.n_name = 'ARGENTINA' AND cn.n_name = 'KENYA') 
  OR (sn.n_name = 'KENYA' AND cn.n_name = 'ARGENTINA')
  AND l.l_shipdate BETWEEN '1995-01-01' AND '1996-12-31'
GROUP BY 
  l.l_shipdate::date::text::integer / 10000,
  sn.n_name,
  cn.n_name
ORDER BY 
  sup_nation,
  cust_nation,
  l_year;