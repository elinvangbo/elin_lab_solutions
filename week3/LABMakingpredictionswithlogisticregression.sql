#Create a query or queries to extract the information you think may be relevant 
#for building the prediction model. 
#It should include some film features and some rental features.
USE sakila;

#start with making a general table 
SELECT f.film_id, f.title, f.description, fc.category_id,
f.language_id, f.length/60 as hours_length, f.rental_duration,
f.release_year, f.rating, 
f.special_features, 
ROUND(AVG(f.rental_duration)) * 24 AS avg_hours_rental_allowed,
ROUND(AVG(f.replacement_cost)) AS avg_replacement_cost,
count(fa.actor_id) as actors_in_film
FROM film f
JOIN film_category fc USING(film_id)
JOIN film_actor fa USING(film_id)
GROUP BY 1,2,3,4,5,6,7,8,9,10
ORDER BY 1, 11;  

#secondquery 
SELECT 
i.film_id,
COUNT(r.rental_id) AS num_rented_times,
p.amount AS rental_cost,
AVG(TIMESTAMPDIFF(hour, r.rental_date, r.return_date)) AS avg_hours_rented
FROM rental r
JOIN inventory i USING(inventory_id)
JOIN payment p USING(rental_id)
GROUP BY i.film_id, rental_cost;


SELECT r.rental_date, i.film_id, count(distinct r.inventory_id) FROM rental r
JOIN inventory i USING (inventory_id)
GROUP BY r.rental_date, i.film_id
ORDER BY i.film_id;

USE sakila; 

SELECT film_id, 
case times_rented_last_month >= 1 then 0
else 1 
end as rented 
FROM(
SELECT film_id, 
	sum(case 
		when rental_date between "2005-07-01" 
        and "2005-08-01" then 1 
        else 0 
        end) as times_rented_last_month
from film left join inventory using (film_id) left join rental using (inventory_id)
GROUP BY film_id) AS CTE; 

create or replace view rentedlast as 
select distinct f.film_id,
case when rental_date between convert("2006-02-01", date) and convert("2006-03-01", date) then True
else False
end as 'rentlastmonthhelp'
from film f
left join inventory i using (film_id)
join rental r using (inventory_id);
select * from rentedlast;
select film_id, max(rentlastmonthhelp) as rentlastmonth from rentedlast
group by film_id;

