--ex1
WITH company as
(SELECT company_id
FROM job_listings
group by company_id, title, description
having count(*) > 1)
SELECT count(*) as duplicate_companies
FROM company
--ex2

--ex3
with twt_callers as (SELECT policy_holder_id,count(call_duration_secs)
FROM callers
group by policy_holder_id
having count(call_duration_secs)>=3)
SELECT count(policy_holder_id) FROM twt_callers
--ex4
SELECT 
a.page_id
FROM pages as a
Left join page_likes as b 
on a.page_id=b.page_id
where b.liked_date is NULL
order by page_id 
--ex5
select 
  EXTRACT(month from event_date) as month,
  count(distinct user_id) as monthly_active_users
from user_actions
where user_id in (select distinct user_id from user_actions 
 where EXTRACT(month from event_date) = 6) 
 and EXTRACT(month from event_date) = 7 
 and event_type in ('sign-in','like','comment')
 and EXTRACT(year from event_date) = 2022
group by EXTRACT(month from event_date) 
--ex6
select  
DATE_FORMAT(trans_date, '%Y-%m') AS month, country,
count(id) as trans_count, 
sum(case
when state = 'approved' then 1
else 0
end) as approved_count,
sum(amount) as trans_total_amount,
sum(case
when state = 'approved' then amount
else 0
end) as approved_total_amount
from Transactions
group by DATE_FORMAT(trans_date, '%Y-%m'), country
--ex7
WITH twt_product_first_year as 
(select product_id, min(year) as first_year
from Sales
group by product_id)
select a.product_id, b.first_year, a.quantity, a.price
from Sales as a
join twt_product_first_year as b on a.product_id=b.product_id
and a.year=b.first_year
--ex8
SELECT customer_id
FROM customer
group by customer_id
having Count(DISTINCT product_key) = (SELECT
Count(DISTINCT product_key)
FROM product)
--ex9
select emp.employee_id
from Employees as emp
left join Employees as mng on emp.manager_id= mng.employee_id
where emp.salary < 30000
and emp.manager_id is not null
and mng.employee_id is null
--ex10
select employee_id, department_id 
from Employee
where primary_flag = 'Y' OR employee_id not in
(select employee_id from Employee 
where primary_flag = 'Y')
--ex11

--ex12





