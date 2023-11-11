-- ex1 
select NAME from CITY where POPULATION > 120000 and COUNTRYCODE = 'USA'
-- ex2
select * from CITY where  COUNTRYCODE = 'JPN'
-- ex3
select CITY, STATE  from STATION
-- ex4 
select CITY from STATION where CITY like 'A%' or CITY like 'E%' or CITY like 'I%' or CITY like 'O%' or CITY like 'U%'
--ex5
select distinct CITY from STATION where CITY like '%A' or CITY like '%E' or CITY like '%I' or CITY like '%O' or CITY like '%U'
--ex6
select distinct CITY from STATION where CITY not like 'A%' and CITY not like 'E%' and CITY not like 'I%' 
and CITY not like 'O%' and CITY not like 'U%'
--ex7
select name from Employee  
where salary > 2000 and months < 10
order by employee_id
--ex8
select name from Employee 
order by name
--ex9
select product_id from Products where low_fats = 'Y' and recyclable = 'Y'
--ex10
ELECT name FROM customer         
WHERE referee_id is NULL OR referee_id <> 2
--ex 11
select name,  population,  area from World 
where area >= 300000 and population >= 25000000 
--ex12
select distinct author_id as id from Views where article_id > 1
order by id
--ex13
SELECT part, assembly_step FROM parts_assembly
where finish_date is NULL
--ex14
select index from lyft_drivers
where yearly_salary <= 30000 or yearly_salary >= 70000
--ex15
select advertising_channel from uber_advertising
where money_spent >= 100000 and year = 2019



