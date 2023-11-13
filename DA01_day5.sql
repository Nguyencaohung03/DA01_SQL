--ex1
select distinct CITY 
from STATION
where ID%2 = 0
order by CITY
--ex2
select COUNT(CITY) - COUNT(Distinct CITY) from STATION
--ex3
select
ceil(avg(salary)-avg(replace(salary,0,'')))
from EMPLOYEES
--ex4
SELECT Round (CAST(SUM(item_count * order_occurrences)/SUM(order_occurrences) AS DECIMAL),1) AS mean 
FROM items_per_order
--ex5 
SELECT candidate_id
FROM candidates
where skill in ('Python', 'Tableau', 'PostgreSQL')
group by candidate_id
having COUNT(skill) =3 
--ex6
SELECT user_id,
DATE(MAX(post_date)) - Date(MIN(post_date)) AS days_between
FROM posts
where post_date > '2021-01-01' and  post_date < '2022-01-01'
GROUP BY user_id 
having DATE(MAX(post_date)) - Date(MIN(post_date)) >=2
--ex7
SELECT card_name,
MAX(issued_amount) - MIN(issued_amount) as difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY difference DESC
--ex8
SELECT manufacturer,
COUNT(drug) as drug_count,
abs (SUM((cogs-total_sales))) as total_loss
FROM pharmacy_sales
where total_sales < cogs
GROUP BY manufacturer
order by total_loss DESC
--ex9
select *
from Cinema
where id%2 =1
and description <> 'boring'
order by rating DESC
--ex10
select teacher_id,
Count(DISTINCT subject_id ) as cnt
from Teacher
group by teacher_id
order by teacher_id
--ex11
select user_id,
Count(follower_id) as followers_count
from Followers
group by user_id
order by user_id  
--ex12
select class
from Courses
group by class
having Count(student) >= 5











