SELECT 
    EXTRACT(YEAR FROM o_orderdate) AS year,
    SUM(CASE 
        WHEN n.n_name = 'KENYA' THEN l.l_extendedprice * (1 - l.l_discount) 
        ELSE 0 
    END) / SUM(l.l_extendedprice * (1 - l.l_discount)) AS market_share
FROM 
    orders o
JOIN 
    lineitem l ON o.o_orderkey = l.l_orderkey
JOIN 
    supplier s ON l.l_suppkey = s.s_suppkey
JOIN 
    nation n ON s.s_nationkey = n.n_nationkey
JOIN 
    region r ON n.n_regionkey = r.r_regionkey
JOIN 
    partsupp ps ON l.l_partkey = ps.ps_partkey AND l.l_suppkey = ps.ps_suppkey
JOIN 
    part p ON ps.ps_partkey = p.p_partkey
WHERE 
    r.r_name = 'AFRICA' 
    AND p.p_type = 'ECONOMY PLATED BRASS'
    AND EXTRACT(YEAR FROM o_orderdate) IN (1995, 1996)
GROUP BY 
    EXTRACT(YEAR FROM o_orderdate)
ORDER BY 
    year;