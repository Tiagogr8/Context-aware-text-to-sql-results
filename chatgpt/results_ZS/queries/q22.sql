SELECT
SUBSTRING(c.c_phone FROM 1 FOR 2) AS country_code,
COUNT(*) AS num_customers,
SUM(c.c_acctbal) AS total_acctbal,
AVG(c.c_acctbal) AS avg_acctbal
FROM
customer c
WHERE
SUBSTRING(c.c_phone FROM 1 FOR 2) IN ('30', '31', '28', '21', '26', '33', '10')
AND c.c_acctbal > (
SELECT AVG(c2.c_acctbal)
FROM customer c2
WHERE c2.c_acctbal > 0
)
AND NOT EXISTS (
SELECT 1
FROM orders o
WHERE o.o_custkey = c.c_custkey
AND o.o_orderdate >= CURRENT_DATE - INTERVAL '7 years'
)
GROUP BY
SUBSTRING(c.c_phone FROM 1 FOR 2)
ORDER BY
country_code;
