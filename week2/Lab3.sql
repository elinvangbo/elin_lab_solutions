SELECT COUNT(DISTINCT(last_name)) AS distinct_actors FROM sakila.actor; 

SELECT name FROM sakila.language; 

SELECT COUNT(rating) FROM sakila.film WHERE rating = "PG-13";

SELECT title, length FROM sakila.film WHERE release_year = 2006 ORDER BY length DESC LIMIT 10;

#How many days has been the company operating (check DATEDIFF() function)?
SELECT DATEDIFF(MAX(return_date), MIN(rental_date)) AS days_operating FROM sakila.rental;

#Show rental info with additional columns month and weekday. Get 20.
SELECT DATE_FORMAT(rental_date, "%M") AS "month_rented", DATE_FORMAT(rental_date, "%W") AS day_rented FROM sakila.rental;
SELECT DATE_FORMAT(return_date, "%M") AS "month_returned", DATE_FORMAT(return_date, "%W") AS day_returned FROM sakila.rental;

SELECT DATE_FORMAT(rental_date, "%w") FROM sakila.rental;

#Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT rental_id, CONVERT(rental_date, DATE), CASE
	WHEN DATE_FORMAT(rental_date, "%w") = 6 OR 0 THEN "weekend"
    ELSE "weekday"
END AS "day_type" 
FROM sakila.rental;

#How many rentals were in the last month of activity?
SELECT COUNT(DATE_FORMAT(rental_date, "%m")) as number_of_rentals
FROM sakila.rental
WHERE DATE_FORMAT(rental_date, "%m") = 08;

SELECT rental_date FROM sakila.rental;
