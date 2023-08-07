#1. What are the names of all the countries in the country table?

Select country_name from country

#2. What is the total number of customers in the customers table?

Select count(*)
from customers

#3. What is the average age of customers who can receive marketing emails (can_email is set to 'yes')?

Select Round(Avg(age)) as Avg_age
from customers
where can_email ='yes'

#4. How many orders were made by customers aged 30 or older?

Select count(*) as no_of_orders
from orders o
join customers ct
on o.customer_id=ct.customer_id
where age >=30

#5. What is the total revenue generated by each product category?

Select category,Sum(price) as total_revenue
from products
group by category

#6. What is the average price of products in the 'food' category?

Select category,avg(price) as average_price
from products
where category='food'

#7. How many orders were made in each sales channel (sales_channel column) in the orders table?

Select sales_channel,Count(*) as no_of_orders
from orders
group by sales_channel

#8.What is the date of the latest order made by a customer who can receive marketing emails?

Select max(date_shop) as latest_date,ct.can_email 
from orders o
join customers ct
on o.customer_id=ct.customer_id
where can_email='yes'

#9. What is the name of the country with the highest number of orders?

Select ct.country_name,count(*) as no_of_orders
from country ct 
join orders o
on ct.country_id=o.country_id
group by country_name
order by no_of_orders desc 
limit 1


#10. What is the average age of customers who made orders in the 'vitamins' product category?*/

Select p.category,round(avg(ct.age)) as Avg_age
from orders o
join customers ct using (customer_id)
join baskets b using (order_id)
join products p using (product_id)
where p.category='vitamins'



