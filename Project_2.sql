--Số lượng đơn hàng và số lượng khách hàng mỗi tháng
select
FORMAT_DATE('%Y-%m', created_at) as month_year,
count(user_id) as total_user, 
count(order_id) as total_order 
from bigquery-public-data.thelook_ecommerce.orders
WHERE FORMAT_DATE('%Y-%m', created_at) BETWEEN '2019-01-01' AND '2022-04-30'
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
WHERE FORMAT_DATE('%Y-%m', created_at) BETWEEN '2019-01-01' AND '2022-04-30'
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
Nữ: độ tuổi trẻ nhất 12 có 525 KH;độ tuổi lớn nhất là 70 có 569 KH */

--Top 5 sản phẩm mỗi tháng.
with cte as (
select 
FORMAT_DATE('%Y-%m', created_at) as month_year,
b.product_id as product_id, a.name as product_name,
Round(sum(b.sale_price),2) as  sales,
Round(a.cost,2)as cost,
Round(sum(b.sale_price) - a.cost,2) as profit,
DENSE_RANK() over(partition by b.product_id, a.name order by b.product_id, a.name ) as rank_per_month
from bigquery-public-data.thelook_ecommerce.products  a
join bigquery-public-data.thelook_ecommerce.order_items b 
  on a.id=b.product_id 
group by FORMAT_DATE('%Y-%m', created_at), b.product_id, a.name, a.cost)

Select month_year, product_id, product_name, sales, cost,  profit, rank_per_month
from cte 
where rank_per_month <=5 
--Doanh thu tính đến thời điểm hiện tại trên mỗi danh mục
select 
FORMAT_DATE('%Y-%m-%d', a.sold_at) as dates, 
a.product_category as product_categories,
Round(sum(b.sale_price),2) as revenue
from bigquery-public-data.thelook_ecommerce.inventory_items as a
join bigquery-public-data.thelook_ecommerce.order_items as b
  on a.product_id=b.product_id
where FORMAT_DATE('%Y-%m-%d', a.sold_at) BETWEEN '2022-04-15' AND '2022-07-15'
group by FORMAT_DATE('%Y-%m-%d', a.sold_at),a.product_category


--COHORT
Create Or replace View vw_ecommerce_analyst as
(
select  
extract(month from a.created_at) as month,
extract(year from a.created_at) as year,
c.product_category,
Round(sum(b.sale_price),2) as TPV,
Round(sum(d.cost),2) as Total_cost,
count(b.order_id) as TPO,
Round(Round(sum(b.sale_price),2)- Round(sum(d.cost),2),2) as Total_profit,
Round(Round(sum(b.sale_price),2)/ Round(sum(d.cost),2),2) as Profit_to_cost_ratio
from bigquery-public-data.thelook_ecommerce.orders as a
join bigquery-public-data.thelook_ecommerce.order_items as b
  on a.order_id=b.order_id
join bigquery-public-data.thelook_ecommerce.inventory_items as c
  on b.product_id=c.product_id
join bigquery-public-data.thelook_ecommerce.products as d
  on b.product_id=d.id
group by extract(month from a.created_at),extract(year from a.created_at), c.product_category)






