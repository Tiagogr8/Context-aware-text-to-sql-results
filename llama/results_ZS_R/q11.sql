WITH 
  -- Calculate total value of all available parts
  total_value AS (
    SELECT SUM(ps.ps_availqty * p.p_retailprice) AS total
    FROM partsupp ps
    JOIN part p ON ps.ps_partkey = p.p_partkey
    JOIN supplier s ON ps.ps_suppkey = s.s_suppkey
    JOIN nation n ON s.s_nationkey = n.n_nationkey
    WHERE n.n_name = 'UNITED STATES'
  ),
  
  -- Calculate value of each part
  part_value AS (
    SELECT p.p_partkey, ps.ps_availqty * p.p_retailprice AS value
    FROM partsupp ps
    JOIN part p ON ps.ps_partkey = p.p_partkey
    JOIN supplier s ON ps.ps_suppkey = s.s_suppkey
    JOIN nation n ON s.s_nationkey = n.n_nationkey
    WHERE n.n_name = 'UNITED STATES'
  )

SELECT pv.p_partkey, pv.value
FROM part_value pv
JOIN total_value tv ON 1 = 1
WHERE pv.value > tv.total * 0.0001000000
ORDER BY pv.value DESC;