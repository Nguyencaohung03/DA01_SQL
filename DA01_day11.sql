--ex1
select a.CONTINENT,
Floor(avg(b.POPULATION))
from COUNTRY as a
inner join CITY as b on a.CODE=b.COUNTRYCODE
Group by a.CONTINENT
--ex2
SELECT 
Round(Sum(CASE 
WHEN b.signup_action = 'Confirmed' THEN 1
ELSE 0
END)/Count(b.signup_action)::decimal,2)
FROM emails as a
inner join texts as b on a.email_id=b.email_id
--ex3
SELECT age_bucket,
ROUND(100*SUM(CASE WHEN activity_type = 'send' THEN time_spent END)::decimal/SUM(CASE WHEN activity_type = 'send' or activity_type = 'open' THEN time_spent END)::decimal,2) AS send,
ROUND(100*SUM(CASE WHEN activity_type = 'open' THEN time_spent END)::decimal/SUM(CASE WHEN activity_type = 'send' or activity_type = 'open' THEN time_spent END)::decimal,2) AS open
FROM activities
JOIN age_breakdown
ON age_breakdown.user_id = activities.user_id
GROUP BY age_bucket
--ex4
SELECT a.customer_id
FROM customer_contracts as a
Left join products as b
on a.product_id=b.product_id
group by a.customer_id
having COUNT(DISTINCT b.product_category) = 3









