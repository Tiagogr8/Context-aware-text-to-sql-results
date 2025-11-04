SELECT 
    n1.n_name AS supp_nation, 
    n2.n_name AS cust_nation, 
    EXTRACT(YEAR FROM l_shipdate) AS year, 
    SUM(l_extendedprice * (1 - l_discount)) AS revenue
FROM 
    lineitem
    JOIN supplier ON s_suppkey = l_suppkey
    JOIN nation n1 ON s_nationkey = n1.n_nationkey
    JOIN orders ON l_orderkey = o_orderkey
    JOIN customer ON o_custkey = c_custkey
    JOIN nation n2 ON c_nationkey = n2.n_nationkey
WHERE 
    ((n1.n_name = 'ARGENTINA' AND n2.n_name = 'KENYA') OR 
     (n1.n_name = 'KENYA' AND n2.n_name = 'ARGENTINA'))
    AND l_shipdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
GROUP BY 
    n1.n_name, n2.n_name, EXTRACT(YEAR FROM l_shipdate)
ORDER BY 
    n1.n_name, n2.n_name, EXTRACT(YEAR FROM l_shipdate);