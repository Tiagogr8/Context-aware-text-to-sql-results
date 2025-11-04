SELECT 
    SUM(CASE WHEN p_type LIKE 'PROMO%' THEN l_extendedprice * (1 - l_discount) ELSE 0 END) / 
    SUM(l_extendedprice * (1 - l_discount)) * 100
FROM 
    lineitem
WHERE 
    EXTRACT(YEAR FROM l_shipdate) = 1996
    AND EXTRACT(MONTH FROM l_shipdate) = 4
    AND l_shipdate >= '1996-04-01'
    AND l_shipdate < '1996-05-01';