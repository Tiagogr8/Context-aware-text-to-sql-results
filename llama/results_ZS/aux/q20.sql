SELECT 
    s.s_name, 
    s.s_address
FROM 
    supplier s
WHERE 
    s.s_nationkey = (
        SELECT 
            n.n_nationkey 
        FROM 
            nation n 
        WHERE 
            n.n_name = 'SAUDI ARABIA'
    )
    AND s.s_suppkey IN (
        SELECT 
            ps.ps_suppkey 
        FROM 
            partsupp ps
        WHERE 
            ps.ps_partkey IN (
                SELECT 
                    p.p_partkey 
                FROM 
                    part p 
                WHERE 
                    p.p_name LIKE 'brown%'
            )
            AND ps.ps_availqty > (
                SELECT 
                    SUM(l.l_quantity) * 0.5 
                FROM 
                    lineitem l 
                WHERE 
                    l.l_suppkey = ps.ps_suppkey 
                    AND l.l_shipdate >= '1994-01-01' 
                    AND l.l_shipdate < '1995-01-01'
            )
    );