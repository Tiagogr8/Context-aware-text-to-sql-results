WITH 
  cust AS (
    SELECT 
      c.c_custkey,
      c.c_name,
      c.c_address,
      c.c_nationkey,
      c.c_phone,
      c.c_acctbal,
      c.c_mktsegment,
      c.c_comment,
      LEFT(c.c_phone, 2) AS country_code
    FROM 
      customer c
  ),
  cust_orders AS (
    SELECT 
      c.c_custkey,
      MAX(o.o_orderdate) AS last_order_date
    FROM 
      cust c
    JOIN 
      orders o ON c.c_custkey = o.o_custkey
    GROUP BY 
      c.c_custkey
  ),
  target_customers AS (
    SELECT 
      c.c_custkey,
      c.country_code,
      c.c_acctbal
    FROM 
      cust c
    LEFT JOIN 
      cust_orders co ON c.c_custkey = co.c_custkey
    WHERE 
      (co.last_order_date IS NULL OR co.last_order_date < (CURRENT_DATE - INTERVAL '7 year'))
      AND c.country_code IN ('30', '31', '28', '21', '26', '33', '10')
  ),
  avg_acct_bal AS (
    SELECT 
      AVG(c_acctbal) AS avg_balance
    FROM 
      customer
  )
SELECT 
  country_code,
  COUNT(*) AS num_customers,
  SUM(c_acctbal) AS total_balance
FROM 
  target_customers
WHERE 
  c_acctbal > (SELECT avg_balance FROM avg_acct_bal)
GROUP BY 
  country_code
ORDER BY 
  country_code;