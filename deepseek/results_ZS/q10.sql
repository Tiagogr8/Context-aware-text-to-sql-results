WITH revenue_loss AS (
    SELECT 
        c.c_custkey,
        c.c_name,
        c.c_address,
        c.c_nationkey,
        c.c_phone,
        c.c_acctbal,
        c.c_comment,
        SUM(l.l_extendedprice * (1 - l.l_discount)) AS lost_revenue
    FROM 
        lineitem l
    JOIN 
        orders o ON l.l_orderkey = o.o_orderkey
    JOIN 
        customer c ON o.o_custkey = c.c_custkey
    WHERE 
        l.l_returnflag = 'R'  -- Returned items
        AND o.o_orderdate >= DATE '1993-08-01' 
        AND o.o_orderdate < DATE '1993-08-01' + INTERVAL '3 months'
    GROUP BY 
        c.c_custkey, c.c_name, c.c_address, c.c_nationkey, c.c_phone, c.c_acctbal, c.c_comment
)
SELECT 
    c.c_name,
    c.c_address,
    n.n_name AS nation,
    c.c_phone,
    c.c_acctbal,
    c.c_comment,
    r.lost_revenue
FROM 
    revenue_loss r
JOIN 
    customer c ON r.c_custkey = c.c_custkey
JOIN 
    nation n ON c.c_nationkey = n.n_nationkey
ORDER BY 
    r.lost_revenue DESC
LIMIT 20;