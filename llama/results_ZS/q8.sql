SELECT 
    SUM(CASE WHEN EXTRACT(YEAR FROM l_shipdate) = 1995 THEN l_extendedprice * (1 - l_discount) ELSE 0 END) / 
    (SELECT SUM(l_extendedprice * (1 - l_discount)) 
     FROM lineitem 
     WHERE l_shipdate >= '1995-01-01' AND l_shipdate < '1996-01-01' 
     AND l_partkey IN (SELECT p_partkey FROM part WHERE p_type = 'ECONOMY PLATED BRASS') 
     AND l_suppkey IN (SELECT s_suppkey FROM supplier WHERE s_nationkey IN (SELECT n_nationkey FROM nation WHERE n_name = 'KENYA'))),
    SUM(CASE WHEN EXTRACT(YEAR FROM l_shipdate) = 1996 THEN l_extendedprice * (1 - l_discount) ELSE 0 END) / 
    (SELECT SUM(l_extendedprice * (1 - l_discount)) 
     FROM lineitem 
     WHERE l_shipdate >= '1996-01-01' AND l_shipdate < '1997-01-01' 
     AND l_partkey IN (SELECT p_partkey FROM part WHERE p_type = 'ECONOMY PLATED BRASS') 
     AND l_suppkey IN (SELECT s_suppkey FROM supplier WHERE s_nationkey IN (SELECT n_nationkey FROM nation WHERE n_name = 'KENYA')))
FROM 
    lineitem 
WHERE 
    l_partkey IN (SELECT p_partkey FROM part WHERE p_type = 'ECONOMY PLATED BRASS') 
    AND l_suppkey IN (SELECT s_suppkey FROM supplier WHERE s_nationkey IN (SELECT n_nationkey FROM nation WHERE n_name = 'KENYA'))
    AND l_shipdate >= '1995-01-01' AND l_shipdate < '1997-01-01';