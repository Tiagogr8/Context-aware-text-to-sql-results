SELECT 
    SUM(l_extendedprice * (1 - l_discount)) AS revenue
FROM 
    lineitem
WHERE 
    l_shipmode = 'AIR'
    AND l_shipinstruct = 'DELIVER IN PERSON'
    AND l_partkey IN (
        SELECT 
            p_partkey
        FROM 
            part
        WHERE 
            p_brand IN ('Brand#11', 'Brand#25', 'Brand#54')
            AND p_container IN ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG')
            AND p_size BETWEEN 1 AND 4
            OR p_size BETWEEN 10 AND 16
            OR p_size BETWEEN 20 AND 29
    );