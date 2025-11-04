WITH revenue_per_supplier AS (
    SELECT 
        l.l_suppkey AS supplier_id,
        SUM(l.l_extendedprice * (1 - l.l_discount)) AS total_revenue
    FROM 
        lineitem l
    WHERE 
        l.l_shipdate >= DATE '1997-01-01' 
        AND l.l_shipdate < DATE '1997-01-01' + INTERVAL '3 months'
    GROUP BY 
        l.l_suppkey
),
max_revenue AS (
    SELECT 
        MAX(total_revenue) AS max_rev
    FROM 
        revenue_per_supplier
)
SELECT 
    rps.supplier_id,
    rps.total_revenue
FROM 
    revenue_per_supplier rps
JOIN 
    max_revenue mr ON rps.total_revenue = mr.max_rev
ORDER BY 
    rps.supplier_id;