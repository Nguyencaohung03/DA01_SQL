WITH UserTransactions as (
SELECT user_id,
	transaction_date,
    ROW_NUMBER() OVER (PARTITION BY User_id ORDER BY Transaction_date) as TransactionRank
FROM users
),
SuperUsers as(
SELECT user_id,
    transaction_date
FROM UserTransactions
WHERE user_id IN (SELECT user_id
       			  FROM UserTransactions
        		  GROUP BY user_id
        		  HAVING COUNT(*) >= 2)
AND TransactionRank = 2
)
SELECT u.user_id, s.transaction_date
FROM users as u
LEFT JOIN SuperUsers as s on u.user_id= s.user_id
GROUP BY u.user_id, s.transaction_date
ORDER BY u.user_id
