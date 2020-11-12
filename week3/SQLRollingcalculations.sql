#Get number of monthly active customers.
USE sakila;

select MONTH(rental_date) AS rental_month, count(distinct customer_id) as active_customers 
from rental
group by rental_month
order by rental_month;

#Active users in the previous month.
SELECT COUNT(distinct customer_id) FROM rental WHERE rental_date > (MONTH(rental_date) - 1);
SELECT first_name, last_name 
FROM customer
WHERE customer_id IN
(
SELECT customer_id FROM rental WHERE rental_date > (MONTH(rental_date) - 1)
);

#Percentage change in the number of active customers.
create or replace view monthly_active_customers as
select MONTH(rental_date) AS rental_month, count(distinct customer_id) as active_customers 
from rental
group by rental_month
order by rental_month;

with cte_activity AS 
(
SELECT MONTH(rental_date), active_customers, 
LAG(active_customers,1) OVER (PARTITION BY MONTH(rental_date)) AS previous_month
FROM monthly_active_customers
) 
select 
(active_customers-previous_month)/active_customers *100  as percchange,
(active_customers-previous_month) as custnos,
, MONTH(rental_date) FROM cte_activity;





#Retained customers every month.