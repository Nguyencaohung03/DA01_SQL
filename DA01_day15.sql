--ex1
SELECT 
extract(year from transaction_date),
	product_id, spend as curr_year_spend,
Lag(spend)over(partition by product_id order by product_id ) 
  as prev_year_spend,
Round((spend-Lag(spend)over(partition by product_id order by product_id ))
  /(Lag(spend)over(partition by product_id order by product_id ))*100,2)
FROM user_transactions
order by product_id
--ex2
SELECT distinct
  card_name,
  first_value (issued_amount) OVER(PARTITION BY card_name 
    order by issue_year, issue_month)as issued_amount
FROM monthly_cards_issued
order by issued_amount DESC
--ex3
with twt_trans as
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY user_id 
  ORDER BY user_id, transaction_date) as stt
FROM transactions
)
select user_id,spend,transaction_date from twt_trans
where stt=3
--ex4
with twt_users AS
(
SELECT transaction_date, 
user_id,
count(product_id)over(PARTITION BY user_id, transaction_date) 
    as purchase_count,
RANK() OVER(PARTITION BY user_id ORDER BY transaction_date DESC)
FROM user_transactions
)
select transaction_date, user_id,purchase_count
from twt_users
WHERE rank = 1
GROUP BY user_id,transaction_date, purchase_count
ORDER BY transaction_date
---ex5
SELECT user_id, tweet_date,   
round(AVG(tweet_count) over(PARTITION BY user_id order by tweet_date     
  ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) AS rolling_avg_3d
FROM tweets
--ex6
with twt_trans as 
(
SELECT merchant_id, credit_card_id, amount, transaction_timestamp,
lag(transaction_timestamp) OVER(PARTITION BY merchant_id, credit_card_id, amount 
  order by transaction_timestamp) 
as pre_trans
FROM transactions
where EXTRACT(MINUTE from transaction_timestamp) <= 10
)
select 
COUNT(merchant_id) as payment_count 
from twt_trans 
where EXTRACT(MINUTE FROM transaction_timestamp)
-EXTRACT(MINUTE FROM pre_trans) <= 10
---ex7
WITH twt_product AS 
(
SELECT category, product, 
sum(spend) as total_spend,
DENSE_RANK() OVER(PARTITION BY category ORDER BY sum(spend) DESC) 
as ranking
FROM product_spend
  where EXTRACT(YEAR FROM transaction_date) = 2022
  GROUP BY category, product
)
SELECT category, product, total_spend
FROM twt_product
WHERE ranking <=2
ORDER BY category, ranking
---ex8
with twt_top AS
(
SELECT a.artist_name, 
  DENSE_RANK() over(order by count(b.song_id) DESC) as artist_rank
FROM artists a 
join songs b on a.artist_id=b.artist_id
join global_song_rank as c on b.song_id =c.song_id
WHERE c.rank <= 10
group by a.artist_name
)
select  artist_name, artist_rank
from twt_top
where artist_rank <= 5






