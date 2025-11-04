SELECT
SUM(CASE WHEN p_type LIKE 'PROMO%' THEN l_extendedprice * (1 - l_discount) ELSE 0 END) * 100.0 /
SUM(l_extendedprice * (1 - l_discount)) AS promo_revenue
FROM
lineitem l
JOIN
part p ON l.l_partkey = p.p_partkey
WHERE
DATE_TRUNC('month', l_shipdate) = DATE '1996-04-01';
