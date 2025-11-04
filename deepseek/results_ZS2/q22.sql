SELECT COUNT(*) AS num_customers, 
       AVG(c_acctbal) AS avg_balance 
FROM customer 
WHERE LEFT(c_phone, 2) IN ('30', '31', '28', '21', '26', '33', '10') 
  AND c_custkey NOT IN (
      SELECT o_custkey 
      FROM orders 
      WHERE o_orderdate >= CURRENT_DATE - INTERVAL '7 years'
  ) 
  AND c_acctbal > (SELECT AVG(c_acctbal) FROM customer) 
GROUP BY c_custkey;