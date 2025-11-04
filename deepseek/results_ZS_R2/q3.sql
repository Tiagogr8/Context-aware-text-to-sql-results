SELECT
    l_orderkey,
    SUM(l_extendedprice * (1 - l_discount)) AS revenue
FROM
    lineitem
WHERE
    l_shipdate > '1995-03-27'  -- Assuming '1995-03-27' is the substituted date
    AND l_returnflag = 'R'  -- Only consider returned items (unshipped)
GROUP BY
    l_orderkey
ORDER BY
    revenue DESC
LIMIT 10;