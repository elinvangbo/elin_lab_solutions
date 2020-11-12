USE sakila;

#List number of films per category.
SELECT c.name, COUNT(f.film_id) as num_of_films FROM category c
LEFT JOIN film_category f
ON c.category_id = f.category_id
GROUP BY name;

#Display the first and last names, as well as the address, of each staff member.
SELECT s.first_name, s.last_name, a.address, a.district, a.postal_code FROM staff s
LEFT JOIN address a 
ON s.address_id = a.address_id;

#Display the total amount rung up by each staff member in August of 2005.
SELECT staff_id, SUM(AMOUNT) AS sold_aug
FROM payment
WHERE YEAR(payment_date) = 2005 AND MONTH(payment_date) = 08
GROUP BY staff_id;

#List each film and the number of actors who are listed for that film.
SELECT f.title, COUNT(a.actor_id) as num_actors FROM film f
LEFT JOIN film_actor a
ON f.film_id = a.film_id
GROUP BY f.title;

#Using the tables payment and customer and the JOIN command, 
#list the total paid by each customer. List the customers alphabetically by last name.
SELECT c.last_name, SUM(p.amount) as total_paid FROM customer c
JOIN payment p 
ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY c.last_name;

