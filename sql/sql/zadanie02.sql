CREATE OR REPLACE VIEW plan_recommendations AS
SELECT
    plan,
    COUNT(plan) AS no_of_recommendations
FROM
    tmp
GROUP BY
    plan
ORDER BY
    CASE
        WHEN plan = 'S' THEN 1
        WHEN plan = 'M' THEN 2
        WHEN plan = 'L' THEN 3
        WHEN plan = 'X' THEN 4
        ELSE 5
    END;