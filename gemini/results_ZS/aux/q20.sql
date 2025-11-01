WITH shipped_parts AS (
  SELECT
    l_suppkey,
    l_partkey,
    SUM(l_quantity) AS total_shipped
  FROM
    part
    JOIN lineitem ON p_partkey = l_partkey
  WHERE
    p_name LIKE 'brown%'
    AND l_shipdate >= '1994-01-01'
    AND l_shipdate < DATE '1994-01-01' + INTERVAL '1 year'
  GROUP BY
    l_suppkey,
    l_partkey
)
SELECT
  s.s_suppkey,
  s.s_name
FROM
  supplier AS s
  JOIN nation AS n ON s.s_nationkey = n.n_nationkey
  JOIN partsupp AS ps ON s.s_suppkey = ps.ps_suppkey
  JOIN shipped_parts AS sp ON ps.ps_suppkey = sp.l_suppkey
    AND ps.ps_partkey = sp.l_partkey
WHERE
  n.n_name = 'SAUDI ARABIA'
  AND ps.ps_availqty > 0.5 * sp.total_shipped
ORDER BY
  s.s_name;