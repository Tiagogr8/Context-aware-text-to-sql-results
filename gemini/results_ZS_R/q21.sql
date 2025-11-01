SELECT
  s.s_name
FROM
  supplier AS s
JOIN
  nation AS n
  ON s.s_nationkey = n.n_nationkey
JOIN
  lineitem AS l1
  ON s.s_suppkey = l1.l_suppkey
JOIN
  orders AS o
  ON o.o_orderkey = l1.o_orderkey
WHERE
  n.n_name = 'ETHIOPIA' AND o.o_orderstatus = 'F' AND l1.l_receiptdate > l1.l_commitdate AND EXISTS (
    SELECT
      1
    FROM
      lineitem AS l2
    WHERE
      l2.l_orderkey = l1.l_orderkey AND l2.l_suppkey <> l1.l_suppkey
  ) AND NOT EXISTS (
    SELECT
      1
    FROM
      lineitem AS l3
    WHERE
      l3.l_orderkey = l1.l_orderkey AND l3.l_suppkey <> l1.l_suppkey AND l3.l_receiptdate > l3.l_commitdate
  )
GROUP BY
  s.s_name
ORDER BY
  s.s_name;