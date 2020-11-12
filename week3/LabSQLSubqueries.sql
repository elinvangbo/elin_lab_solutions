#How many copies of the film Hunchback Impossible exist in the inventory system?
USE Sakila;
SELECT f.title, COUNT(i.inventory_id) AS copies
FROM film f 
LEFT JOIN inventory i
USING(film_id)
WHERE title = "Hunchback Impossible"
GROUP BY title;

#List all films whose length is longer than the average of all the films.
SELECT AVG(length) FROM film;
SELECT title, length FROM FILM 
WHERE length > (SELECT AVG(length) FROM film);

#Use subqueries to display all actors who appear in the film Alone Trip.
SELECT fa.film_id, a.first_name, a.last_name FROM film_actor fa 
LEFT JOIN actor a 
USING(actor_id)
WHERE fa.film_id IN (SELECT film_id FROM film WHERE title = "Alone Trip");

#Sales have been lagging among young families, and you wish to 
#target all family movies for a promotion. 
#Identify all movies categorized as family films.
SELECT category_id FROM category WHERE name = "Family"; 
SELECT f.title FROM film f 
LEFT JOIN film_category fc
USING(film_id)
WHERE fc.category_id = (SELECT category_id FROM category WHERE name = "Family");

#Get name and email from customers from Canada using subqueries. 
#Do the same with joins. Note that to create a join, you will have to 
#identify the correct tables with their primary keys and foreign keys, 
#that will help you get the relevant information.
SELECT first_name, last_name, email FROM customer 
WHERE address_id IN (SELECT address_id FROM address 
WHERE city_id IN (SELECT city_id FROM city 
WHERE country_id IN (SELECT country_id FROM country WHERE country = "Canada")));

SELECT c.first_name, c.last_name, c.email FROM customer c
LEFT JOIN address a
USING(address_id) 
LEFT JOIN city ci
USING(city_id)
LEFT JOIN country co
USING(country_id) 
WHERE co.country = "Canada";

#Which are films starred by the most prolific actor? Most prolific actor is defined 
#as the actor that has acted in the most number of films. First you will have to 
#find the most prolific actor and then use that actor_id to find the different films that he/she starred.

select concat(first_name, ' ', last_name) as actor_name, film.title, film.release_year
from sakila.actor
inner join sakila.film_actor
using (actor_id)
inner join film
using (film_id)
where actor_id = (
select actor_id
from sakila.actor
inner join sakila.film_actor
using (actor_id)
inner join sakila.film
using (film_id)
group by actor_id
order by count(film_id) desc
limit 1
)
order by release_year desc;

#Films rented by most profitable customer. You can use the customer table and payment 
#table to find the most profitable customer ie the customer that has made the largest sum of payments
SELECT customer_id, SUM(amount) FROM payment 
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 1;

select film_id, title, rental_date, amount
from sakila.film
inner join inventory using (film_id)
inner join rental using (inventory_id)
inner join payment using (rental_id)
where rental.customer_id = (
select customer_id
from customer
inner join payment
using (customer_id)
group by customer_id
order by sum(amount) desc
limit 1
)
order by rental_date desc;


#Customers who spent more than the average payments.
SELECT AVG(amount) FROM payment;
SELECT customer_id, sum(amount) AS payment FROM customer 
INNER JOIN payment USING (customer_id)
GROUP BY customer_id 
HAVING payment > (SELECT AVG(total_payment) FROM (
SELECT customer_id, SUM(amount) AS total_payment FROM payment GROUP BY customer_id) t)
ORDER BY payment DESC;
