-- 6.sql: The names of songs that are by Post Malone (no assumed artist_id).
SELECT name
FROM songs
WHERE artist_id =
(
    SELECT id
    FROM artists
    WHERE name = 'Post Malone'
);
