#Select the first name, last name, and email address of all the customers who have rented a movie.
use sakila;

select distinct(cu.first_name), cu.last_name, cu.email from customer cu
right join rental r using (customer_id);

#What is the average payment made by each customer (display the customer id, 
#customer name (concatenated), and the average payment made).

select concat(cu.first_name, " ", cu.last_name) as "customer name", 
round(avg(p.amount), 1) as "average payment" from customer cu join payment p using (customer_id) 
group by 1;

#Select the name and email address of all the customers who have rented the "Action" movies.
#Write the query using multiple join statements
select concat(cu.first_name, " ", cu.last_name) as "customer name", distinct(cu.email), c.name as "film category" 
from customer cu join rental r using (customer_id) 
join inventory i using (inventory_id) 
join film_category fc using (film_id)
join category c using (category_id) 
where c.name = "Action";

#Write the query using sub queries with multiple WHERE clause and IN condition
select category_id from category where name = "Action";
select film_id from film_category where category_id in 
(select category_id from category where name = "Action");

select inventory_id from inventory where film_id in 
(select film_id from film_category where category_id in 
(select category_id from category where name = "Action"));

select customer_id from rental where inventory_id in
(select inventory_id from inventory where film_id in 
(select film_id from film_category where category_id in 
(select category_id from category where name = "Action")));

select concat(first_name, " ", last_name) as "customer name", email
from customer where customer_id in (
select customer_id from rental where inventory_id in
(select inventory_id from inventory where film_id in 
(select film_id from film_category where category_id in 
(select category_id from category where name = "Action"))));

#Verify if the above two queries produce the same results or not

select count(distinct(email)) 
from customer where customer_id in (
select customer_id from rental where inventory_id in
(select inventory_id from inventory where film_id in 
(select film_id from film_category where category_id in 
(select category_id from category where name = "Action"))));

select count(distinct(cu.email)) 
from customer cu join rental r using (customer_id) 
join inventory i using (inventory_id) 
join film_category fc using (film_id)
join category c using (category_id) 
where c.name = "Action";

#Use the case statement to create a new column classifying existing columns
select payment_id, amount, 
CASE
    WHEN amount > 4 THEN "high"
    WHEN amount > 2 THEN "medium"
    WHEN amount > 0 THEN "low"
END as "amount of payment" 
from payment;
