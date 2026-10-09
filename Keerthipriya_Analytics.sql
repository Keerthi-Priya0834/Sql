use analytics;

-- creating the  tables in order

create table person (
    personid int primary key,
    firstname varchar(50),
    lastname varchar(50)
);

select* from person;

create table salesterritory (
    territoryid int primary key,
    territoryname varchar(50),
    country varchar(50)
);

select * from salesterritory;

create table sales_customer (
    customerid int primary key,
    personid int,
    territoryid int
);

select * from sales_customer;

create table salesperson (
    salespersonid int primary key,
    personid int,
    territoryid int
);

select * from salesperson;

create table salesorderheader (
    orderid int primary key,
    customerid int,
    salespersonid int,
    territoryid int,
    orderdate date,
    totalamount decimal(10,2)
);

select * from salesorderheader;

create table salesorderdetail (
    orderdetailid int primary key,
    orderid int,
    productid int,
    quantity int,
    unitprice decimal(10,2)
);

select * from salesorderdetail;

create table productcategory (
    categoryid int primary key,
    categoryname varchar(100)
);

select * from productcategory;

create table productsubcategory (
    subcategoryid int primary key,
    subcategoryname varchar(100),
    categoryid int
);

select * from productsubcategory;

create table product (
    productid int primary key,
    productname varchar(100),
    subcategoryid int,
    unitprice decimal(10,2)
);

select * from product;

use analytics;

-- Task 3: Create Customer Analysis Table

create table customeranalysis (
    customerid int primary key ,
    customername varchar(100) not null,
    territoryid int null,
    totalorders int not null default 0,
    totalrevenue decimal(18,2) not null default 0.00,
    customersegment varchar(50) null,
    createddate datetime not null default current_timestamp
);

select * from customeranalysis;

-- Task 4: Create Product Performance Table

add column email varchar(100);

create table productperformance (
    productid int primary key,
    productname varchar(100) not null,
    productcategory varchar(100) null,
    productsubcategory varchar(100) null,
    totalquantitysold int not null default 0,
    totalrevenue decimal(18,2) not null default 0.00,
    averagesellingprice decimal(18,2) null,
    productrank int null,
    performancecategory varchar(50) null
);

select * from productperformance;

-- Task 5: ALTER TABLE Practice

alter table customeranalysis
add column email varchar(50);

alter table customeranalysis
modify column customersegment varchar(100);

select * from customeranalysis;

alter table customeranalysis
modify column customersegment varchar(100) default 'regular';

alter table customeranalysis
add constraint chk_totalorders check (totalorders >= 0);

alter table customeranalysis
add constraint uq_email unique (email);

alter table customeranalysis
rename column email to customeremail;

alter table customeranalysis
drop index uq_email;

alter table customeranalysis
drop column customeremail

select * from customeranalysis

-- Task 6: INSERT

insert into customeranalysis
(customerid, customername, territoryid, totalorders, totalrevenue, customersegment, createddate)
values(1, 'john smith', 1, 5, 25000.00, 'premium', '2026-08-01'),
(2, 'mary johnson', 2, 3, 15000.50, 'regular', '2026-08-02'),
(3, 'david brown', 1, 8, 42000.75, 'premium', '2026-08-03'),
(4, 'sarah wilson', 3, 2, 7500.00, 'regular', '2026-08-04'),
(5, 'michael davis', 2, 10, 55000.25, 'high value', '2026-08-05');

select * from customeranalysis;

-- Task-7 update

update customeranalysis
set customersegment =
case
    when totalrevenue >= 10000 then 'premium'
    when totalrevenue between 5000 and 9999 then 'gold'
    when totalrevenue between 1000 and 4999 then 'silver'
    when totalrevenue < 1000 then 'standard'
    else 'standard'
end
where customerid > 0;

-- Task 8 -- Delete
-- first we check the records before we are deleting
 
 select customerid, customername, totalrevenue, customersegment
from customeranalysis
where customerid in (1, 2, 3, 4, 5);

delete from customeranalysis
where customerid in (1, 2, 3, 4, 5);

select * from customeranalysis;





