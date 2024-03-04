--Overview of the Data
SELECT * FROM facts
LIMIT 5
--Summary Statistics
select 
min(population),
max(population),
min(population_growth),
max(population_growth)
* from facts
--Exploring Outliers
select 
name, min(population)
from facts
where population = (select min(population) from facts);

select 
name, max(population)
from facts
where population = (select max(population) from facts)
/* It seems like the table contains a row for the whole world, which explains the population of over 7.2 billion. 
It also seems like the table contains a row for Antarctica, which explains the population of 0. 
This seems to match the CIA Factbook page for Antarctica */
--Exploring Average Population and Area
delete from facts
where name = 'World';

select 
min(population),
max(population),
min(population_growth),
max(population_growth)
* from facts;

select 
avg(population), avg(area)
from facts;
--Finding Densely Populated Countries
delete from facts
where name = 'World';

select name
from facts
where population > (select avg(population) from facts)
and area < (select avg(area) from facts)
-- Which countries have a higher birth rate than  death rate?
select name, birth_rate, death_rate
from facts
WHERE birth_rate > death_rate
