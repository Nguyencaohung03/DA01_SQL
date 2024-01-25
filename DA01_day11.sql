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


-----MID COURSE TEST
--Q1
select DISTINCT(replacement_cost)
from film
order by replacement_cost
--Q2
select
Count(case 
  when replacement_cost between 9.99 and 19.99 then 'low' 
end) as low,
Count(case
  when replacement_cost between 20.00 and 24.99 then 'medium'
end)as medium,
Count(case
  when replacement_cost between 25.00 and 29.99 then 'high'	
end)as high
from film
group by case 
  when replacement_cost between 9.99 and 19.99 then 'low' 
  when replacement_cost between 20.00 and 24.99 then 'medium'
  when replacement_cost between 25.00 and 29.99 then 'high'	
end
--Q3
select a.title, a.length, b.category_id, c.name
from film as a
Join film_category as b on a.film_id=b.film_id
join category as c on b.category_id=c.category_id
where c.name = 'Drama' or c.name= 'Sports'
order by a.length DESC
--Q4
select a.category_id, Count(b.title), c.name
from film_category as a
join film as b on a.film_id=b.film_id
join category as c on a.category_id=c.category_id
group by a.category_id,c.name
order by Count(b.title)DESC
--Q5
select a.actor_id, a.first_name, a.last_name, Count(b.film_id)
from actor as a
join film_actor as b on a.actor_id=b.actor_id
group by a.actor_id
order by Count(b.film_id) DESC
--Q6
select d.city, Sum(a.amount)
from payment as a
join customer as b on a.customer_id=b.Customer_id
join address as c on b.address_id=c.address_id
join city as d on c.city_id=d.city_id
group by d.city
order by Sum(a.amount) DESC
--Q7
select d.city, Sum(a.amount)
from payment as a
join customer as b on a.customer_id=b.Customer_id
join address as c on b.address_id=c.address_id
join city as d on c.city_id=d.city_id
group by d.city
order by Sum(a.amount) DESC
--Q8
select d.city, Sum(a.amount)
from payment as a
join customer as b on a.customer_id=b.Customer_id
join address as c on b.address_id=c.address_id
join city as d on c.city_id=d.city_id
group by d.city
order by Sum(a.amount) (DESC)







