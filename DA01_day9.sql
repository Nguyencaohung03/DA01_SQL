--ex1
SELECT 
COUNT(CASE
  when device_type =  'laptop' then 1
END) as laptop_reviews,
Count(CASE  
  when device_type in ('tablet', 'phone') then 2
END) as mobile_views
FROM viewership;
--ex2
select x,y,z,
case
  when x + y > z and x + z > y and y + z > x then 'Yes'
else 'No'
end triangle
from Triangle
--ex3


--ex4
SELECT name 
FROM customer         
WHERE referee_id is NULL OR referee_id <> 2
  
    ---câu này cắc c làm đáp án luôn ạ? em vào link đã có đáp án r
  
-ex5
select survived,
Count(case
when pclass = 1 then 'first_class'
end) as first_class,
Count(case
when pclass = 2 then 'second_class'
end) as second_class,
Count(case 
when pclass = 3   then 'third_class'
end)  as third_class
from titanic
group  by survived






