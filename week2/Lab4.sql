SELECT title, rating FROM sakila.film;

SELECT release_year, rating FROM sakila.film;

SELECT rating, COUNT(film_id)
FROM sakila.film
GROUP BY rating; 

SELECT * FROM sakila.film WHERE title REGEXP "ARMAGEDDON";

SELECT * FROM sakila.film WHERE title REGEXP "APOLLO";

SELECT * FROM sakila.film WHERE title LIKE "%APOLLO";

SELECT * FROM sakila.film WHERE title REGEXP "DATE";

SELECT * FROM sakila.film ORDER BY LENGTH(title) LIMIT 10;

SELECT COUNT(film_id) AS films_with_behindscenes FROM sakila.film WHERE special_features like "%Behind the Scenes%";

SELECT * FROM sakila.film ORDER BY release_year, title;