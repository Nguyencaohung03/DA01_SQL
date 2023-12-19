--Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). 
--If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
with cte as (
select City, length(CITY)as len,
Row_number()over(order by length(CITY), city)  as shortest,
Row_number()over(order by length(CITY)DESC, city)  as longest
from STATION)
select city, len
  from cte
 where shortest = 1
union all
select city, len
  from cte
 where longest = 1
--Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
SELECT distinct CITY 
FROM STATION 
where (CITY LIKE 'a%' 
    OR CITY LIKE 'e%' 
    OR CITY LIKE 'i%' 
    OR CITY LIKE 'o%'
    OR CITY LIKE 'u%'
) AND (CITY LIKE '%a' 
    OR CITY LIKE '%e'
    OR CITY LIKE '%i'
    OR CITY LIKE '%o'
    OR CITY LIKE '%u'
)
/* define an employee's total earnings to be their monthly  worked, 
  and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. 
  Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. 
  Then print these values as  space-separated integers.
*/
select (months * salary) as earnings,
count(*) 
from Employee 
group by earnings 
order by earnings desc
limit 1


