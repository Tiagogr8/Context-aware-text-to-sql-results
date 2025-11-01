SELECT
  EXTRACT(YEAR FROM o.o_orderdate) AS o_year,
  SUM(CASE
    WHEN n1.n_name = 'KENYA'
    THEN l.l_extendedprice * (1 - l.l_discount)
    ELSE 0
  END) / SUM(l.l_extendedprice * (1 - l.l_discount)) AS mkt_share
FROM
  part AS p,
  supplier AS s,
  lineitem AS l,
  orders AS o,
  customer AS c,
  nation AS n1,
  nation AS n2,
  region AS r
WHERE
  p.p_partkey = l.l_partkey
  AND s.s_suppkey = l.l_suppkey
  AND l.l_orderkey = o.o_orderkey
  AND o.o_custkey = c.c_custkey
  AND c.c_nationkey = n2.n_nationkey
  AND n2.n_regionkey = r.r_regionkey
  AND r.r_name = 'AFRICA'
  AND s.s_nationkey = n1.n_nationkey
  AND o.o_orderdate BETWEEN '1995-01-01' AND '1996-12-31'
  AND p.p_type = 'ECONOMY PLATED BRASS'
GROUP BY
  o_year
ORDER BY
  o_year;