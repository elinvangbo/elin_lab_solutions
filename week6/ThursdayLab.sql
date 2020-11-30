use sakila;

  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action"
  group by first_name, last_name, email;
  
delimiter //
create procedure rented_action 
(out param1 VARCHAR(40))
begin
  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action"
  group by first_name, last_name, email;
  end;
//
delimiter ;  

call rented_action(@x);

drop procedure if exists rented_category;


delimiter //
create procedure rented_category 
(in param1 VARCHAR(40))
begin
  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = param1
  group by first_name, last_name, email;
  end;
//
delimiter ;  

call rented_category("Action");
call rented_category("comedy");

#Write a query to check the number of movies released in each movie category. 
#Convert the query in to a stored procedure to filter only those categories that have movies 
#released greater than a certain number. Pass that number as an argument in the stored procedure.

select c.name, count(fc.film_id) as num_films from category c 
join film_category fc using (category_id)
group by 1
having num_films > 10;

delimiter //
create procedure num_films_rented 
(in param1 int)
begin 
	select c.name, count(fc.film_id) as num_films from category c 
	join film_category fc using (category_id)
	group by 1
	having num_films > param1;
	end;
//
delimiter ;

call num_films_rented(20);
call num_films_rented(60);
