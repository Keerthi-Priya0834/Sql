use adventure2_training;

-- task9: Sales Order Analysis

-- find total sales orders

select count(*) as total_sales_orders from salesorderheader;

-- find total sales amount

select sum(totaldue) as total_sales_amount from salesorderheader;

-- find average order value

select avg(totaldue) as average_order_value from salesorderheader;

-- find minimum order value

select min(totaldue) as minimum_order_value
from salesorderheader;

-- find maximum order value

select max(totaldue) as maximum_order_value
from salesorderheader;

-- find the no of unique customers

select count(distinct customerid) as unique_customers from salesorderheader;

-- find the no of unique products sold

select count(distinct productid) as unique_products_sold from salesorderdetail;

-- Task10 : Customer Revenue

-- customer id and name

select customerid as customer_id,customername as customer_name from analytics_db.customer;

-- no of orders for each customer

select customerid as customer_id,count(salesorderid) as number_of_orders from analytics_db.sales_order_header 
group by customerid;

-- total revenue for each customer

select customerid as customer_id,sum(totaldue) as total_revenue from analytics_db.sales_order_header 
group by customerid;

-- avg order value for each customer

select customerid as customer_id,avg(totaldue) as average_order_value from analytics_db.sales_order_header
group by customerid;

-- Task11 : Product Revenue

-- Find top 20 products basedon quantity solid

select productid,sum(orderqty) as total_quantity_sold from salesorderdetail 
group by productid order by total_quantity_sold desc limit 20;

-- Find top 20 products based on revenue

select productid,sum(linetotal) as total_revenue from salesorderdetail
 group by productid order by total_revenue desc limit 20;
 
-- Task12: Territory Performance

-- no of customers

 select territoryid,count(distinct customerid) as number_of_customers  from salesorderheader group by territoryid;
 
 -- no of orders
 
 select territoryid,count(salesorderid) as number_of_orders from salesorderheader  group by territoryid;
 
 -- total revenue
 
 select territoryid,sum(totaldue) as total_revenue from salesorderheader group by territoryid;
 
 -- avg order values
 
 select territoryid,avg(totaldue) as average_order_value from salesorderheader  group by territoryid;
 
 -- combining of all these is the territory performance
 
 select territoryid,count(distinct customerid) as number_of_customers,count(salesorderid) as number_of_orders,sum(totaldue) as total_revenue,
 avg(totaldue) as average_order_value from salesorderheader group by territoryid;
 
 -- Task 13 : Customer Order Report
 
 -- customer name 
 
 select concat(c.firstname, ' ', c.lastname) as customer_name from customer c;
 
 -- sales order number
 
 select salesorderid as sales_order_number from salesorderheader;
 
 -- order date
 
 select orderdate from salesorderheader;
 
 -- territory
 
 select salesterritory.name as territory from salesterritory  join salesorderheader  on salesterritory.territoryid = salesorderheade.territoryid;
  
 --  total order value
 
 select totaldue as total_order_value from salesorderheader;
 select concat(customer.firstname, ' ', customer.lastname) as customer_name,salesorderheader.salesorderid as sales_order_number,salesorderheader.orderdate,salesterritory.name as territory,salesorderheader.totaldue as total_order_value
from customer join salesorderheader on customer.customerid = salesorderheader.customerid join salesterritory on salesorderheader.territoryid = salesterritory.territoryid;

-- Task 14 : Product Sales Report

-- product name 

select product.name as product_name from product;

-- product category

select product.name as product_name,(select productcategory.name from productsubcategory join productcategory on productsubcategory.productcategoryid = productcategory.productcategoryid
where productsubcategory.productsubcategoryid = product.productsubcategoryid) as product_category from product;

-- product subcategory

select product.name as product_name,(select productsubcategory.name from productsubcategory where productsubcategory.productsubcategoryid = product.productsubcategoryid) 
as product_subcategory from product;

-- quantity sold

select product.name as product_name,(select sum(salesorderdetail.orderqty)from salesorderdetail where salesorderdetail.productid = product.productid) 
as quantity_sold from product;

-- revenue

select product.name as product_name,(select sum(salesorderdetail.linetotal)from salesorderdetail where salesorderdetail.productid = product.productid)
as revenue from product;

-- Task 15 : Employee/Salesperson Performance

-- salesperson name

select concat(person.firstname, ' ', person.lastname) as salesperson_name from salesperson join person on salesperson.businessentityid = person.businessentityid;

-- territory

select salesperson.businessentityid,(select salesterritory.name from salesterritory where salesterritory.territoryid = salesperson.territoryid) as territory 
from salesperson;

-- no of orders

select salesperson.businessentityid,(select count(salesorderheader.salesorderid)from salesorderheader where salesorderheader.salespersonid = salesperson.businessentityid) 
as number_of_orders from salesperson;

-- total sales

select salesperson.businessentityid,(select sum(salesorderheader.totaldue)from salesorderheader where salesorderheader.salespersonid = salesperson.businessentityid) 
as total_sales from salesperson;

-- avg order value

select salesperson.businessentityid,(select avg(salesorderheader.totaldue)from salesorderheader where salesorderheader.salespersonid = salesperson.businessentityid)
 as average_order_value from salesperson;
 
 -- Task 16 :  Customer Segmentation(premium,gold,silver,standard)
 
 select customerid,total_revenue,case
           when total_revenue >= 100000 then 'premium'
           when total_revenue >= 50000 then 'gold'
           when total_revenue >= 10000 then 'silver'
           else 'standard'
       end as customer_segment
       
from(select customerid,sum(totaldue) as total_revenue from salesorderheader group by customerid) as customer_sales;

-- Task 17 : Product Classification

select product.productid, product.name as product_name,sum(salesorderdetail.linetotal) as total_revenue,
       case
           when sum(salesorderdetail.linetotal) >= 100000 then 'high performer'
           when sum(salesorderdetail.linetotal) >= 50000 then 'medium performer'
           else 'low performer'
       end as product_performance
from product join salesorderdetail on product.productid = salesorderdetail.productid group by product.productid, product.name;
 
-- Task 18 : Customer Revenue CTE

-- identify top 10 customers

with customerrevenue as (select customerid,sum(totaldue) as total_revenue from analytics_db.sales_order_header group by customerid)

select customerid,total_revenue from customer_revenue order by total_revenue desc limit 10;

-- identify customers above average revenue

with customerrevenue as (select customerid,sum(totaldue) as total_revenue from analytics_db.sales_order_header group by customerid)
select customerid,total_revenue from customer_revenue where total_revenue > (select avg(total_revenue)from customer_revenue)
order by total_revenue desc;

-- identify customers below average revenue

with customer_revenue as (select customerid,sum(totaldue) as total_revenue from analytics_db.sales_order_header group by customerid)
select customerid,total_revenue from customer_revenue where total_revenue < (select avg(total_revenue)from customer_revenue)
order by total_revenue desc;

-- Task 19 : 

-- create a cte containing product, quantity sold and revenue

with product_sales as (select productid,sum(orderqty) as quantity_sold,sum(linetotal) as revenue from analytics_db.sales_order_detail group by productid)
select productid,quantity_sold,revenue from product_sales;

-- identify products contributing more than a specified percentage of total sales

with product_sales as (select productid,sum(orderqty) as quantity_sold,sum(linetotal) as revenue from analytics_db.sales_order_detail group by productid)

select productid,quantity_sold,revenue,(revenue / (select sum(revenue) from product_sales)) * 100 as sales_percentag from product_sales
where revenue > (select sum(revenue) * 0.05 from product_sales)order by revenue desc;

-- Task 20: ROW_NUMBER()

with cte as(select customerid,sum(totaldue) as revenue from sales.salesorderheader group by customerid)

select customerid,revenue,row_number() over (order by revenue desc) as customerrank from cte order by revenue desc;

-- Task 21: RANK()

with cte as(select productid,sum(linetotal) as revenue from sales.salesorderdetail group by productid)

select productid,revenue,rank() over (order by revenue desc) as productrank from cte order by revenue desc;
-- Task-22: DENSE_RANK()

with cte as(select productid,sum(linetotal) as revenue from sales.salesorderdetail group by productid)

select productid,revenue,rank() over (order by revenue desc) as productrank from cte order by revenue desc;

-- Task - 23 : 

-- calculate product revenue

select productid,sum(linetotal) as revenue from analytics_db.sales_order_detail group by productid;

-- apply ranking function partitioned by product category

with product_revenue as (
    select
        productid,productcategoryid,sum(linetotal) as revenue from analytics_db.sales_order_detail
        group by productid,productcategoryid
)
select productid,productcategoryid,revenue,rank() over (partition by productcategoryid order by revenue desc)
as product_rank from product_revenue order by productcategoryid, product_rank;

-- Task 24: Running Total

-- calculate monthly sales

select date_trunc('month', orderdate) as sales_month,sum(totaldue) as monthly_sales from analytics_db.sales_order_headerorder 
by sales_month;

-- calculate cumulative revenue using sum() over()

with monthly_sales as (select date_trunc('month', orderdate) as sales_month,sum(totaldue) as monthly_sales 
from analytics_db.sales_order_header group by date_trunc('month', orderdate)
)
select sales_month,monthly_sales,sum(monthly_sales) over (order by sales_month)as cumulative_revenue from monthly_sales
order by sales_month;

-- Task 29 : 

select customerid as customer,orderdate as order_date,totaldue as order_value,sum(totaldue) over (partition by customerid order by orderdate) 
as running_revenue from analytics_db.sales_order_header order by customerid, orderdate;

