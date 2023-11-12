--ex1
select distinct CITY 
from STATION
where ID%2 = 0
order by CITY
--ex2
select COUNT(CITY) - COUNT(Distinct CITY) from STATION
--ex3

