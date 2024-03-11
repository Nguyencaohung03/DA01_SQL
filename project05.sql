--Tổng số tiền mỗi khách hàng chi tiêu tại nhà hàng là bao nhiêu?
select a.customer_id,
SUM(b.price) as total_amount
from sales a 
join menu as b on a.product_id=b.product_id
group by a.customer_id
order by SUM(b.price) DESC
--Mỗi KH đã ghé thăm bn ngày
SELECT customer_id,
count(distinct order_date) as so_ngay
FROM sales 
group by customer_id;
--Món đầu tiên trong thực đơn mà mỗi KH mua
select a.customer_id,
b.product_name
from sales a 
join menu as b on a.product_id=b.product_id
group by a.customer_id
list 1
--Món được mua nhiều nhất trong thực đơn và  được mua bn lần
select a.product_name,
MAX(count(b.product_id)) as count_product
from menu a 
join sales b on a.product_id=b.product_id
group by a.product_name
