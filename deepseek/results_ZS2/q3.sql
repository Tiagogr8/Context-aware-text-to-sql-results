SELECT l.l_orderkey, 
       SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue
FROM lineitem l
JOIN orders o ON l.l_orderkey = o.o_orderkey
JOIN customer c ON o.o_custkey = c.c_custkey
WHERE c.c_mktsegment = 'FURNITURE'
  AND l.l_shipdate > DATE '1995-03-27'
  AND o.o_orderdate < DATE '1995-03-27'
GROUP BY l.l_orderkey
ORDER BY revenue DESC
LIMIT 10;