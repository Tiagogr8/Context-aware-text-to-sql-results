SELECT 
  s.s_name, 
  s.s_address
FROM 
  supplier s
WHERE 
  s.s_nationkey IN (
    SELECT 
      n.n_nationkey
    FROM 
      nation n
    WHERE 
      n.n_name = 'ETHIOPIA'
  )
  AND s.s_suppkey IN (
    SELECT 
      l.l_suppkey
    FROM 
      lineitem l
    WHERE 
      l.l_shipdate > l.l_commitdate
      AND l.l_orderkey IN (
        SELECT 
          o.o_orderkey
        FROM 
          orders o
        WHERE 
          o.o_orderstatus = 'F'
      )
      AND l.l_orderkey IN (
        SELECT 
          l2.l_orderkey
        FROM 
          lineitem l2
        GROUP BY 
          l2.l_orderkey
        HAVING 
          COUNT(DISTINCT l2.l_suppkey) > 1
      )
  )
  AND s.s_suppkey NOT IN (
    SELECT 
      l.l_suppkey
    FROM 
      lineitem l
    WHERE 
      l.l_shipdate <= l.l_commitdate
      AND l.l_orderkey IN (
        SELECT 
          o.o_orderkey
        FROM 
          orders o
        WHERE 
          o.o_orderstatus = 'F'
      )
      AND l.l_orderkey IN (
        SELECT 
          l2.l_orderkey
        FROM 
          lineitem l2
        GROUP BY 
          l2.l_orderkey
        HAVING 
          COUNT(DISTINCT l2.l_suppkey) > 1
      )
  );