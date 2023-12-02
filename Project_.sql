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

ALTER TABLE sales_dataset_rfm_prj
 ALTER COLUMN phone TYPE numeric USING (TRIM(phone):: numeric);
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

--4.Chuẩn hóa CONTACTLASTNAME, CONTACTFIRSTNAME theo định dạng chữ cái đầu tiên viết hoa, chữ cái tiếp theo viết thường. 

--5.Thêm cột QTR_ID, MONTH_ID, YEAR_ID lần lượt là Qúy, tháng, năm được lấy ra từ ORDERDATE 

--6.Hãy tìm outlier (nếu có) cho cột QUANTITYORDERED và hãy chọn cách xử lý cho bản ghi đó (2 cách) ( Không chạy câu lệnh trước khi bài được review)
