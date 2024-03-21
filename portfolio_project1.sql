
create table walmartsales(
invoice_id varchar(30) not null primary key,
branch varchar(5) not null,
city varchar(30) not null,
customer_type varchar(30) not null,
gender varchar(30) not null,
product_line varchar(100) not null,
unit_price decimal(10,2) not null,
quantity int not null,
tax_pct float(6,4) not null,
total decimal(12, 4) not null,
date datetime not null,
time time not null,
payment varchar(15) not null,
cogs decimal(10,2) not null,
gross_margin_pct float(11,9),
gross_income decimal(12, 4),
rating float(2, 1));

## add a month name column:
alter table walmartsales add column month_name varchar(10);
update walmartsales set month_name=monthname(date);


## load the dataset:
select * from walmartsales;

## count the rows in the dataset:
select count(*) from walmartsales;

## 1. how many unique cities does the data have?
select distinct city from walmartsales;

## 2. in which city are each branch?
select distinct city,branch from walmartsales;

## 3. How many unique product lines does the data have?
select distinct Product_line from walmartsales;

## 4. what is the most selling product_line?
select sum(quantity) as qty , product_line from walmartsales group by product_line order by qty desc;


## 5. what is the total revenue by month?
select sum(total) as revenue,month_name from walmartsales group by month_name order by revenue;

## 6. which month had the largest cogs?
select sum(cogs) as cogs,month_name from walmartsales group by month_name order by cogs desc; 

## 7. which product line had the largest reveneue?
select sum(total) as revenue,product_line from walmartsales group by product_line order by revenue desc;

## 8. which city has the largest revenue?
select sum(total) as revenue,city from walmartsales group by city order by revenue;

## 9. which product line had the largest VAT?
select product_line,avg(tax_pct) as VAT from walmartsales group by product_line order by VAT desc; 

## 10. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
select avg(quantity) from walmartsales;  #-5.5
select product_line ,
case 
when avg(quantity)>5.5 then 'good'
else 'bad'
end as remark
from walmartsales group by product_line;

## 11.  Which branch sold more products than average product sold?
select branch,sum(quantity) from walmartsales group by branch having sum(quantity)>(select avg(quantity) from walmartsales);

## 12. which is the most common product line by gender?
select product_line,gender,count(gender) from walmartsales group by gender,product_line order by count(gender) desc;


## 13. what is the average rating of each product_line
select product_line,round(avg(rating),2) as rating from walmartsales group by product_line order by rating desc ;

## 14. how many unique customers type does the data have?
select distinct customer_type from walmartsales;

## 15. how many unique payment method does the data have?
select distinct payment from walmartsales;

## 16. what is the most common customer type?
select customer_type, count(customer_type) as count from walmartsales group by customer_type order by count desc;

## 17. which customer type buys the most?
select customer_type,sum(quantity) as bought from walmartsales group by customer_type order by bought desc;

## 18. what is gender of most of the customer?
select gender,count(gender) as count from walmartsales group by gender order by count desc;


## 19. what is the gender distibution per branch?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM walmartsales
WHERE branch = "C"
GROUP BY gender
ORDER BY gender_cnt DESC;
#
select gender,count(gender) as gender_cnt from walmartsales where branch='A'
group by gender order by gender_cnt;
#
select gender,count(*) as gender_cnt from walmartsales where branch='B'
group by gender order by gender_cnt;

## 20. whic customer types brings the most revenue?
select customer_type,sum(total) as revenue from walmartsales group by customer_type order by revenue desc;

## 21. which city has the largest tax/VAT?
select city,sum(tax_pct) as tax from walmartsales group by city order by tax desc;

## 22. which customer types pays the most in vat?
select customer_type,avg(tax_pct) as VAT from walmartsales group by customer_type order by VAT desc;