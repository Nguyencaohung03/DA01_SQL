--1.Chuyển đổi kiểu dữ liệu phù hợp cho các trường ( sử dụng câu lệnh ALTER) 
ALTER TABLE sales_dataset_rfm_prj
 ALTER COLUMN priceeach TYPE numeric USING (TRIM(priceeach):: numeric);
 
ALTER TABLE sales_dataset_rfm_prj
 ALTER COLUMN ordernumber TYPE numeric USING (TRIM(ordernumber):: numeric);
 
ALTER TABLE sales_dataset_rfm_prj
 ALTER COLUMN quantityordered TYPE numeric USING (TRIM(quantityordered):: numeric);
 
ALTER TABLE sales_dataset_rfm_prj
 ALTER COLUMN orderlinenumber TYPE numeric USING (TRIM(orderlinenumber):: numeric);
 
ALTER TABLE sales_dataset_rfm_prj
 ALTER COLUMN sales TYPE numeric USING (TRIM(sales):: numeric);
 
ALTER TABLE sales_dataset_rfm_prj
 ALTER COLUMN orderdate TYPE date USING (TRIM(orderdate):: date);
 
ALTER TABLE sales_dataset_rfm_prj
 ALTER COLUMN msrp TYPE numeric USING (TRIM(msrp):: numeric);

--2.Check NULL/BLANK (‘’)  ở các trường: ORDERNUMBER, QUANTITYORDERED, PRICEEACH, ORDERLINENUMBER, SALES, ORDERDATE.
Select ordernumber
from public.sales_dataset_rfm_prj
where ordernumber is null;

Select quantityordered
from public.sales_dataset_rfm_prj
where quantityordered is null;

Select priceeach
from public.sales_dataset_rfm_prj
where priceeach is null;

Select orderlinenumber
from public.sales_dataset_rfm_prj
where orderlinenumber is null;

Select sales
from public.sales_dataset_rfm_prj
where sales is null;

Select orderdate
from public.sales_dataset_rfm_prj
where orderdate is null;
--3.Thêm cột CONTACTLASTNAME, CONTACTFIRSTNAME được tách ra từ CONTACTFULLNAME .
Alter table sales_dataset_rfm_prj
Add column contactfirstname varchar;

Alter table sales_dataset_rfm_prj
Add column contactlastname varchar;
--4.Chuẩn hóa CONTACTLASTNAME, CONTACTFIRSTNAME theo định dạng chữ cái đầu tiên viết hoa, chữ cái tiếp theo viết thường. 
UPDATE sales_dataset_rfm_prj
SET CONTACTFIRSTNAME = INITCAP(SUBSTRING(CONTACTFULLNAME 
						FROM 1 FOR POSITION('-' IN CONTACTFULLNAME) - 1)),
    CONTACTLASTNAME = INITCAP(SUBSTRING(CONTACTFULLNAME 
						FROM POSITION('-' IN CONTACTFULLNAME) + 1))
WHERE CONTACTFULLNAME IS NOT NULL AND POSITION('-' IN CONTACTFULLNAME) > 0
--5.Thêm cột QTR_ID, MONTH_ID, YEAR_ID lần lượt là Qúy, tháng, năm được lấy ra từ ORDERDATE 
Alter table sales_dataset_rfm_prj
Add column qtr_id int;

Alter table sales_dataset_rfm_prj
Add column month_id int;

Alter table sales_dataset_rfm_prj
Add column year_id int;

Update sales_dataset_rfm_prj 
Set month_id = extract(month from orderdate); 

Update sales_dataset_rfm_prj 
Set year_id = extract(year from orderdate); 

Update sales_dataset_rfm_prj
SET qtr_id = (
case
when month_id in (1,2,3)  then 1
when month_id in (4,5,6)  then 2
when month_id in (7,8,9)  then 3
when month_id in (10,11,12)  then 4
end
)
--6.Hãy tìm outlier (nếu có) cho cột QUANTITYORDERED và hãy chọn cách xử lý cho bản ghi đó (2 cách) ( Không chạy câu lệnh trước khi bài được review)
--cách 1:
With twt_outlier as
(
Select Q1-1.5*IQR as min_value,
   Q3+1.5*IQR as max_value
from
(select
percentile_cont(0.25) within group (order by quantityordered)as Q1,
percentile_cont(0.75) within group (order by quantityordered)as Q3,
percentile_cont(0.75) within group (order by quantityordered)
	-percentile_cont(0.25) within group (order by quantityordered)as IQR
from sales_dataset_rfm_prj)as a
)
Select * from sales_dataset_rfm_prj
where quantityordered < (select min_value from twt_outlier)
or quantityordered > (select max_value from twt_outlier)

--cách 2:
with cte as
(
select orderdate,
quantityordered,
(select avg(quantityordered)
from sales_dataset_rfm_prj)as avg,
(select stddev(quantityordered)
from sales_dataset_rfm_prj)as sttdev
from sales_dataset_rfm_prj	
),
twt_outlier as
(
select orderdate, quantityordered,
(quantityordered-avg)/sttdev as Z_score
from cte
where abs((quantityordered-avg)/sttdev)>3,
)
--cách 1:
Update sales_dataset_rfm_prj
Set quantityordered= (select avg(quantityordered)
from sales_dataset_rfm_prj)
where quantityordered in (select quantityordered from twt_outlier)>3


--cách 2:	
Delete from sales_dataset_rfm_prj
where user in (Select * from sales_dataset_rfm_prj
where quantityordered < (select min_value from twt_outlier)
or quantityordered > (select max_value from twt_outlier))






