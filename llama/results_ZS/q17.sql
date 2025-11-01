WITH 
  -- Calculate average lineitem quantity of parts with given brand and container
  avg_quantity AS (
    SELECT 
      AVG(l.l_quantity) AS avg_qty
    FROM 
      lineitem l
    JOIN 
      part p ON l.l_partkey = p.p_partkey
    WHERE 
      p.p_brand = 'Brand#23' AND p.p_container = 'SM CAN'
  ),
  
  -- Calculate total revenue of parts with given brand and container and quantity less than 20% of average
  lost_revenue AS (
    SELECT 
      SUM(l.l_extendedprice * l.l_quantity) AS total_revenue
    FROM 
      lineitem l
    JOIN 
      part p ON l.l_partkey = p.p_partkey
    WHERE 
      p.p_brand = 'Brand#23' AND p.p_container = 'SM CAN' AND l.l_quantity < (SELECT 0.2 * avg_qty FROM avg_quantity)
  )

SELECT 
  (SELECT total_revenue FROM lost_revenue) / 7 AS avg_yearly_loss