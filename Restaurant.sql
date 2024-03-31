--Tổng số tiền mối KH chi tiêu tại nhà hàng
select s.customer_id, 
sum(m.price) as amount
from sales as s 
join menu as m on s.product_id= m.product_id 
group by s.customer_id
--Mối  KH đã ghé thăm nhà hàng bao nhiêu ngày
select customer_id, 
Count(Distinct order_date) as count_date
from sales 
group by customer_id
--Món đầu tiên trong thực đơn mỗi KH mua 
Select customer_id, product_name
FROM
(
select s.customer_id, s.order_date,
m.product_name,
ROW_Number() over (Partition by s.customer_id Order by s.order_date, m.product_name) as row_num
from sales as s 
join menu as m on s.product_id= m.product_id
group by s.customer_id, s.order_date, m.product_name
)
Where row_num =1 
