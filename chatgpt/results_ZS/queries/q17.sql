SELECT
SUM(l_extendedprice) / 7.0 AS avg_yearly_loss
FROM
lineitem l
JOIN part p ON l.l_partkey = p.p_partkey
WHERE
p.p_brand = 'Brand#23'
AND p.p_container = 'SM CAN'
AND l_quantity < (
0.2 * (
SELECT AVG(l2.l_quantity)
FROM lineitem l2
JOIN part p2 ON l2.l_partkey = p2.p_partkey
WHERE
p2.p_brand = 'Brand#23'
AND p2.p_container = 'SM CAN'
)
);
