--Số lượng đơn hàng và số lượng khách hàng mỗi tháng
select
FORMAT_DATE('%Y-%m', created_at) as month_year,
sum(user_id) as total_user, 
sum(order_id) as total_order 
from bigquery-public-data.thelook_ecommerce.orders
where FORMAT_DATE('%Y-%m', created_at) < '2022-05'
group by FORMAT_DATE('%Y-%m', created_at)
order  by 1
   --Insight: xu hướng khách hàng và số lượng đơn hàng có xu hướng tăng theo thời gian, tăng nhiều nhất những tháng đầu năm
--Giá trị đơn hàng trung bình (AOV) và số lượng khách hàng mỗi tháng
select
FORMAT_DATE('%Y-%m', a.created_at) as month_year,
a.user_id as distinct_users, 
Round(sum(b.sale_price)/count(a.order_id),2) as average_order_value
from bigquery-public-data.thelook_ecommerce.orders a
join bigquery-public-data.thelook_ecommerce.order_items b on a.user_id=b.user_id
where FORMAT_DATE('%Y-%m', a.created_at) < '2022-05'
group by a.user_id, FORMAT_DATE('%Y-%m', a.created_at)
order  by 1
   --Insight: Giá trị đơn hàng biến động không đều theo từng khách hàng mỗi tháng
--Nhóm khách hàng theo độ tuổi
with cte as
(SELECT
first_name,
last_name,
gender,
'oldest' as tag ,
MIN(age) OVER(PARTITION BY gender) AS age
FROM `bigquery-public-data.thelook_ecommerce.users` 
WHERE DATE(created_at) BETWEEN '2019-01-01' AND '2022-04-30'
AND age IN (SELECT MIN(age) 
             FROM `bigquery-public-data.thelook_ecommerce.users`)
UNION ALL
SELECT
first_name,
last_name,
gender,
'youngest' as tag ,
MAX(age) OVER(PARTITION BY gender) AS age
FROM `bigquery-public-data.thelook_ecommerce.users` 
WHERE DATE(created_at) BETWEEN '2019-01-01' AND '2022-04-30'
AND age IN (SELECT MAX(age) 
             FROM `bigquery-public-data.thelook_ecommerce.users`)
ORDER BY age)

 SELECT gender,age,tag, COUNT(*)
 FROM cte
 GROUP BY gender, age, tag
    /* Insight: 
Nam: độ tuổi trẻ nhất là 12,có 546 KH; độ tuổi lớn nhất  là 70 có 529 KH
Nữ: độ tuổi trẻ nhất 12 có 525 KH;độ tuuooir lớn nhất   là 70 có 569 KH */

--Top 5 sản phẩm mỗi tháng.

--Doanh thu tính đến thời điểm hiện tại trên mỗi danh mục
