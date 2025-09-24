-- 13.sql: Names of people in movies with Kevin Bacon (born 1958), excluding him
SELECT DISTINCT p.name
FROM people p
JOIN stars s ON p.id = s.person_id
WHERE s.movie_id IN (
    SELECT movie_id
    FROM stars
    WHERE person_id = (
        SELECT id
        FROM people
        WHERE name = 'Kevin Bacon' AND birth_year = 1958
    )
)
AND p.name != 'Kevin Bacon';
