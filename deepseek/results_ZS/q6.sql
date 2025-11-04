SELECT SUM(l_extendedprice * l_discount) AS revenue_increase
FROM lineitem
WHERE l_shipdate >= DATE '1994-01-01'
  AND l_shipdate < DATE '1994-01-01' + INTERVAL '1 year'
  AND l_discount BETWEEN 0.01 AND 0.03  -- 0.02 - 0.01 = 0.01, 0.02 + 0.01 = 0.03 -> range [0.01, 0.03]
  AND l_quantity < 25;