#1. How many pubs are located in each country??

Select country,count(*) as count_of_pubs_in_country
from pubs
group by country

#2. What is the total sales amount for each pub, including the beverage price and quantity sold?

Select pub_name,sum(quantity * price_per_unit) as total_sales
from sales 
join beverages
using (beverage_id)
join pubs 
using (pub_id)
group by pub_name

#3. Which pub has the highest average rating?

Select pub_name,round(avg(rating),2) as avg_rating
from pubs 
join ratings
using (pub_id)
group by pub_name

#4. What are the top 5 beverages by sales quantity across all pubs?

Select beverage_name,sum(quantity) as top_5_beverages
from pubs
join sales 
using (pub_id)
join beverages 
using (beverage_id)
group by beverage_name
order by top_5_beverages desc
limit 5

#5. How many sales transactions occurred on each date?

Select transaction_date,count(*) num_of_transaction
from sales
group by transaction_date
order by num_of_transaction desc

#6. Find the name of someone that had cocktails and which pub they had it in.

Select customer_name,category,pub_name
from pubs
join ratings 
using (pub_id)
join sales
using (pub_id)
join beverages
using (beverage_id)
where category ='cocktail'

#7. What is the average price per unit for each category of beverages, excluding the category 'Spirit'?

Select category,round(avg(price_per_unit),2) as avg_price_per_unit
from beverages
where category <> 'spirit'
group by category

#8. Which pubs have a rating higher than the average rating of all pubs?

with cte as 
(
Select p.pub_name,r.rating,
dense_rank() over(partition by p.pub_name order by r.rating desc) as drnk
from pubs p
join ratings r 
on p.pub_id = r.pub_id
where 
(Select avg(rating) from ratings) < r.rating
order by rating desc)
Select * from cte
where drnk=1

#9. What is the running total of sales amount for each pub, ordered by the transaction date?

with cte as 
(
Select pub_name,transaction_date,sum(quantity * price_per_unit) as sales_amount
from pubs
join sales 
using (pub_id)
join beverages 
using (beverage_id)
group by pub_name,transaction_date
)
Select *,sum(cte.sales_amount)
over(partition by cte.pub_name order by cte.transaction_date) as running_total
from cte 

#10. For each country, what is the average price per unit of beverages in each category, and what is the overall average price per unit of beverages across all categories?

with cte as
(
Select category,country,
  Round(avg(price_per_unit),1) as avg_price
from beverages
join sales
using (beverage_id)
join pubs
using (pub_id)
group by category,country
),
total_avg_price as 
(
Select country,Round(AVG(price_per_unit),1) as total_average_price
from pubs 
join sales using (pub_id)
join beverages using (beverage_id)
group by country 
)
Select country,category,cte.avg_price,tap.total_average_price
from cte 
join total_avg_price tap
using (country)

#11. For each pub, what is the percentage contribution of each category of beverages to the total sales amount, and what is the pub's overall sales amount?


with cte as 
(
Select pub_name,category,sum(quantity * price_per_unit) as total_sales
from pubs
join sales using (pub_id)
join beverages using (beverage_id)
group by pub_name,category
),
overall_sales_amt as (
select pub_name,sum(quantity * price_per_unit) as sales
from pubs 
join sales using (pub_id)
join beverages using (beverage_id)
group by pub_name
)
Select pub_name,category,cte.total_sales,os.sales,
ROUND(sum(cte.total_sales/os.sales * 100),2) as percentage_contribution
from cte
join overall_sales_amt os
using (pub_name)
group by pub_name,category





