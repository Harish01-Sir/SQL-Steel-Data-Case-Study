#1. What are the names of all the customers who live in New York?

Select concat(firstName,' ',lastName) as name,city
from customers
where city='New York'

#2. What is the total number of accounts in the Accounts table?

Select count(*) as total_acc
from accounts

#3. What is the total balance of all checking accounts?

Select accounttype,sum(balance) as total_balance
from accounts
where accounttype='Checking'

#4. What is the total balance of all accounts associated with customers who live in Los Angeles?

Select ct.city,sum(a.balance) as total_bal
from accounts a 
join customers ct using (customerid)
where city='Los Angeles'

#5. Which branch has the highest average account balance?

Select b.branchname,avg(balance) as avg_balance
from branches b
join accounts a using (branchid)
group by branchname


#6. Which customer has the highest current balance in their accounts?

Select concat(ct.firstname,' ',ct.lastname) as name,max(a.balance) as max_bal
from accounts a
join customers ct using (customerid)
group by name 
order by max_bal desc
limit 1

#7. Which customer has made the most transactions in the Transactions table?

Select concat(ct.firstname,' ',ct.lastname) as name,count(*) as total_transactions
from customers ct
join accounts a using(customerid)
join transactions t using(accountid)
group by name
order by total_transactions desc
limit 2

#8.Which branch has the highest total balance across all of its accounts?

Select branchname,sum(balance) as total_balance
from accounts 
join branches using (branchid)
group by branchname
order by total_balance desc 
limit 1

#9. Which customer has the highest total balance across all of their accounts, including savings and checking accounts?

Select concat(firstname,' ',lastname) as name,sum(balance) as highest_balance
from accounts
join customers
using(customerid)
where accounttype in ('checking','savings')
group by 1
order by sum(balance) desc 
limit 1


#10. Which branch has the highest number of transactions in the Transactions table?

Select branchname,count(*) as highest_transactions
from accounts 
join branches
using(branchid)
join transactions 
using(accountid)
group by branchname
order by highest_transactions desc 
limit 2