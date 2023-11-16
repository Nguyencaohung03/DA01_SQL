--ex1 
select Name
from STUDENTS
where Marks > 75
Order BY Right(Name, 3), ID
--ex2
select user_id,
concat(Upper(Left(name, 1)), Lower(right(name, Length(name)-1))) as name
from Users
  
  ---- Câu này e dùng || thì output ra =0 là lỗi ntn ạ

--ex3
SELECT 
manufacturer,
'$'|| Round(Sum(total_sales)/1000000)|| ' ' || 'million'  as sale
FROM pharmacy_sales
group by manufacturer
order by Sum(total_sales) DESC,  manufacturer
--ex4
SELECT 
extract(month from submit_date) as mth, 
product_id as product,
round(AVG(stars), 2) as avg_stars
FROM reviews
group by product_id, extract(month from submit_date)
order by extract(month from submit_date), product_id
--ex5
SELECT sender_id,
Count(message_id)
FROM messages
where extract(month from sent_date) = 8
and extract(year from sent_date) = 2022
group by sender_id
order by sum(message_id) DESC
limit 2
--ex6
select tweet_id
from Tweets 
where length(content) > 15
--ex7 
select 
activity_date as day, 
count(distinct(user_id)) as active_users 
from Activity
where activity_date between "2019-06-28" and "2019-07-27"
group by activity_date
  ----câu này e tham khảo google, tắc lệnh count
--ex8
select 
count(id) as number_employee
from employees
where extract(month from Joining_date) between 1 and 7
and  extract(year from Joining_date) = 2022
--ex9
select 
Position('Amitah' in first_name)
from worker
where first_name = 'Amitah'
--ex10
select 
substring(title, length(winery)+2,4)
from winemag_p2
where country = 'Macedonia'
















