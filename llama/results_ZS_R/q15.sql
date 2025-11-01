SELECT s.s_suppkey, s.s_name, s.s_address, s.s_phone, 
       SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue
FROM supplier s
JOIN lineitem l ON s.s_suppkey = l.l_suppkey
WHERE l.l_shipdate >= '1997-01-01' AND l.l_shipdate < '1997-04-01'
GROUP BY s.s_suppkey, s.s_name, s.s_address, s.s_phone
HAVING SUM(l.l_extendedprice * (1 - l.l_discount)) = (
  SELECT MAX(revenue)
  FROM (
    SELECT SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue
    FROM supplier s
    JOIN lineitem l ON s.s_suppkey = l.l_suppkey
    WHERE l.l_shipdate >= '1997-01-01' AND l.l_shipdate < '1997-04-01'
    GROUP BY s.s_suppkey
  ) AS subquery
)
ORDER BY s.s_suppkey;