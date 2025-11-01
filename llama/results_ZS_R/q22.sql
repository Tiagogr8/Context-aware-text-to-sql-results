WITH 
  -- Calculate average account balance
  avg_balance AS (
    SELECT AVG(c_acctbal) AS avg_acctbal
    FROM customer
  ),
  
  -- Filter customers with country codes in the specified range and greater than average account balance
  filtered_customers AS (
    SELECT c.c_custkey, c.c_name, c.c_phone, c.c_acctbal
    FROM customer c
    WHERE LEFT(c.c_phone, 2) IN ('30', '31', '28', '21', '26', '33', '10')
    AND c.c_acctbal > (SELECT avg_acctbal FROM avg_balance)
  ),
  
  -- Find customers who have not placed orders for 7 years
  inactive_customers AS (
    SELECT fc.c_custkey, fc.c_name, fc.c_phone, fc.c_acctbal
    FROM filtered_customers fc
    LEFT JOIN orders o ON fc.c_custkey = o.o_custkey
    WHERE o.o_orderkey IS NULL OR o.o_orderdate < (CURRENT_DATE - INTERVAL '7 year')
  )

-- Count the number of inactive customers and calculate the magnitude of their account balance
SELECT 
  COUNT(ic.c_custkey) AS num_customers,
  SUM(ic.c_acctbal) AS total_balance
FROM inactive_customers ic;