#Use a CTE to display the first account opened by a district.
SELECT account_id, district_id, date, 
RANK() OVER (PARTITION BY district_id ORDER BY date) AS position
FROM account
;


WITH cte_accounts AS 
(
SELECT account_id, district_id, date, 
RANK() OVER (PARTITION BY district_id ORDER BY date) AS position
FROM account
)
SELECT * FROM cte_accounts WHERE position = 1
;

USE bank;
#In order to spot possible fraud, we want to create a view last_week_withdrawals with total withdrawals by client in the last week.
DROP VIEW last_week_withdrawals;
CREATE VIEW last_week_withdrawals AS 
SELECT account_id, ROUND(SUM(amount)) FROM trans 
WHERE type = "VYDAJ" AND date IN (SELECT DATE_ADD(MAX(date), INTERVAL 7 DAY) FROM trans)
GROUP BY account_id
LIMIT 100;

SELECT * FROM last_week_withdrawals;
