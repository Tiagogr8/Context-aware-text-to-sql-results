SELECT 
    SUM(l_extendedprice * (1 - l_discount)) AS revenue
FROM 
    lineitem, 
    part, 
    orders, 
    customer
WHERE 
    l_partkey = p_partkey 
    AND l_orderkey = o_orderkey 
    AND o_custkey = c_custkey
    AND p_brand IN ('Brand#11', 'Brand#25', 'Brand#54')
    AND p_container IN ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG', 'MD CASE', 'MD BOX', 'MD PACK', 'MD PKG', 'LG CASE', 'LG BOX', 'LG PACK', 'LG PKG')
    AND p_size BETWEEN 1 AND 50
    AND l_quantity >= 4 
    AND l_quantity <= 16 
    AND l_quantity <= 29
    AND l_shipmode IN ('AIR', 'FOB')
    AND c_mktsegment = 'AUTOMOBILE'
    AND o_orderdate >= DATE '1997-01-01'
    AND o_orderdate < DATE '1997-01-01' + INTERVAL '1 month'