WITH revenue_per_part AS (
  SELECT 
    l.l_partkey,
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS total_revenue
  FROM 
    lineitem l
  WHERE 
    l.l_shipdate >= DATE '1996-04-01' 
    AND l.l_shipdate < DATE '1996-04-01' + INTERVAL '1 month'
  GROUP BY 
    l.l_partkey
),
promotional_parts AS (
  -- Identify parts that were part of a promotion (e.g., have a discount above a certain threshold)
  -- In this context, we consider a part as promotional if its discount is above a threshold, say 0.1 (10%)
  -- This is an assumption; the actual criteria might vary based on the promotion.
  SELECT 
    l.l_partkey
  FROM 
    lineitem l
  WHERE 
    l.l_shipdate >= DATE '1996-04-01' 
    AND l.l_shipdate < DATE '1996-04-01' + INTERval '1 month'
    AND l.l_discount > 0.1  -- Assuming discount above 10% is considered promotional
  GROUP BY 
    l.l_partkey
)
SELECT 
  (SUM(CASE WHEN r.l_partkey IN (SELECT l_partkey FROM promotional_parts) THEN r.total_revenue ELSE 0 END) /
  SUM(r.total_revenue) * 100.0
FROM 
  revenue_per_part r<｜begin▁of▁sentence｜>