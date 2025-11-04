WITH late_shipments AS (
    SELECT 
        o.o_orderkey,
        o.o_orderpriority,
        l.l_commitdate,
        l.l_receiptdate
    FROM 
        lineitem l
    JOIN 
        orders o ON l.l_orderkey = o.o_orderkey
    WHERE 
        l.l_receiptdate > l.l_commitdate
        AND l.l_shipdate >= DATE '1997-01-01'
        AND l.l_shipdate < DATE '1997-01-01' + INTERVAL '3 months'
)
SELECT 
    o_orderpriority,
    COUNT(*) AS order_count
FROM 
    late_shipments
GROUP BY 
    o_orderpriority
ORDER BY 
    o_orderpriority;