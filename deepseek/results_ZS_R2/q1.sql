-- Step 1: Identify the relevant table - it's the lineitem table as we need to calculate aggregates on shipped items.
-- Step 2: Filter for lineitems shipped before a specific date. The condition is: l_shipdate < (enddate - delta). 
--   Given enddate is '1998-12-01' (the highest ship date) and delta is 84 days (as per the example), 
--   then the condition becomes: l_shipdate < ('1998-12-01'::date - INTERVAL '84 days')
--   which is: l_shipdate < '1998-09-08' (since 84 days before 1998-12-01 is 1998-09-08)
-- Step 3: Group by returnflag and linestatus
-- Step 4: Calculate the required aggregates: 
--   sum(l_quantity) as sum_qty,
--   sum(l_extendedprice) as sum_base_price,
--   sum(l_extendedprice * (1 - l_discount)) as sum_disc_price,
--   sum(l_extendedprice * (1 - l_discount) * (1 + l_tax)) as sum_charge,
--   avg(l_quantity) as avg_qty,
--   avg(l_extendedprice) as avg_price,
--   avg(l_discount) as avg_disc,
--   count(*) as count_order
-- Step 5: Order by returnflag and linestatus (ascending)

SELECT 
    l_returnflag,
    l_linestatus,
    SUM(l_quantity) AS sum_qty,
    SUM(l_extendedprice) AS sum_base_price,
    SUM(l_extendedprice * (1 - l_discount)) AS sum_disc_price,
    SUM(l_extendedprice * (1 - l_discount) * (1 + l_tax)) AS sum_charge,
    AVG(l_quantity) AS avg_qty,
    AVG(l_extendedprice) AS avg_price,
    AVG(l_discount) AS avg_disc,
    COUNT(*) AS count_order
FROM 
    lineitem
WHERE 
    l_shipdate < DATE '1998-12-01' - INTERVAL '84 days'
GROUP BY 
    l_returnflag, 
    l_linestatus
ORDER BY 
    l_returnflag, 
    l_linestatus;