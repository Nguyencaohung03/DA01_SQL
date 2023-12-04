--1.Doanh thu theo từng ProductLine, Year và DealSize
select 
productline, year_id, dealsize, 
sum(sales)as revenue
from public.sales_dataset_rfm_prj
group by productline, year_id, dealsize
--2.Tháng có bán tốt nhất mỗi năm
select 
month_id, 
sum(sales)as revenue,
Rank()over(order by sum(sales)DESC)as order_number
from public.sales_dataset_rfm_prj
group by month_id
  --Tháng 11 với revenue =2118885.67
--3.Product line được bán nhiều ở tháng 11

--4.Sản phẩm có doanh thu tốt nhất ở UK mỗi năm

--5.Khách hàng tốt nhất, phân tích dựa vào RFM 
