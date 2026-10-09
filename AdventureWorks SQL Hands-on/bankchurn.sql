select * from bank_churn

select * from bank_churn where age>40

select Surname from bank_churn where age>40 and Geography='france';


select * from bank_churn where Geography <> 'france'

select * from bank_churn where Geography != 'france'


#orderby
select * from bank_churn where Geography = 'france'
order by Surname asc, Balance asc;

select * from bank_churn where Geography = 'france'
order by Geography desc, Balance asc;

select distinct Geography from bank_churn

select distinct Geography,Gender from bank_churn

--retrieve all the data of france whose name is starting with b and age

-- retrieve balance as per location
select sum(Balance) as total_balance from bank_churn;

select * from bank_churn where age=41 and 56 and 18;
SELECT * FROM bank_churn;

SELECT DISTINCT Geography FROM bank_churn;

SELECT CONCAT(Surname, ' - ', Gender) AS FullName FROM bank_churn;

SELECT Surname AS Customer_Name FROM bank_churn;

SELECT SUM(EstimatedSalary) AS Total_Salary FROM bank_churn;

SELECT * FROM bank_churn WHERE Geography = 'France';

SELECT * FROM bank_churn WHERE Age > 42;

SELECT * FROM bank_churn WHERE Age = 42;
SELECT * FROM bank_churn WHERE Geography = 'France'AND Age > 42;

SELECT * FROM bank_churn WHERE NOT Geography = 'France';

SELECT *FROM bank_churn WHERE Balance > 1000;

SELECT * FROM bank_churn ORDER BY EstimatedSalary DESC;

SELECT * FROM bank_churn ORDER BY EstimatedSalary DESC LIMIT 3;

SELECT * FROM bank_churn ORDER BY Geography ASC, Balance DESC;

SELECT Geography, COUNT(*) AS Total_Customers FROM bank_churn GROUP BY Geography;

SELECT Geography, AVG(Balance) AS Average_Balance FROM bank_churn GROUP BY Geography;

SELECT Geography, MAX(Balance) AS Maximum_Balance FROM bank_churn GROUP BY Geography;

SELECT Geography, SUM(EstimatedSalary) AS Total_Salary FROM bank_churn GROUP BY Geography HAVING SUM(EstimatedSalary) > 500000;

SELECT Geography, SUM(EstimatedSalary) AS Total_Salary FROM bank_churn GROUP BY Geography HAVING SUM(EstimatedSalary) > 500000;`person.person``person.person`