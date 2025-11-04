SELECT
s_suppkey,
s_name,
s_address,
s_phone,
s_acctbal,
s_comment,
ps_partkey,
p_name,
ps_availqty,
ps_supplycost
FROM
supplier
JOIN
partsupp ON s_suppkey = ps_suppkey
JOIN
part ON ps_partkey = p_partkey
JOIN
lineitem ON l_partkey = ps_partkey AND l_suppkey = ps_suppkey
JOIN
orders ON o_orderkey = l_orderkey
JOIN
customer ON o_custkey = c_custkey
JOIN
nation ON s_nationkey = n_nationkey
WHERE
n_name = 'SAUDI ARABIA'
AND p_name LIKE 'brown%'
AND o_orderdate >= '1994-01-01'
AND o_orderdate < '1995-01-01'
GROUP BY
s_suppkey,
s_name,
s_address,
s_phone,
s_acctbal,
s_comment,
ps_partkey,
p_name,
ps_availqty,
ps_supplycost
HAVING
ps_availqty > 0.5 * SUM(l_quantity);
