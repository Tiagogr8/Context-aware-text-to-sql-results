WITH revenue_by_supplier AS (
  SELECT 
    l.l_suppkey AS supplier_key,
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
    revenue_by_supplier
)
SELECT 
  s.s_suppkey,
  s.s_name,
  r.total_revenue
FROM 
  revenue_by_supplier r
JOIN 
  supplier s ON r.supplier_key = s.s_suppkey
WHERE 
  r.total_revenue = (SELECT max_rev FROM max_revenue)
ORDER BY 
  s.s_suppkey;