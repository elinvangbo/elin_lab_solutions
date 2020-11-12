#Find out the average number of transactions by account. 
USE bank;
SELECT account_id, ROUND(AVG(COUNT(trans_id)) OVER (PARTITION BY account_id)) 
AS avg_num_trans FROM trans
GROUP BY account_id;

#Get those accounts that have more transactions than the average.
SELECT account_id, ROUND(AVG(COUNT(trans_id)) OVER (PARTITION BY account_id)) 
AS avg_num_trans FROM trans
GROUP BY account_id
HAVING AVG(COUNT(trans_id)) > (SELECT ROUND(COUNT(trans_id) / COUNT(DISTINCT account_id)) AS avg_trans FROM trans);

SELLECT account_id, avg(amount) AS average FROM trans
GROUP BY account_id 
HAVING average > (SELECT ROUND(COUNT(trans_id) / COUNT(DISTINCT account_id)) AS avg_trans FROM trans);



#avg number of transactions 
SELECT ROUND(COUNT(trans_id) / COUNT(DISTINCT account_id)) AS avg_trans FROM trans;






#Get a list of accounts from Central Bohemia using a subquery.
USE bank;
SELECT account_id FROM account 
WHERE district_id IN (SELECT A1 FROM district WHERE A3 = "Central Bohemia");
#0.0029/0.00014
#0.0037

#Rewrite the previous as a join query.
SELECT a.account_id, a.district_id FROM account a 
LEFT JOIN district d
ON a.district_id = d.A1 
WHERE A3 = "Central Bohemia";
#0.0046/0.00015
#0.0029

#Find the most active customer for each district in Central Bohemia.
SELECT account_id,
ROUND(MAX(SUM(amount)) OVER (PARTITION BY account_id)) AS tot_amount
FROM trans
WHERE account_id IN 
(
    SELECT account_id FROM account 
	WHERE district_id IN 
	(
        SELECT A1 FROM district WHERE A3 = "Central Bohemia"
	)
)
GROUP BY account_id
ORDER BY tot_amount DESC;

#get all account id's in Central Bohemia 
SELECT account_id FROM account 
	WHERE district_id IN 
	(
        SELECT A1 FROM district WHERE A3 = "Central Bohemia"
        );
        
select district.A2 district_name, account_id, round(total) as total
from 
(
  select ac.account_id, ac.district_id, sum(tr.amount) as total, 
  rank() over (partition by district_id order by sum(tr.amount) desc) as position
  from bank.account ac
  inner join bank.trans tr
  using (account_id)
  group by ac.account_id
) as t
inner join district on t.district_id = district.A1
where position = 1
order by district_id;

select ac.account_id, ac.district_id, sum(tr.amount) as total, 
rank() over (partition by district_id order by sum(tr.amount) desc) as position
from bank.account ac
inner join bank.trans tr
using (account_id)
group by ac.account_id;


SELECT d.client_id , di.A2, di.A3, sum(t.amount), rank() over (partition by di.A2 order by sum(t.amount)) as ranking FROM bank.trans as t
join bank.disp as d using (account_id)
join bank.client as c using (client_id)
join bank.district as di on (district_id=A1)
Where A3 = 'north Bohemia';

select district.A2 district_name, account_id, round(total) as total
from
(
  select ac.account_id, ac.district_id, sum(tr.amount) as total,
  rank() over (partition by district_id order by sum(tr.amount) desc) as position
  from bank.account ac
  inner join bank.trans tr
  using (account_id)
  group by ac.account_id
) as t
inner join district as d
on t.district_id = d.A1
where position = 1
and d.A3 = ‘central Bohemia’
order by t.district_id;

