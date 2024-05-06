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
