SELECT 
  l.l_shipdate::date::text::integer / 10000 AS l_year,
  n1.n_name AS supp_nation,
  n2.n_name AS cust_nation,
  SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue
FROM 
  lineitem l,
  supplier s,
  nation n1,
  customer c,
  nation n2,
  orders o
WHERE 
  s.s_nationkey = n1.n_nationkey
  AND c.c_nationkey = n2.n_nationkey
  AND l.l_suppkey = s.s_suppkey
  AND l.l_orderkey = o.o_orderkey
  AND o.o_custkey = c.c_custkey
  AND ((n1.n_name = 'ARGENTINA' AND n2.n_name = 'KENYA') 
       OR (n1.n_name = 'KENYA' AND n2.n_name = 'ARGENTINA'))
  AND l.l_shipdate >= '1995-01-01'
  AND l.l_shipdate < '1997-01-01'
GROUP BY 
  l.l_shipdate::date::text::integer / 10000,
  n1.n_name,
  n2.n_name
ORDER BY 
  supp_nation,
  cust_nation,
  l_year;