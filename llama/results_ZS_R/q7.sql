SELECT 
  l.l_shipdate::date::text::date::timestamp::date::text AS l_shipdate,
  n1.n_name AS supp_nation,
  n2.n_name AS cust_nation,
  EXTRACT(YEAR FROM l.l_shipdate) AS l_year,
  SUM(l.l_extendedprice * (1 - l.l_discount)) AS volume
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
  AND n1.n_name = 'ARGENTINA'
  AND n2.n_name = 'KENYA'
  AND EXTRACT(YEAR FROM l.l_shipdate) IN (1995, 1996)
GROUP BY 
  n1.n_name,
  n2.n_name,
  EXTRACT(YEAR FROM l.l_shipdate)
ORDER BY 
  supp_nation,
  cust_nation,
  l_year;