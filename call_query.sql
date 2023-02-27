CREATE DATABASE calls

USE calls

--Reading the complete data
SELECT * FROM call

--Shape of Data 
SELECT COUNT(*) AS rows_numb 
FROM call

SELECT COUNT(*) AS columns_numb 
FROM information_schema.columns 
WHERE table_name = 'call'  

--Checking the distinct values

SELECT DISTINCT sentiment FROM call  
SELECT COUNT(DISTINCT sentiment) FROM call

SELECT DISTINCT reason FROM call
SELECT DISTINCT channel FROM call
SELECT DISTINCT response_time FROM call
SELECT DISTINCT call_center FROM call

--Count and Percentage of each of the distinct values we got

--Distribution of calls across sentiment 
SELECT sentiment, COUNT(*) AS sentiment_numb, 
ROUND((COUNT (*) * 100/ (SELECT COUNT(*) FROM call)), 1) AS sentiment_pct
FROM call
GROUP BY sentiment 
ORDER BY sentiment_pct ASC

--Distribution of calls across reasons
SELECT reason, COUNT(*) AS reason_numb,
ROUND((COUNT(*) * 100/ (SELECT COUNT(*) FROM call)), 1) AS reason_pct
FROM call
GROUP BY reason
ORDER BY reason_pct ASC

--Distribution of calls across channels
SELECT channel, COUNT(*) AS channel_numb,
ROUND((COUNT(*) * 100/ (SELECT COUNT (*) FROM call)), 1) AS channel_pct
FROM call
GROUP BY channel
ORDER BY channel_pct DESC

----Distribution of calls across response time
SELECT response_time, COUNT(*) AS responsetime_numb, 
ROUND((COUNT (*) * 100/ (SELECT COUNT(*) FROM call)), 1) AS responsetime_pct
FROM call
GROUP BY response_time 
ORDER BY responsetime_pct ASC

--Distribution of calls across call centers
SELECT call_center, COUNT(*) AS call_center_numb, 
ROUND((COUNT (*) * 100/ (SELECT COUNT(*) FROM call)), 1) AS call_center_pct
FROM call
GROUP BY call_center 
ORDER BY call_center_pct ASC

SELECT * FROM call

--Checking the day corresponding to call_timestamp

SELECT
FORMAT(CAST(call_timestamp AS DATE), 'ddd') AS call_day
FROM call

SELECT call_timestamp, DATENAME(WEEKDAY, call_timestamp) AS day_of_call,
COUNT(*) AS call_num
FROM call
GROUP BY call_timestamp
ORDER BY call_num DESC


--Aggregators

-- Minimum, Maximum and Average values of csat_score
SELECT MIN(csat_score) AS min_score,
MAX(csat_score) AS  max_score,
ROUND(AVG(csat_score), 1) AS avg_score
FROM call
WHERE csat_score IS NOT NULL

--Ealiest and most recent date of call being made
SELECT MIN(call_timestamp) AS earliest_date,
MAX(call_timestamp) AS recent_date
FROM call

--Minimum and Maximum values of duration of call
SELECT MIN(call_duration_in_minutes) AS min_call_duration,
MAX(call_duration_in_minutes) AS max_call_duration
FROM call

-- DIstribution of response time across call center
SELECT call_center, response_time,
COUNT(*) AS count
FROM call
GROUP BY call_center, response_time
ORDER BY count DESC

-- Average duration of call with each call center 
SELECT call_center,
AVG(call_duration_in_minutes) AS avg_call_duration
FROM call
GROUP BY call_center
ORDER BY avg_call_duration DESC

--Average distribution of call with each channel
SELECT channel,
AVG(call_duration_in_minutes) AS avg_call_duration
FROM call
GROUP BY channel
ORDER BY avg_call_duration DESC

--Distribution of calls across states 
SELECT state, COUNT(*) as count
FROM call
GROUP BY state
ORDER BY count DESC

--Distribution of calls with state and reason
SELECT state, reason, 
COUNT(*) AS count
FROM call
GROUP BY state, reason
ORDER BY state, reason, count

--Average csat score with each state
SELECT state,
AVG(csat_score) AS avg_csat_score
FROM call
WHERE csat_score IS NOT NULL
GROUP BY state
ORDER BY avg_csat_score

--Average duration of call with each sentiment 
SELECT sentiment,
AVG(call_duration_in_minutes) AS avg_call_duration
FROM call
GROUP BY sentiment
ORDER BY avg_call_duration

--Maximum duration of call with each timestamp

SELECT call_timestamp,
MAX(call_duration_in_minutes) as max_call_duration
FROM call
GROUP BY call_timestamp
ORDER BY max_call_duration DESC

SELECT call_timestamp,
MAX(call_duration_in_minutes) 
OVER(PARTITION BY call_timestamp) AS max_call_duration
FROM call
ORDER BY max_call_duration DESC


