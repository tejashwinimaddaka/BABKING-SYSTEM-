create database HMBank;
use HMBank;

/*TASK 1*/

create table Customers(
customer_id int primary key identity(001,1),
first_name varchar(30) ,
last_name varchar(30) , 
DOB date , 
email varchar(100) , 
phone_number varchar(100) ,
address varchar(50) 
);

insert into Customers values('Anne','John','2001-10-12', 'annejohn@gmail.com','9852654753','14/480,Church street,Miami');
insert into Customers values('Emma','Thomas','1998-01-08', 'emma@gmail.com','8695756984','1C-10, Lakeview,Portland');
insert into Customers values('Noah','Olivia','2000-09-04', 'olivia12@gmail.com','789654357','12-B,Grifender street,New York');
insert into Customers values('David','Son','1999-02-05', 'david8@gmail.com','7895651423','63/1,Johnson street,San Jose');
insert into Customers values('Martin','Rich','2002-04-06', 'martinz@gmail.com','9563285412','56/9,Wainut,Tucson');
insert into Customers values('Blue','Harris','1997-10-03', 'blue97@gmail.com','6859352946','35-D,Main street,Fort Worth');
insert into Customers values('Kevin','Jose','2003-07-12', 'kevinjose@gmail.com','8534976581','89/7,Cedar,Honolulu');
insert into Customers values('Pat','Carol','2001-04-09', 'patcarol@gmail.com','7689572612','475,Maple,Omaha');
insert into Customers values('Amy','Mathew','2004-10-12', 'amymathew7@gmail.com','7654892642','165/1B,Kingston,Las Vegas');
insert into Customers values('Laura','James','1998-03-05', 'laurajames9@gmail.com','9556411791','164,Second street,Phoenix');

create table Accounts(
account_id varchar(20) primary key,
customer_id int, 
account_type varchar(20),
balance decimal(20,2),
foreign key(customer_id) references Customers(customer_id) 
);

insert into Accounts values(4568794568,1,'savings',0.00);
insert into Accounts values(2563597841,2,'current',1900.00);
insert into Accounts values(8659145286,3,'current',7856.00);
insert into Accounts values(7568246648,4,'savings',-1500.00);
insert into Accounts values(2487965441,5,'zero_balance',5600.00);
insert into Accounts values(3774662889,6,'savings',47080.90);
insert into Accounts values(4757678441,7,'zero_balance',148300.00);
insert into Accounts values(5896423598,8,'savings',165000.00);
insert into Accounts values(5221440003,9,'zero_balance',2000.00);
insert into Accounts values(2336640078,10,'current',38250.00);


create table Transactions(
transaction_id varchar(100) primary key, account_id varchar(20),
transaction_type varchar(20),
amount decimal(8,2), transaction_date date,
foreign key (account_id) references Accounts(account_id)
);

insert into Transactions values('T7609182336333033272666',4568794568,'withdrawal',10000.00,'2023-12-30');
insert into Transactions values('T1235682336333033272456',2563597841,'deposit',250000.90,'2022-06-12');
insert into Transactions values('T9409145897333033272898',8659145286,'transfer',11060.00,'2021-11-03');
insert into Transactions values('T2709182336999993272753',4568794568,'deposit',120050.50,'2024-06-22');
insert into Transactions values('T2129182336333035654159',2487965441,'transfer',1600.00,'2020-03-13');
insert into Transactions values('T9809182336347326272369',4568794568,'withdrawal',75000.00,'2023-02-07');
insert into Transactions values('T2409182336333033272666',4757678441,'deposit',29500.00,'2024-07-11');
insert into Transactions values('T5409182336396458272147',4568794568,'deposit',50000.00,'2024-06-22');
insert into Transactions values('T3209182336362351272852',5221440003,'withdrawal',90800.00,'2020-10-28');
insert into Transactions values('T4809182336316598272862',2487965441,'deposit',346120.00,'2024-12-01');

/*TASK 2*/

/* 1.Write a SQL query to retrieve the name, account type and email of all customers.*/
select Customers.first_name,Customers.last_name,Accounts.account_type,Customers.email 
from Customers join Accounts on Customers.customer_id=Accounts.customer_id;

/* 2.Write a SQL query to list all transaction corresponding customer*/
select Customers.first_name,Customers.last_name,Transactions.*
from Customers 
join Accounts on Customers.customer_id=Accounts.customer_id
join Transactions on Accounts.account_id=Transactions.account_id;

/* 3.Write a SQL query to increase the balance of a specific account by a certain amount.*/
update Accounts set balance=balance+5000 where balance=10000; 
select * from Accounts;

/* 4.Write a SQL query to Combine first and last names of customers as a full_name.*/
select first_name+' '+last_name as full_name from Customers;

/* 5.Write a SQL query to remove accounts with a balance of zero where the account 
type is savings.*/

/*deleting transaction record*/
delete t
from Transactions t
join Accounts a on t.account_id = a.account_id
where a.Balance = 0 and a.Account_Type = 'savings';
/* deleting record from account*/
delete from Accounts
where Balance = 0 and Account_Type = 'savings';

/* 6.Write a SQL query to Find customers living in a specific city.*/
select * from customers where address like '%Miami%'; 

/* 7.Write a SQL query to Get the account balance for a specific account.*/
select balance from Accounts where account_id=2487965441;

/* 8.Write a SQL query to List all current accounts with a balance greater than $1,000.*/
select * from Accounts where account_type='current' and balance>1000;

/* 9.Write a SQL query to Retrieve all transactions for a specific account.*/
select * from Transactions where account_id=2487965441;  

/* 10.Write a SQL query to Calculate the interest accrued on savings accounts based on a 
given interest rate.*/
select balance, balance * 0.1 as interest from Accounts where account_type='savings';

/* 11.Write a SQL query to Identify accounts where the balance is less than a specified 
overdraft limit.*/
select * from Accounts where balance < -1000;  

/* 12.Write a SQL query to Find customers not living in a specific city.*/
select * from Customers where address not like '%Miami%';  

/*TASK 3*/

/* 1.Write a SQL query to Find the average account balance for all customers.*/
select avg(balance) as average_balance from Accounts ; 

/* 2.Write a SQL query to Retrieve the top 10 highest account balances.*/
select balance from Accounts order by balance desc offset 0 rows fetch first 10 rows only;

/* 3.Write a SQL query to Calculate Total Deposits for All Customers in specific date.*/
select count(transaction_type) Total_deposits 
from Transactions
where transaction_type='deposit' and transaction_date='2024-06-22';

/* 4.Write a SQL query to Find the Oldest and Newest Customers.*/
select min(transaction_date) as Oldest_customer, max(transaction_date) as Newest_customer
from Transactions;

/* 5.Write a SQL query to Retrieve transaction details along with the account type.*/ 
select Transactions.*,account_type from Transactions
join Accounts on Transactions.account_id=Accounts.account_id;

/* 6.Write a SQL query to Get a list of customers along with their account details.*/
select Customers.*,Accounts.* from Customers
join Accounts on Customers.customer_id=Accounts.customer_id;

/* 7.Write a SQL query to Retrieve transaction details along with customer information for a 
specific account.*/
select Transactions.*,Customers.* from Customers
join Accounts on Customers.customer_id=Accounts.customer_id
join Transactions on Accounts.account_id=Transactions.account_id where Accounts.account_id=8659145286;

/* 8.Write a SQL query to Identify customers who have more than one account*/
select Customers.* 
from Customers
group by Customers.customer_id,Customers.first_name,Customers.last_name,
Customers.DOB,Customers.email,Customers.phone_number,Customers.address
having count(Customers.customer_id)>1 ;

/* 9.Write a SQL query to Calculate the difference in transaction amounts between deposits and 
withdrawals.*/
select (select sum(amount) from Transactions where transaction_type = 'deposit') -
(select sum(amount) from Transactions where transaction_type = 'withdrawal') 
as Difference_in_amount;

/* 10.Write a SQL query to Calculate the average daily balance for each account over a specified 
period.*/
select Transactions.account_id, avg(balance) as Avg_daily_balance
from Transactions
join Accounts on Transactions.account_id=Accounts.account_id
where transaction_date between '2021-11-03' and '2024-07-11'
group by Transactions.account_id;

/* 11. Calculate the total balance for each account type.*/
select Accounts.account_type,sum(Accounts.balance) as Total_balance
from Accounts
join Customers on Accounts.customer_id=Customers.customer_id
group by Accounts.account_type;

/* 12.Identify accounts with the highest number of transactions order by descending order*/
select Accounts.*,count(Transactions.account_id) as no_of_transactions
from Accounts
join Transactions on Accounts.account_id=Transactions.account_id
group by Transactions.account_id, Accounts.account_id,Accounts.customer_id,
Accounts.account_type,Accounts.balance
order by no_of_transactions desc;

/* 13.List customers with high aggregate account balances, along with their account types.*/
select account_type, account_id, sum(balance) as agg_acc_bal
from Accounts
group by account_id,account_type
order by agg_acc_bal desc offset 0 rows fetch first 5 rows only ;

/*14 Identify and list duplicate transactions based on transaction amount, date, and account.*/
select amount, transaction_date, account_id, count(*) as Duplicate_count
from Transactions
group by amount, transaction_date, account_id
having count(*) > 1;

/*TASK 4*/

/* 1.Retrieve the customer(s) with the highest account balance.*/
select c.*, (select a.balance from Accounts a 
where a.customer_id = c.customer_id and a.balance =
(select max(balance) from Accounts)) as balance from Customers c
where (select max(balance) from Accounts a 
where a.customer_id = c.customer_id) = (select max(balance) from Accounts);

/* 2.Calculate the average account balance for customers who have more than one account*/
select avg(balance) as Avg_acc_balance
from Accounts
where customer_id in (select customer_id from Accounts
group by customer_id
having count(account_id) > 1);

/* 3.Retrieve accounts with transactions whose amounts exceed the average transaction amount*/
select account_id, amount,(select avg(amount) from Transactions) as Average_transaction_amount
from Transactions
where amount > (select avg(amount)
from Transactions);

/* 4.Identify customers who have no recorded transactions.*/
select * from Customers
where customer_id NOT IN (select distinct customer_id 
from Accounts 
where account_id IN (select distinct account_id 
from Transactions));

/* 5.Calculate the total balance of accounts with no recorded transactions.*/
select sum(a.balance) as Total_balance
from Accounts a
where a.account_id NOT IN (select t.account_id
from Transactions t);

/* 6.Retrieve transactions for accounts with the lowest balance.*/
select Transactions.*,Accounts.balance
from Transactions
right join Accounts on Transactions.account_id=Accounts.account_id
where Accounts.balance=
(select min(balance) from Accounts );

/* 7.Identify customers who have accounts of multiple types.*/
select c.customer_id, c.first_name, c.last_name
from Customers c
where(select count(distinct a.account_type)
from Accounts a
where a.customer_id = c.customer_id)>1;

/* 8.Calculate the percentage of each account type out of the total number of accounts.*/
select account_type, count(*) * 100.0 / (select count(*) from Accounts) as Percentage
from Accounts
group by account_type;

/* 9.Retrieve all transactions for a customer with a given customer_id.*/
select *
from Transactions t
where t.account_id = (select a.account_id
from Accounts a
where a.customer_id = '9');

/* 10. Calculate the total balance for each account type, including a subquery within the SELECT 
clause.*/
select a.account_type,(select sum(balance) 
from Accounts 
where account_type = a.account_type) as Total_balance
from Accounts a
group by a.account_type;