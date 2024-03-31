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
--Món nào được mua nhiều nhất và được mua bao nhiêu lần
select m.product_name,
count(distinct s.order_date) as count_order
from menu as m
join sales as s on m.product_id = s.product_id
group by m.product_name
order by count_order DESC
--Món nào được khách hàng mua đầu tiên sau khi trở thành thành viên
select e.customer_id , e.join_date,
m.product_name
from members as e
Left join sales as s on e.customer_id= s.customer_id
Left join menu as m on s.product_id= m.product_id
group by e.customer_id , e.join_date
--Món nào được khách hàng mua ngay trước khi trở thành thành viên

