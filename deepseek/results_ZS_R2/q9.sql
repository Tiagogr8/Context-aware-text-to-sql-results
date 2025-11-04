WITH filtered_lineitems AS (
    SELECT 
        l.l_extendedprice,
        l.l_discount,
        l.l_quantity,
        l.l_partkey,
        l.l_orderkey,
        EXTRACT(YEAR FROM l.l_shipdate) AS year
    FROM 
        lineitem l
    JOIN 
        part p ON l.l_partkey = p.p_partkey
    WHERE 
        p.p_name LIKE '%red%'
),
profit_per_lineitem AS (
    SELECT 
        fl.l_orderkey,
        fl.year,
        (fl.l_extendedprice * (1 - fl.l_discount) - (ps.ps_supplycost * fl.l_quantity)) AS profit,
        s.s_nationkey
    FROM 
        filtered_lineitems fl
    JOIN 
        partsupp ps ON fl.l_partkey = ps.ps_partkey
    JOIN 
        supplier s ON ps.ps_suppkey = s.s_suppkey
),
nation_profits AS (
    SELECT 
        pl.year,
        n.n_name AS nation,
        SUM(pl.profit) AS total_profit
    FROM 
        profit_per_lineitem pl
    JOIN 
        nation n ON pl.s_nationkey = n.n_nationkey
    GROUP BY 
        pl.year, n.n_name
)
SELECT 
    nation,
    year,
    total_profit
FROM 
    nation_profits
ORDER BY 
    nation ASC, 
    year DESC;