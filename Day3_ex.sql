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




