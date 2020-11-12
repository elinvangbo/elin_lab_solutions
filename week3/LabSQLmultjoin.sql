USE sakila;

#Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, a.address, c.city, co.country FROM store s
LEFT JOIN address a
ON s.address_id = a.address_id 
LEFT JOIN city c 
ON a.city_id = c.city_id
LEFT JOIN country co 
ON c.country_id = co.country_id;

#Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id,  SUM(p.amount) AS sold_dollars FROM store s
LEFT JOIN staff st
ON s.store_id = st.store_id
LEFT JOIN payment p
ON st.staff_id = p.staff_id
GROUP BY s.store_id;

#What is the average running time of films by category?
SELECT c.name, ROUND(AVG(f.length),2) AS avg_length FROM category c 
LEFT JOIN film_category fc
ON c.category_id = fc.category_id
LEFT JOIN film f
ON f.film_id = fc.film_id
GROUP BY c.name;

#Which film categories are longest? I PERSUME ON AVERAGE
SELECT c.name, ROUND(AVG(f.length),2) AS avg_length FROM category c 
LEFT JOIN film_category fc
ON c.category_id = fc.category_id
LEFT JOIN film f
ON f.film_id = fc.film_id
GROUP BY c.name
ORDER BY avg_length DESC
LIMIT 1;

#Display the most frequently rented movies in descending order.
SELECT f.title, COUNT(r.rental_id) as times_rented FROM rental r
LEFT JOIN inventory i
ON r.inventory_id = i.inventory_id
LEFT JOIN film f 
ON i.film_id = f.film_id
GROUP BY title
ORDER BY times_rented DESC;

#List the top five genres in gross revenue in descending order. ASSUMING CATEGORY 
SELECT c.name, SUM(p.amount) as gross_revenue FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id 
JOIN inventory i 
ON fc.film_id = i.film_id 
JOIN rental r 
ON i.inventory_id = r.inventory_id 
JOIN payment p 
ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;

#Is "Academy Dinosaur" available for rent from Store 1?
SELECT s.store_id, f.title FROM store s
JOIN inventory i
ON s.store_id = i.store_id
JOIN film f
ON i.film_id = f.film_id
WHERE f.title = "Academy Dinosaur"
GROUP BY store_id;



