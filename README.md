# CS50 — Problem Set 7 (SQL)

This repository contains my solutions for Harvard / CS50 Problem Set 7: SQL.

## Files
- `1.sql` — list the names of all songs.
- `2.sql` — list songs ordered by tempo (ascending).
- `3.sql` — top 5 longest songs (descending by duration).
- `4.sql` — songs with danceability, energy, and valence > 0.75.
- `5.sql` — average energy of all songs.
- `6.sql` — names of songs by Post Malone.
- `7.sql` — average energy of songs by Drake.
- `8.sql` — songs that contain "feat." (feature other artists).
- `answers.txt` — written reflection about "Spotify Wrapped" audio aura.
- `songs.db` — (NOT included in this repo if you prefer; add locally) — the SQLite database used for queries.

## How to run (locally or in CS50 IDE)
1. Place `songs.db` in this repository folder.
2. To run a single query with headers:
sqlite3 -header -column songs.db < 1.sql

3. To run all queries and print outputs:


for f in 1.sql 2.sql 3.sql 4.sql 5.sql 6.sql 7.sql 8.sql; do
echo "=== $f ==="

sqlite3 -header -column songs.db < "$f"
done






cat > README.md <<'MARKDOWN'
# CS50 SQL Problem Set: movies.db

This repository contains solutions for CS50's Problem Set on SQL queries using the movies.db database.

## Files
- `1.sql` through `13.sql` — SQL queries solving each problem.
- `answers.txt` — reflections or written answers if required.
- `movies.db` — database used for testing (not to be submitted).

## How to Run
In your terminal with SQLite3 installed:

```bash
sqlite3 -header -column movies.db < 1.sql

Replace 1.sql with any other query file to test.





The Fiftyville Duck Mystery 
This repository contains my solution for CS50's Problem Set 7: Fiftyville. The project's goal was to solve a fictional crime using only SQL queries on a provided SQLite database.

The Crime
The CS50 Duck was stolen! The theft occurred on July 28, 2024, at 10:15 a.m. on Humphrey Street. Authorities believe the thief, with the help of an accomplice, escaped town shortly after the crime.

The Mission
My task was to act as a detective and use the provided fiftyville.db database to identify:

The thief.

The city the thief escaped to.

The accomplice who helped them escape.

My Investigative Process
My investigation was a systematic process of deduction using SQL queries. I started with the most basic information and followed the clues found in witness interviews, security logs, and transaction records. My approach involved:

Initial Analysis: Querying crime_scene_reports and interviews tables to get the foundational clues.

Narrowing Suspects: Using bakery_security_logs, atm_transactions, and phone_calls to create a shortlist of suspects who matched the eyewitness accounts.

Identifying the Culprits: Running complex JOIN queries to find the single person who fit all the criteria.

Tracking the Escape: Consulting the flights and airports tables to determine the thief's escape route and destination.

Files Included
log.sql: A detailed log of every SQL query I ran, with comments explaining my thought process and the purpose of each query. This file serves as evidence of my investigative work.

answers.txt: The final solution to the mystery, containing the names of the thief and the accomplice, and the escape city.

fiftyville.db: The SQLite database used to solve the mystery (provided by CS50).
