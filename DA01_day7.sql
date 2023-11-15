--ex1 
select Name
from STUDENTS
where Marks > 75
Order BY Right(Name, 3), ID
--ex2

  
--ex3


--ex4
SELECT 
extract(month from submit_date) as mth, 
product_id as product,
round(AVG(stars), 2) as avg_stars
FROM reviews
group by product_id, extract(month from submit_date)
order by extract(month from submit_date), product_id
