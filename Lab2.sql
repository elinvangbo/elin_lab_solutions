
#LAB 2 
#Select all the actors with the first name ‘Scarlett’.
SELECT * FROM sakila.actor WHERE first_name="Scarlett"; 

SELECT * FROM sakila.actor WHERE last_name="Johansson"; 

SELECT COUNT(film_id) FROM sakila.film;

SELECT COUNT(rental_id) FROM sakila.rental;

SELECT MAX(rental_duration) FROM sakila.film;
SELECT MIN(rental_duration) FROM sakila.film;

SELECT MAX(length) AS max_duration FROM sakila.film;

SELECT MIN(length) AS min_duration FROM sakila.film;

SELECT AVG(length) AS average_duration FROM sakila.film;

SELECT FLOOR(AVG(length) / 60) AS Hour, (AVG(length) / 60 - FLOOR(AVG(length) / 60))*60 AS Minutes FROM sakila.film;

SELECT CONCAT(FLOOR(AVG(length) / 60), " hours ", ROUND(AVG(length) % 60), " minutes") AS average_lenght FROM sakila.film;

SELECT COUNT(length) FROM sakila.film WHERE length > 180;

SELECT LOWER(CONCAT(first_name, ".", last_name, "@sakilacustomer.org")) as customer_email FROM sakila.customer;

SELECT title FROM sakila.film ORDER BY LENGTH(title) DESC LIMIT 1;




