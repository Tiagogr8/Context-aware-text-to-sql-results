SELECT
    l.l_suppkey AS supplier_num,
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS total_revenue
FROM
    lineitem l
WHERE
    l.l_shipdate >= DATE '1997-01-01'
    AND l.l_shipdate < DATE '1997-01-01' + INTERVAL '3 months'
GROUP BY
    l.l_suppkey
ORDER BY
    total_revenue DESC,
    supplier_num ASC;