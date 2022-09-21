-- Keep a log of any SQL queries you execute as you solve the mystery.

-- Get details from the crime scene report of the day and time that the crime took place
 SELECT description
   ...> FROM crime_scene_reports
   ...> WHERE month = 7 AND day = 28 AND year = 2020 AND street = 'Chamberlin Street';

-- Get the information from the interviews table pertaining to the transscript of their interviews at the courthouse

SELECT transcript
   ...> FROM interviews
   ...> WHERE month = 7 AND day = 28 AND year = 2020 AND transcript LIKE "%courthouse%";

-- Transscript Text "Sometime within ten minutes of the theft,
--I saw the thief get into a car in the courthouse parking lot and drive away.
--If you have security footage from the courthouse parking lot,
--you might want to look for cars that left the parking lot in that time frame."

-- Get the name of the suspects from the courthouse security logs

SELECT name
FROM people
JOIN courthouse_security_logs ON people.license_plate = courthouse_security_logs.license_plate
WHERE month = 7 AND day = 28 and YEAR = 2020 AND hour = "10" AND minute >= "15" AND minute  < "25" AND activity = "exit";

-- List of potential suspects = Patrick, Ernest, Amber, Danielle, Roger, Elizabeth, Russell, and Evelynn

-- second transcript: "i dont know the theifs name but it was someone i recognized. Earlier this morning,
-- Before i arrived at the courthouse, i was walking by the ATM on Fifer Street and saw the theif there withdrawing some money"

SELECT DISTINCT name
   ...> FROM people
   ...> JOIN bank_accounts ON people.id = bank_accounts.person_id
   ...> JOIN atm_transactions ON bank_accounts.account_number = atm_transactions.account_number
   ...> WHERE month = 7 AND day = 28 AND year = 2020 AND transaction_type = "withdraw" AND atm_location = "Fifer Street";

-- List of new suspect names: Danielle, Bobby, Madison, Ernest, Roy, Elizabeth, Victoria, Russell

-- Exclude suspects that dont appear in both querys
-- New lsit of suspects: Ernest, Danielle, Elizabeth, Russell

-- Text from the thrid transcript: as the theif was leaving the courthouse, they caled someone that talked to them for les than a minute
-- In the call, i heard the theif say that they were planning to take the earliest flight out of fiftyville tomorrow,
-- the theif then asked the person on the other end of the phone to purchase the flight ticket.

-- Get the passengers from the flight with a query

SELECT name
   ...> FROM people
   ...> JOIN passengers ON people.passport_number = passengers.passport_number
   ...> WHERE flight_id = (
   ...> SELECT id
   ...> FROM flights
   ...> WHERE month = 7 AND day = 29 AND year = 2020
   ...> ORDER BY hour, minute
   ...> LIMIT 1);

-- name of passengers on the flight: Doris, Roger, Ernest, Edward, Evelyn, Madison, Bobby, Danielle
-- Check which names appears in the 2 querys before and appeared in the 3rd query
-- List of suspects from all 3 querys: Ernest, Danielle

-- create query to find out which of the two suspects made the phonecall to the accomplace

SELECT DISTINCT name
   ...> FROM people
   ...> JOIN phone_calls ON people.phone_number = phone_calls.caller
   ...> WHERE month = 7 AND day = 28 AND year = 2020 AND duration < 60;

-- suspects from phone call query: Roger, Evelyn, Ernest, Madison, Russell, Kimberly, Bobby, Victoria
-- Main suspect from all 4 queries: Ernest

-- find out where the theif ernest escaped to on his plane flight out of fiftyville

SELECT city
   ...> FROM airports
   ...> WHERE id = (
   ...> SELECT destination_airport_id
   ...> FROM flights
   ...> WHERE month = 7 AND day = 29 AND year = 2020
   ...> ORDER BY hour, minute
   ...> LIMIT 1);

-- Ernest escaped to London

-- Find out who Ernest's accomplace is

SELECT name
   ...> FROM people
   ...> JOIN phone_calls on people.phone_number = phone_calls.receiver
   ...> WHERE month = 7 AND day = 28 AND year = 2020 AND duration < 60 AND caller = (
   ...> SELECT phone_number
   ...> FROM people
   ...> WHERE name = "Ernest");

-- Ernests accomplace is Berthold