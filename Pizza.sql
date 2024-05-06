--Số lượng đơn pizza đã bán
select 
Count(DISTINCT pizza_id)
from customer_orders
--Số lượng đơn hàng 
select customer_id,
Count(DISTINCT order_id) as total_orders
from customer_orders
group by customer_id
--Số  lượngđơn hàng hoàn thành của mỗi runners
select runner_id,
Count(DISTINCT order_id) as "Completed Orders"
from runner_orders
where pickup_time NOTNULL
group by runner_id
--Số lượng pizza đã được giao
select b.pizza_id,
Count(DISTINCT a.order_id) as "Completed Pizza Orders"
from runner_orders as a 
join customer_orders  as b on  a.order_id = b.order_id
where a.pickup_time NOTNULL
group by b.pizza_id
  
--Số  lượng pizza Vegetarian và Meatlovers theo mỗi khách hàng
with meat AS
(
select customer_id,
case 
  when pizza_id = 1 then Count(DISTINCT order_id) 
  else 0
End as "No_MeatLovers"
from customer_orders 
group by customer_id )
, vege AS
(
select customer_id,
case 
  when pizza_id = 2 then Count(DISTINCT order_id) 
  else 0
End as "No_Vegetarian"
from customer_orders 
group by customer_id
)
Select a.customer_id, a.No_MeatLovers, b.No_Vegetarian
from meat as a 
join vege as b on a.customer_id = b.customer_id
group by  a.customer_id
--Số lượng pizza nhiều nhấ được giao trong 1 đơn
select order_id, 
Count(pizza_id) as "Total_pizza",
DENSE_RANK() Over(Order by Count(pizza_id) DESC) as Rank
from customer_orders
group by order_id


