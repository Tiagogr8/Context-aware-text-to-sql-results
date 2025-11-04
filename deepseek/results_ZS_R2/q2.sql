WITH region_parts AS (
    SELECT 
        p.p_partkey,
        p.p_type,
        p.p_size,
        s.s_suppkey,
        s.s_acctbal,
        s.s_name,
        s.s_address,
        s.s_phone,
        s.s_comment,
        n.n_name AS nation_name,
        ps.ps_supplycost
    FROM 
        part p
    JOIN 
        partsupp ps ON p.p_partkey = ps.ps_partkey
    JOIN 
        supplier s ON ps.ps_suppkey = s.s_suppkey
    JOIN 
        nation n ON s.s_nationkey = n.n_nationkey
    JOIN 
        region r ON n.n_regionkey = r.r_regionkey
    WHERE 
        p.p_size = 2  -- SIZE parameter
        AND p.p_type LIKE '%TIN%'  -- TYPE parameter
        AND r.r_name = 'ASIA'  -- REGION parameter
),
min_costs AS (
    SELECT 
        p_partkey,
        MIN(ps_supplycost) AS min_supplycost
    FROM 
        region_parts
    GROUP BY 
        p_partkey
)
SELECT 
    rp.s_suppkey,
    rp.s_acctbal,
    rp.s_name,
    rp.nation_name,
    rp.s_address,
    rp.s_phone,
    rp.s_comment,
    rp.p_partkey,
    rp.p_type,
    rp.p_size
FROM 
    region_parts rp
JOIN 
    min_costs mc ON rp.p_partkey = mc.p_partkey AND rp.ps_supplycost = mc.min_supplycost
ORDER BY 
    rp.s_acctbal DESC
LIMIT 100;