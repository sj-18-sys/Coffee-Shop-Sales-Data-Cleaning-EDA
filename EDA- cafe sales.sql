-- EDA

-- Total sales by month
select date_format(`Transaction Date`, '%Y-%m') as month,
sum(`Total Spent`) as total_sales
from clean_data
group by month
order by month
;

-- Top selling months
select date_format(`Transaction Date`, '%Y-%m') as month,
sum(`Total Spent`) as total_sales
from clean_data
group by month
order by total_sales desc
limit 3
;

-- Top selling items
select item, sum(`Quantity`) as total_quantity, 
sum(`Total Spent`) as total_sales
from clean_data
group by item
order by total_sales desc
limit 5;

-- Sales by payment method
select
`Payment Method`, count(*) as transactions,
sum(`Total Spent`) as total_sales
from clean_data
group by `Payment Method`
order by total_sales desc
;

-- Performance by Location
select Location, sum(`Total Spent`) as total_sales,
count(*) as transactions_num
from clean_data
group by Location
order by total_sales desc
;

-- Average spend per transaction 
select round(avg(`Total Spent`),2) as avg_transaction_value
from clean_data
where `Total Spent` is not null
;





