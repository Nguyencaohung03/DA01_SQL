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
SELECT b.age_bucket,
ROUND(100*SUM(CASE 
  when activity_type = 'send' then time_spent 
end)::decimal/SUM(CASE 
  when activity_type = 'send' or activity_type = 'open' then time_spent 
end)::decimal,2) AS send,
ROUND(100*SUM(CASE
  when activity_type = 'open' then time_spent
end)::decimal/SUM(CASE 
  when activity_type = 'send' or activity_type = 'open' then time_spent 
end)::decimal,2) AS open
FROM activities as a
JOIN age_breakdown as b
ON a.user_id = b.user_id
GROUP BY age_bucket
--ex4
SELECT a.customer_id
FROM customer_contracts as a
Left join products as b
on a.product_id=b.product_id
group by a.customer_id
having COUNT(DISTINCT b.product_category) = 3
--ex5
select emp.employee_id, emp.name,
count(mng.reports_to) as reports_count,
Floor(avg(emp.age)) as average_age
from Employees as emp
left join Employees as mng 
on emp.employee_id =mng.employee_id 
--ex6
Select a.product_name, sum(b.unit) as unit
from Products as a
Join Orders as b
on a.product_id=b.product_id
where extract(month from order_date) =2
and extract(year from order_date) =2020
group by a.product_name
having sum(b.unit) >=100
--ex7
SELECT 
a.page_id
FROM pages as a
Left join page_likes as b 
on a.page_id=b.page_id
where b.liked_date is NULL
order by page_id 








