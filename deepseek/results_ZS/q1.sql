SELECT 
    l_returnflag,
    l_linestatus,
    COUNT(*) AS count,
    SUM(l_quantity) AS sum_qty,
    AVG(l_quantity) AS avg_qty,
    AVG(l_extendedprice) AS avg_price,
    AVG(l_discount) AS avg_disc,
    SUM(l_extendedprice * (1 - l_discount)) AS sum_disc_price,
    SUM(l_extendedprice * (1 - l_discount) * (1 + l_tax)) AS sum_charge
FROM 
    lineitem
WHERE 
    l_shipdate <= DATE '1998-12-01' - INTERVAL '84 days'
GROUP BY 
    l_returnflag, 
    l_linestatus
ORDER BY 
    l_returnflag, 
    l_linestatus;
```<｜begin▁of▁sentence｜>