DROP TABLE IF EXISTS tmp;
CREATE TABLE tmp AS
SELECT
    b1.number AS number,
    COALESCE(b2.plan, CASE
        WHEN b1.SEGMENT = 'Soho' THEN 'S'
        WHEN b1.SEGMENT = 'Small' THEN 'M'
        ELSE NULL
    END) AS plan
FROM
    baza1 AS b1
LEFT JOIN
    baza2 AS b2 USING("number")
WHERE
    end_dt > NOW()
    AND end_dt < NOW() + INTERVAL '90 days'
    AND segment IN ('Soho', 'Small');