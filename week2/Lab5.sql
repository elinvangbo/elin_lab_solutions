
ALTER TABLE sakila.staff DROP COLUMN picture;

SELECT * FROM sakila.customer WHERE first_name = "TAMMY" and last_name = "Sanders";

INSERT INTO sakila.staff (staff_id, first_name, last_name, address_id, email, store_id, active, username) 
VALUES (3,'TAMMY','SANDERS',79,'TAMMY.SANDERS@sakilacustomer.org',2,1,'Tammy');

SELECT * FROM sakila.staff;

SELECT * FROM sakila.film WHERE title = "Academy Dinosaur";
SELECT * FROM sakila.inventory WHERE film_id = 1;
SELECT * FROM sakila.customer WHERE first_name = "charlotte" and last_name = "hunter";

INSERT INTO sakila.rental (inventory_id, customer_id, staff_id)
VALUES (1, 130, 1);

SELECT * FROM sakila.customer WHERE active = 0;

use sakila;

CREATE TABLE deleted_users (
deleted_users_id int NOT NULL AUTO_INCREMENT,
customer_id int NOT NULL, 
email varchar(50),
date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (deleted_users_id)
);  

INSERT INTO deleted_users (customer_id, email)
SELECT customer_id, email
FROM customer
WHERE active = 0;

SELECT * FROM deleted_users;

#DELETE FROM sakila.customer WHERE active = 0;


