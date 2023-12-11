--ex1
select 
round(100*sum(case when b.min_order_date = b.min_delivery_date then 1 else 0 end)/count(*), 2)
as immediate_percentage
from (
  select min(order_date) as min_order_date, min(customer_pref_delivery_date) as min_delivery_date
  from delivery
  group by customer_id
) b
--ex2
select 
Round(count(case when first_event_date +1= second_day then player_id end) 
    / count(distinct player_id),2) 
as fraction  
from
(
select player_id, device_id,
first_value(event_date)over(partition by player_id order by event_date) as first_event_date,
Lead(event_date)over(partition by player_id order by event_date) as second_day
from Activity
) as cte
--ex3
with twt as 
(
select 
id, student,
Lag(student,1)over(order by id) as odd,
Lead(student,1)over(order by id) as even
from Seat
)
select id,
case
when id%2=0 then odd
when even is null then student
else even
end as student
from twt
--ex4
with twt as 
(
select visited_on, 
sum(amount) as total
from Customer 
group by visited_on
)
select visited_on,
sum(total) over(order by visited_on rows 6 preceding) AS amount,
round(avg(total) over(order by visited_on rows 6 preceding), 2) AS average_amount
from twt
Limit 100 offset 6
--ex5

--ex6

--ex7

--ex8
with cte1 as
(select 
product_id,  max(new_price) as price
from Products
where change_date <= '2019-08-16'
group by product_id)
,cte2 as 
(select 
product_id,  10 as price
from Products
where change_date > '2019-08-16'
group by product_id)

select distinct product_id, price
from cte1
union all
select distinct product_id, price
from cte2
WHERE NOT EXISTS (SELECT product_id from cte1 
                 WHERE cte2.product_id = cte1.product_id)
