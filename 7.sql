-- 7.sql: The average energy of songs that are by Drake (no assumed artist_id).
SELECT AVG(energy) AS average_energy_by_drake
FROM songs
JOIN artists ON songs.artist_id = artists.id
WHERE artists.name = 'Drake';
