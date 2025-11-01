WITH total_value AS (
  SELECT SUM(ps.ps_availqty * p.p_retailprice) AS total
  FROM partsupp ps
  JOIN supplier s ON ps.ps_suppkey = s.s_suppkey
  JOIN nation n ON s.s_nationkey = n.n_nationkey
  JOIN part p ON ps.ps_partkey = p.p_partkey
  WHERE n.n_name = 'UNITED STATES'
),
important_parts AS (
  SELECT p.p_partkey, ps.ps_availqty * p.p_retailprice AS value
  FROM partsupp ps
  JOIN supplier s ON ps.ps_suppkey = s.s_suppkey
  JOIN nation n ON s.s_nationkey = n.n_nationkey
  JOIN part p ON ps.ps_partkey = p.p_partkey
  WHERE n.n_name = 'UNITED STATES'
)
SELECT p_partkey, value
FROM important_parts
WHERE value > (SELECT total * 0.0001000000 FROM total_value)
ORDER BY value DESC;