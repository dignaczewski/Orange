CREATE OR REPLACE VIEW recommendation_list_per_id AS
WITH agg_table AS (
    SELECT
        id, plan, STRING_AGG(number, ', ') AS numbers
    FROM
        baza2
    WHERE plan IS NOT NULL
    GROUP BY
        id, plan
)
SELECT
    id,
    STRING_AGG(plan || ': ' || numbers, ', ' ORDER BY
        CASE 
            WHEN plan = 'S' THEN 1
            WHEN plan = 'M' THEN 2
            WHEN plan = 'L' THEN 3
            WHEN plan = 'X' THEN 4
            ELSE 5
        END ASC
    ) AS recommendations
FROM
    agg_table
GROUP BY
    id;