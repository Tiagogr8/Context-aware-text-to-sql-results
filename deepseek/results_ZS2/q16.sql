WITH suppliers_with_parts AS (
    SELECT s_suppkey
    FROM supplier
    JOIN partsupp ON s_suppkey = ps_suppkey
    JOIN part ON ps_partkey = p_partkey
    WHERE 
        p_brand = 'Brand#42'
        AND p_type NOT LIKE 'LARGE PLATED%'
        AND p_size IN (9, 7, 14, 41, 43, 38, 23, 34)
        AND NOT EXISTS (
            SELECT 1 
            FROM part part2 
            WHERE part2.p_partkey = part.p_partkey 
            AND part2.p_type LIKE '%BAD%'
        )
)
SELECT 
    COUNT(s_suppkey) AS supplier_count
FROM suppliers_with_parts;