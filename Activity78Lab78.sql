use bank;

#Find out how many cards of each type have been issued.
SELECT type, COUNT(type)
FROM card
GROUP BY type;

#Find out how many customers there are by the district.
SELECT district_id, COUNT(district_id)
FROM client
GROUP BY district_id
ORDER BY district_id;

#Find out average transaction value by type.
SELECT type, ROUND(AVG(amount), 2) AS avg_value
FROM trans
GROUP BY type; 

#group by two things, remove blank space
SELECT type, k_symbol, ROUND(AVG(amount), 2) AS avg_value
FROM trans
WHERE k_symbol != " "
GROUP BY type, k_symbol;  

#Find out how many customers there are by the district.
SELECT district_id, COUNT(district_id) as numb_clients
FROM client
GROUP BY district_id
HAVING numb_clients > 100
ORDER BY district_id;

#Find the transactions (type, operation) with a mean amount greater than 10000.
SELECT type, operation, ROUND(AVG(amount)) as avg_amount
FROM trans 
GROUP BY type, operation
HAVING avg_amount > 10000;

USE sakila;

#not repeated 
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;

#repeated 
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1;

#Using the rental table, find out how many rentals were processed by each employee.
SELECT staff_id, COUNT(rental_id)
FROM rental
GROUP BY staff_id;

#Using the film table, find out how many films were released each year.
SELECT release_year, COUNT(release_year) as num_film
FROM film
GROUP BY release_year;

#Using the film table, find out for each rating how many films were there.
SELECT rating, COUNT(rating) as num_films
FROM film
GROUP BY rating;

#What is the mean length of the film for each rating type. Round off the average lengths to two decimal places
SELECT rating, ROUND(AVG(length), 2) as avg_length
FROM film
GROUP BY rating;

#Which kind of movies (rating) have a mean duration of more than two hours?
SELECT rating, ROUND(AVG(length), 2) as avg_length
FROM film
GROUP BY rating
HAVING avg_length > 120;

USE bank;

#Partition by är FÖRSTA hinken, order by är ANDRA hinken
SELECT *, 
RANK() OVER (PARTITION BY A3 ORDER BY A2) as rankcol
FROM district
ORDER BY A3;

SELECT *, 
RANK() OVER (PARTITION BY A9 ORDER BY A11) as rankcol
FROM district
ORDER BY A9;

#Rank districts by different variables.
SELECT *, 
ROW_NUMBER() OVER(ORDER BY A9) as "Row"
FROM district;

#Do the same but group by region.
SELECT *, 
RANK() OVER (PARTITION BY A3 ORDER BY A9) as "Row"
FROM district;

#Use the transactions table in the bank database to find the Top 20 account_ids based on the balances.
SELECT account_id, amount,
RANK() OVER(ORDER BY amount DESC) as "Row"
FROM trans
LIMIT 20;

#Illustrate the difference between Rank() and Dense_Rank().
SELECT account_id, amount,
DENSE_RANK() OVER(ORDER BY amount DESC) as "Row"
FROM trans
LIMIT 20;

SELECT account_id, amount,
ROW_NUMBER() OVER(ORDER BY amount DESC) as "Row"
FROM trans
LIMIT 20;

USE bank;
#Get a rank of districts ordered by the number of customers.
SELECT client_id, district_id,
RANK() OVER(PARTITION BY district_id ORDER BY client_id) as "Row"
FROM client;

#Get a rank of regions ordered by the number of customers.
SELECT client.client_id, client.district_id, district.A3,
RANK() OVER(PARTITION BY A3 ORDER BY client_id) as "Row"
FROM client JOIN district
ON client.district_id = district.A1;

#Get the total amount borrowed by the district together with the average loan in that district. 
SELECT account.account_id, account.district_id, loan.amount, 
SUM(loan.amount) OVER (PARTITION BY account.district_id) AS tot_loan,
AVG(loan.amount) OVER (PARTITION BY account.district_id) AS avg_loan
FROM account JOIN loan
ON account.account_id = loan.account_id
GROUP BY account.district_id, loan.amount, account.account_id;

USE bank;

#Get the number of accounts opened by district and year.
SELECT district_id, EXTRACT(YEAR FROM date), COUNT(district_id)
FROM account
GROUP BY district_id, EXTRACT(YEAR FROM date)
ORDER BY district_id;

USE sakila;

#Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
SELECT length, title, 
ROW_NUMBER() OVER(PARTITION BY length ORDER BY length) as "row length"
FROM film
WHERE NOT length = 0;

#Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, rating and the rank.
SELECT title, length, rating, 
DENSE_RANK() OVER(PARTITION BY rating ORDER BY length) as "Row"
FROM film;

#How many films are there for each of the categories in the category table. Use appropriate join to write this query
SELECT category_id, COUNT(film_id)
FROM film_category
GROUP BY category_id;

#Which actor has appeared in the most films?
SELECT film_actor.actor_id, actor.first_name, actor.last_name, COUNT(film_actor.film_id)
FROM film_actor JOIN actor
ON film_actor.actor_id = actor.actor_id
GROUP BY film_actor.actor_id, actor.first_name, actor.last_name
ORDER BY COUNT(film_actor.film_id) DESC;

#Most active customer (the customer that has rented the most number of films)
SELECT rental.customer_id, customer.first_name, customer.last_name, COUNT(rental.rental_id)
FROM rental JOIN customer
ON rental.customer_id = customer.customer_id
GROUP BY rental.customer_id, customer.first_name, customer.last_name
ORDER BY COUNT(rental.rental_id) DESC;
