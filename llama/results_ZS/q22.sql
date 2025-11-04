WITH 
  -- Calculate average account balance
  avg_balance AS (
    SELECT AVG(c_acctbal) AS avg_acctbal
    FROM customer
  ),
  
  -- Filter customers with country codes and no orders for 7 years
  target_customers AS (
    SELECT 
      c.c_custkey,
      c.c_name,
      c.c_phone,
      c.c_acctbal,
      o.o_orderdate
    FROM 
      customer c
    LEFT JOIN 
      orders o ON c.c_custkey = o.o_custkey
    WHERE 
      c.c_phone LIKE ANY (ARRAY['30%', '31%', '28%', '21%', '26%', '33%', '10%'])
      AND (o.o_orderdate IS NULL OR o.o_orderdate < (CURRENT_DATE - INTERVAL '7 year'))
  ),
  
  -- Filter customers with above average account balance
  potential_customers AS (
    SELECT 
      tc.c_custkey,
      tc.c_name,
      tc.c_phone,
      tc.c_acctbal
    FROM 
      target_customers tc
    CROSS JOIN 
      avg_balance ab
    WHERE 
      tc.c_acctbal > ab.avg_acctbal
  )

SELECT 
  COUNT(pc.c_custkey) AS num_customers,
  SUM(pc.c_acctbal) AS total_balance
FROM 
  potential_customers pc;