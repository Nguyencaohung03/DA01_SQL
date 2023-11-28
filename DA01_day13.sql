--ex1

--ex2

--ex3

--ex4
SELECT 
a.page_id
FROM pages as a
Left join page_likes as b 
on a.page_id=b.page_id
where b.liked_date is NULL
order by page_id 
--ex5
select 
  EXTRACT(month from event_date) as month,
  count(distinct user_id) as monthly_active_users
from user_actions
where user_id in (select distinct user_id from user_actions 
 where EXTRACT(month from event_date) = 6) 
 and EXTRACT(month from event_date) = 7 
 and event_type in ('sign-in','like','comment')
 and EXTRACT(year from event_date) = 2022
group by EXTRACT(month from event_date) 

