CREATE OR REPLACE VIEW recommended_plan AS
WITH ranked_recommendations AS (SELECT id,
                                       plan,
                                       COUNT(plan) AS plan_count,
                                       RANK() OVER (
                                           PARTITION BY id
                                           ORDER BY COUNT(plan) DESC,
                                               CASE
                                                   WHEN plan = 'S' THEN 1
                                                   WHEN plan = 'M' THEN 2
                                                   WHEN plan = 'L' THEN 3
                                                   WHEN plan = 'X' THEN 4
                                                   ELSE 5
                                                   END ASC
                                           )       AS rank
                                FROM baza2
                                GROUP BY id, plan)
SELECT
    id,
    plan AS recommended_plan
FROM
    ranked_recommendations
WHERE
    rank = 1 AND plan IS NOT NULL;