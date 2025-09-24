-- I am starting my investigation by examining the crime scene reports for the specified date and location: July 28, 2024, on Humphrey Street.
--SELECT description
FROM crime_scene_reports
WHERE year = 2024
AND month = 7
AND day = 28
AND street = 'Humphrey Street';

The report mentioned interviews with three witnesses on the same day.
-- I'm querying the interviews table to get their transcripts, which should provide more specific leads.
SELECT transcript
FROM interviews
   ...> WHERE year = 2024
   ...> AND month = 7
   ...> AND day = 28;

   The results I get = Jose    | “Ah,” said he, “I forgot that I had not seen you for some weeks. It is a little souvenir from the King of Bohemia in return for my assistance in the case of the Irene Adler papers.”                                                                                                                               |
| Eugene  | “I suppose,” said Holmes, “that when Mr. Windibank came back from France he was very annoyed at your having gone to the ball.”                                                                                                                                                                                      |
| Barbara | “You had my note?” he asked with a deep harsh voice and a strongly marked German accent. “I told you that I would call.” He looked from one to the other of us, as if uncertain which to address.                                                                                                                   |
| Ruth    | Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.                                                          |
| Eugene  | I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.                                                                                                 |
| Raymond | As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket. |
| Lily    | Our neighboring courthouse has a very annoying rooster that crows loudly at 6am every day. My sons Robert and Patrick took the rooster to a city far, far away, so it may never bother us again. My sons have successfully arrived in Paris.
                                                                  |

A witness transcript mentioned the thief leaving the bakery on Humphrey Street around 10:15 a.m. in a car.
-- I'm checking the bakery security logs for all cars that left between 10:15 a.m. and 10:25 a.m. to identify potential suspects by their license plates.
SELECT license_plate
FROM bakery_security_logs
   ...> WHERE year = 2024
   ...> AND month = 7
   ...> AND day = 28
   ...> AND hour = 10
   ...> AND minute >= 15
   ...> AND minute <= 25; -- A small window around the time of the crime

    license_plate |
+---------------+
| 5P2BI95       |
| 94KL13X       |
| 6P58WS2       |
| 4328GD8       |
| G412CB7       |
| L93JTIZ       |
| 322W7JE       |
| 0NTHK55


 Another witness mentioned the thief making a phone call shortly after leaving the bakery.
-- I'm looking for phone calls made on July 28, 2024, with a duration of less than 60 seconds.

SELECT caller, receiver
   ...> FROM phone_calls
   ...> WHERE year = 2024
   ...> AND month = 7
   ...> AND day = 28
   ...> AND duration < 60;
+----------------+----------------+
|     caller     |    receiver    |
+----------------+----------------+
| (130) 555-0289 | (996) 555-8899 |
| (499) 555-9472 | (892) 555-8872 |
| (367) 555-5533 | (375) 555-8161 |
| (499) 555-9472 | (717) 555-1342 |
| (286) 555-6063 | (676) 555-6554 |
| (770) 555-1861 | (725) 555-3243 |
| (031) 555-6622 | (910) 555-3251 |
| (826) 555-1652 | (066) 555-9701 |
| (338) 555-6650 | (704) 555-2131 |
+----------------+----------------+


 A third witness mentioned the thief withdrawing money from an ATM on Leggett Street on the day of the theft.
-- I'm querying the atm_transactions table to find the account numbers involved in a 'withdraw' transaction at that location and date.

SELECT account_number
   ...> FROM atm_transactions
   ...> WHERE year = 2024
   ...> AND month = 7
   ...> AND day = 28
   ...> AND atm_location = 'Leggett Street'
   ...> AND transaction_type = 'withdraw';
+----------------+
| account_number |
+----------------+
| 28500762       |
| 28296815       |
| 76054385       |
| 49610011       |
| 16153065       |
| 25506511       |
| 81061156       |
| 26013199       |
+----------------+


I now have three lists of potential suspects based on their license plates, phone calls, and ATM transactions.
-- I will join these clues to identify the single person who matches all three criteria. This person is the thief.
SELECT p.name
   ...> FROM people p
   ...> JOIN bakery_security_logs b ON p.license_plate = b.license_plate
   ...> JOIN phone_calls pc ON p.phone_number = pc.caller
   ...> JOIN bank_accounts ba ON p.id = ba.person_id
   ...> JOIN atm_transactions a ON ba.account_number = a.account_number
   ...> WHERE b.year = 2024 AND b.month = 7 AND b.day = 28 AND b.hour = 10 AND b.minute >= 15 AND b.minute <= 25
   ...> AND pc.year = 2024 AND pc.month = 7 AND pc.day = 28 AND pc.duration < 60
   ...> AND a.year = 2024 AND a.month = 7 AND a.day = 28 AND a.atm_location = 'Leggett Street' AND a.transaction_type = 'withdraw';
+-------+
| name  |
+-------+
| Bruce |
| Diana |
+-------+

The thief took the earliest flight out of Fiftyville the day after the theft.
-- First, I'm finding the ID of the Fiftyville airport.

SELECT id, destination_airport_id
   ...> FROM flights
   ...> WHERE origin_airport_id = (SELECT id FROM airports WHERE city = 'Fiftyville')
   ...> AND year = 2024
   ...> AND month = 7
   ...> AND day = 29
   ...> ORDER BY hour, minute
   ...> LIMIT 1;
+----+------------------------+
| id | destination_airport_id |
+----+------------------------+
| 36 | 4

Next, I'm finding the earliest flight from Fiftyville on July 29, 2024.
-- The flight's destination_airport_id will tell me where the thief escaped to.



sqlite> SELECT city
   ...> FROM airports
   ...> WHERE id = (
   ...>     SELECT destination_airport_id
   ...>     FROM flights
   ...>     WHERE origin_airport_id = (SELECT id FROM airports WHERE city = 'Fiftyville')
   ...>     AND year = 2024
   ...>     AND month = 7
   ...>     AND day = 29
   ...>     ORDER BY hour, minute
   ...>     LIMIT 1
   ...> );
+---------------+
|     city      |
+---------------+
| New York City |
+---------------+


 Finally, I'm identifying the thief's accomplice. The accomplice is the person the thief called.
-- I will use the thief's phone number to find the receiver of that short call and then look up the receiver's name.



SELECT name
   ...> FROM people
   ...> WHERE phone_number = (
   ...>     SELECT receiver
   ...>     FROM phone_calls
   ...>     WHERE year = 2024
   ...>     AND month = 7
   ...>     AND day = 28
   ...>     AND duration < 60
   ...>     AND caller = (
   ...>         SELECT phone_number
   ...>         FROM people
   ...>         WHERE id IN (
   ...>             SELECT person_id
   ...>             FROM bank_accounts
   ...>             WHERE account_number IN (
   ...>                 SELECT account_number
   ...>                 FROM atm_transactions
   ...>                 WHERE year = 2024
   ...>                 AND month = 7
   ...>                 AND day = 28
   ...>                 AND atm_location = 'Leggett Street'
   ...>                 AND transaction_type = 'withdraw'
   ...>             )
   ...>         )
   ...>         AND license_plate IN (
   ...>             SELECT license_plate
   ...>             FROM bakery_security_logs
   ...>             WHERE year = 2024
   ...>             AND month = 7
   ...>             AND day = 28
   ...>             AND hour = 10
   ...>             AND minute >= 15
   ...>             AND minute <= 25
   ...>         )
   ...>     )
   ...> );
sqlite> SELECT name FROM people WHERE phone_number = (
   ...>     SELECT receiver FROM phone_calls
   ...>     WHERE year = 2024 AND month = 7 AND day = 28 AND duration < 60 AND caller = (
   ...>         SELECT phone_number FROM people WHERE id IN (
   ...>             SELECT person_id FROM bank_accounts WHERE account_number IN (
   ...>                 SELECT account_number FROM atm_transactions
   ...>                 WHERE year = 2024 AND month = 7 AND day = 28 AND atm_location = 'Leggett Street' AND transaction_type = 'withdraw'
   ...>             )
   ...>         ) AND license_plate IN (
   ...>             SELECT license_plate FROM bakery_security_logs
   ...>             WHERE year = 2024 AND month = 7 AND day = 28 AND hour = 10 AND minute >= 15 AND minute <= 25
   ...>         )
   ...>     )
   ...> );
sqlite> SELECT name FROM people WHERE id IN (
   ...>     SELECT person_id FROM bank_accounts WHERE account_number IN (
   ...>         SELECT account_number FROM atm_transactions
   ...>         WHERE year = 2024 AND month = 7 AND day = 28 AND atm_location = 'Leggett Street' AND transaction_type = 'withdraw'
   ...>     )
   ...> ) AND license_plate IN (
   ...>     SELECT license_plate FROM bakery_security_logs
   ...>     WHERE year = 2024 AND month = 7 AND day = 28 AND hour = 10 AND minute >= 15 AND minute <= 25
   ...> );
+-------+
| name  |
+-------+
| Iman  |
| Luca  |
| Diana |
| Bruce |
+-------+

sqlite> SELECT * FROM phone_calls WHERE caller = ' (499) 555-9472 | (892) 555-8872 ' AND year = 2024 AND month = 7 AND day = 28 AND duration < 60;
sqlite> SELECT * FROM phone_calls WHERE caller IN ('(130) 555-0289', '(996) 555-8899') AND year = 2024 AND month = 7 AND day = 28 AND duration < 60;
+-----+----------------+----------------+------+-------+-----+----------+
| id  |     caller     |    receiver    | year | month | day | duration |
+-----+----------------+----------------+------+-------+-----+----------+
| 221 | (130) 555-0289 | (996) 555-8899 | 2024 | 7     | 28  | 51       |
+-----+----------------+----------------+------+-------+-----+----------+
sqlite> SELECT name FROM people WHERE phone_number = '(375) 555-8161';
+-------+
| name  |
+-------+
| Robin |
+-------+
