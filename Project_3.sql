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
orderlinenumber as order_number
from public.sales_dataset_rfm_prj
group by month_id, orderlinenumber
order by sum(sales) DESC
  --Tháng 11 với revenue =219190.75 và order_number=1
--3.Product line được bán nhiều ở tháng 11
select 
productline,
sum(sales)as revenue,
orderlinenumber as order_number
from public.sales_dataset_rfm_prj
where month_id = 11
group by month_id, productline,orderlinenumber
order by sum(sales) DESC
   --Productline bán nhiều nhất: Classic Cars với order_number 2
--4.Sản phẩm có doanh thu tốt nhất ở UK mỗi năm
select 
year_id,productline,
sum(sales)as revenue,
Rank()Over(order by sum(sales)DESC)as rank
from public.sales_dataset_rfm_prj
group by year_id,productline
  --Classic Cars
--5.Khách hàng tốt nhất, phân tích dựa vào RFM 




