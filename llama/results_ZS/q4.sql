SELECT 
  o_orderpriority, 
  COUNT(o_orderkey) 
FROM 
  orders 
WHERE 
  o_orderdate >= '1997-01-01' 
  AND o_orderdate < '1997-04-01' 
  AND o_orderkey IN (
    SELECT 
      l_orderkey 
    FROM 
      lineitem 
    WHERE 
      l_receiptdate > l_commitdate
  ) 
GROUP BY 
  o_orderpriority 
ORDER BY 
  o_orderpriority;