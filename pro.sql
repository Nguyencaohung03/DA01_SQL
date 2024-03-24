with Superusers as (
SELECT user_id, count(*) as transactioncount
FROM USERS
group by user_id
having transactioncount >= 2
)
select u.user_id, 
MAX(u.transaction_date) as Date_Became_Super_User
from USERS as u 
Join Superusers as s on u.USER_ID = s.user_id
group by u.user_id
