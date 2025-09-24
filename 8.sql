-- 8.sql: The names of songs that feature other artists (contain "feat.").
SELECT name
FROM songs
WHERE name LIKE '%feat.%';
