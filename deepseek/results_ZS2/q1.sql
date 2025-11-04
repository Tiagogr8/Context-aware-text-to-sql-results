SELECT 
    l_returnflag,
    l_linestatus,
    COUNT(*) AS count,
    SUM(l_quantity) AS sum_qty,
    SUM(l_extendedprice) AS sum_base_price,
    SUM(l_extendedprice * (1 - l_discount)) AS sum_disc_price,
    SUM(l_extendedprice * (1 - l_discount) * (1 + l_tax)) AS sum_charge,
    AVG(l_quantity) AS avg_qty,
    AVG(l_extendedprice) AS avg_price,
    AVg(l_discount) AS avg_disc
FROM 
    lineitem
WHERE 
    l_shipdate <= (SELECT MAX(l_shipdate) FROM lineitem) - INTERVAL '84 days'
GROUP BY 
    l_returnflag, 
    l_linestatus
ORDER BY 
    l_returnflag, 
    l_linestatus;