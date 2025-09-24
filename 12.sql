-- 12.sql: Movies with both Bradley Cooper and Jennifer Lawrence
SELECT title
FROM movies
WHERE id IN (
    SELECT movie_id
    FROM stars
    WHERE person_id = (SELECT id FROM people WHERE name = 'Bradley Cooper')
    INTERSECT
    SELECT movie_id
    FROM stars
    WHERE person_id = (SELECT id FROM people WHERE name = 'Jennifer Lawrence')
);
