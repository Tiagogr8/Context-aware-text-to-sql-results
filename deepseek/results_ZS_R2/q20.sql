SELECT 
    p.p_name, 
    s.s_name, 
    COUNT(*) as excess_count
FROM 
    part p
JOIN 
    partsupp ps ON p.p_partkey = ps.ps_partkey
JOIN 
    supplier s ON ps.ps_suppkey = s.s_suppkey
JOIN 
    nation n ON s.s_nationkey = n.n_nationkey
WHERE 
    n.n_name = 'SAUDI ARABIA'
    AND p.p_name LIKE 'brown%'
    AND EXISTS (
        SELECT 1 
        FROM lineitem l 
        WHERE l.l_partkey = ps.ps_partkey 
          AND l.l_suppkey = ps.ps_suppkey 
          AND l.l_shipdate >= DATE '1994-01-01' - INTERVAL '1 year'
          AND l.l_shipdate < DATE '1994-01-01' + INTERval '1 year'
    )
GROUP BY 
    p.p_name, s.s_name
HAVING 
    COUNT(*) > 0.5 * (
        SELECT COUNT(*) 
        FROM lineitem l2 
        WHERE l2.l_partkey = ps.ps_partkey 
          AND l2.l_suppkey = ps.ps_suppkey 
          AND l2.l_shipdate >= DATE '1994-01-01' - INTERVAL '1 year'
          AND l2.l_shipdate < DATE '1994-01-01' + INTERval '1 year'
    )