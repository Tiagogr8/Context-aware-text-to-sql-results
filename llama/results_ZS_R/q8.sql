SELECT 
  SUM(CASE WHEN EXTRACT(YEAR FROM l_shipdate) = 1995 THEN l_extendedprice * (1 - l_discount) ELSE 0 END) AS market_share_1995,
  SUM(CASE WHEN EXTRACT(YEAR FROM l_shipdate) = 1996 THEN l_extendedprice * (1 - l_discount) ELSE 0 END) AS market_share_1996
FROM 
  lineitem
  JOIN partsupp ON lineitem.l_partkey = partsupp.ps_partkey AND lineitem.l_suppkey = partsupp.ps_suppkey
  JOIN part ON partsupp.ps_partkey = part.p_partkey
  JOIN supplier ON partsupp.ps_suppkey = supplier.s_suppkey
  JOIN nation ON supplier.s_nationkey = nation.n_nationkey
  JOIN region ON nation.n_regionkey = region.r_regionkey
WHERE 
  nation.n_name = 'KENYA'
  AND region.r_name = 'AFRICA'
  AND part.p_type = 'ECONOMY PLATED BRASS';