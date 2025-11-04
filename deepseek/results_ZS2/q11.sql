SELECT
    l_partkey,
    SUM(l_extendedprice * (1 - l_discount)) AS part_value
FROM
    lineitem
    JOIN supplier ON l_suppkey = s_suppkey
    JOIN nation ON s_nationkey = n_nationkey
WHERE
    n_name = 'UNITED STATES'
GROUP BY
    l_partkey
HAVING
    SUM(l_quantity * (l_extendedprice * (1 - l_discount))) > (
        SELECT 0.0001000000 * SUM(l_extendedprice * (1 - l_discount))
        FROM lineitem
        JOIN supplier ON l_suppkey = s_suppkey
        JOIN nation ON s_nationkey = n_nationkey
        WHERE n_name = 'UNITED STATES'
    )
ORDER BY
    part_value DESC;