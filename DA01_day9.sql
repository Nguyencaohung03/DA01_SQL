--ex1
SELECT 
COUNT(CASE
  when device_type =  'laptop'then 1
END) as laptop_reviews,
Count(CASE  
  when device_type in ('tablet', 'phone') then 2
END) as mobile_views
FROM viewership;
--ex2
