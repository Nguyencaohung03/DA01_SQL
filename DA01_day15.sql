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
