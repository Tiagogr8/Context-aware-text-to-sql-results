SELECT
p.p_brand,
p.p_type,
p.p_size,
COUNT(DISTINCT s.s_suppkey) AS supplier_cnt
FROM
part p
JOIN partsupp ps ON p.p_partkey = ps.ps_partkey
JOIN supplier s ON ps.ps_suppkey = s.s_suppkey
WHERE
p.p_brand <> 'Brand#42'
AND p.p_type NOT LIKE 'LARGE PLATED%'
AND p.p_size IN (9, 7, 14, 41, 43, 38, 23, 34)
AND s.s_comment NOT LIKE '%Customer%Complaints%'
GROUP BY
p.p_brand,
p.p_type,
p.p_size
ORDER BY
supplier_cnt DESC,
p.p_brand ASC,
p.p_type ASC,
p.p_size ASC;
