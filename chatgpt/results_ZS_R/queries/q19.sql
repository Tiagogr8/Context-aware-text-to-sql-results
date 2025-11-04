SELECT
SUM(l_extendedprice * (1 - l_discount)) AS revenue
FROM
lineitem l
JOIN part p ON l.l_partkey = p.p_partkey
WHERE
l.l_shipmode IN ('AIR','AIR REG')
AND l.l_shipinstruct = 'DELIVER IN PERSON'
AND (
(
p.p_brand = 'Brand#11'
AND p.p_container IN ('SM CASE','SM BOX','SM PACK','SM PKG')
AND p.p_size BETWEEN 1 AND 5
AND l.l_quantity BETWEEN 1 AND 4
)
OR (
p.p_brand = 'Brand#25'
AND p.p_container IN ('MED BAG','MED BOX','MED PACK','MED PKG')
AND p.p_size BETWEEN 1 AND 10
AND l.l_quantity BETWEEN 5 AND 16
)
OR (
p.p_brand = 'Brand#54'
AND p.p_container IN ('LG CASE','LG BOX','LG PACK','LG PKG')
AND p.p_size BETWEEN 1 AND 15
AND l.l_quantity BETWEEN 17 AND 29
)
);