USE Bank;

#Get the number of clients by district, returning district name.
SELECT d.A2 AS district_name, COUNT(c.client_id) AS num_of_clients FROM district d
JOIN client c
ON d.A1 = c.district_id
GROUP BY district_name;

#Are there districts with no clients? Move all clients from Strakonice to a new district with district_id = 100
SELECT d.A2 AS district_name, d.A1, COUNT(c.client_id) AS num_of_clients FROM district d
JOIN client c
ON d.A1 = c.district_id
GROUP BY district_id, district_name
ORDER BY district_name;

UPDATE client
SET district_id = 100 
WHERE district_id = 20; 

SELECT d.A2 AS district_name, COUNT(c.client_id) AS num_of_clients FROM district d
LEFT JOIN client c
ON d.A1 = c.district_id
GROUP BY district_name
ORDER BY district_name;

#How would you spot clients with wrong or missing district_id?
SELECT client_id FROM client WHERE client_id = NULL;
SELECT client_id,
ROW_NUMBER() OVER(ORDER BY client_id) AS "ROW" FROM client ;

SELECT district_id FROM client WHERE district_id = NULL OR district_id = 0;

#Return clients to Strakonice.
UPDATE client
SET district_id = 20 
WHERE district_id = 100;

#Make a list of all the clients together with region and district, ordered by region and district.
SELECT d.A2 AS district_name, d.A3 AS region, c.client_id  FROM client c 
LEFT JOIN district d
ON c.district_id = d.A1
ORDER BY region, district_name;

#Count how many clients do we have per region and district.
SELECT d.A3 AS region, COUNT(c.client_id) as num_client  FROM client c 
LEFT JOIN district d
ON c.district_id = d.A1
GROUP BY region;

SELECT d.A2 AS district_name, COUNT(c.client_id) as num_client  FROM client c 
LEFT JOIN district d
ON c.district_id = d.A1
GROUP BY district_name;

#2.1 How many clients do we have per 10000 inhabitants?
SELECT d.A3 AS region, COUNT(c.client_id) as num_client, COUNT(c.client_id)/(d.A4/10000) AS client_per_10000 FROM client c 
JOIN district d
ON c.district_id = d.A1
GROUP BY d.A3, d.A4;

select da.A2 AS district_name, d.client_id, d.account_id from bank.disp d
join bank.client c
on d.client_id = c.client_id
join bank.district da
on da.A1 = c.district_id
ORDER BY district_name;

#List districts together with total amount borrowed and average loan amount.
SELECT da.A2 AS district_name, SUM(l.amount) AS tot_borrowed, ROUND(AVG(l.amount)) AS avg_loan FROM district da
JOIN account a 
ON da.A1 = a.district_id 
JOIN loan l 
ON a.account_id = l.account_id
GROUP BY district_name;

#List districts together with total amount borrowed and average loan amount.
SELECT da.A2 AS district_name, SUM(l.amount) OVER(PARTITION BY da.A2) AS tot_borrowed, 
ROUND(AVG(l.amount) OVER(PARTITION BY da.A2)) AS avg_loan FROM district da
JOIN account a 
ON da.A1 = a.district_id 
JOIN loan l 
ON a.account_id = l.account_id;

#Create a temporary table district_overview in the bank database which lists districts 
#together with total amount borrowed and average loan amount.
CREATE TEMPORARY TABLE bank.district_overview
SELECT da.A2 AS district_name, SUM(l.amount) AS tot_borrowed, ROUND(AVG(l.amount)) AS avg_loan FROM district da
JOIN account a 
ON da.A1 = a.district_id 
JOIN loan l 
ON a.account_id = l.account_id
GROUP BY district_name;

#Let's find for each account an owner and a disponent.





#Still working in the bank database, list the clients with no credit card.
SELECT c.client_id, ca.card_id FROM client c 
JOIN disp d
ON c.client_id = d.client_id 
JOIN card ca
ON d.disp_id = ca.disp_id
WHERE ca.card_id = " " OR ca.card_id = NULL; 
