select *
from dirty_cafe_sales
;

CREATE TABLE `clean_data` (
  `Transaction ID` text,
  `Item` text,
  `Quantity` int DEFAULT NULL,
  `Price Per Unit` double DEFAULT NULL,
  `Total Spent` text,
  `Payment Method` text,
  `Location` text,
  `Transaction Date` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into clean_data
	select *
    from dirty_cafe_sales
;

select *
from clean_data;

-- check for duplicates
with duplicate_cte as(
select *,
	row_number() over (partition by `Transaction ID`) as row_num
    from clean_data
)
select *
from duplicate_cte
where row_num >1
;

-- Replace missing values with null

update clean_data
set `Item` = case
	when `Item` in ('UNKNOWN','ERROR') or trim(`Item`) = '' then null
else `Item`
end
    ;
select *
from clean_data
where item is null
;

 select distinct `clean_data`.`Payment Method`
 from clean_data
 ;

update clean_data
set `Payment Method` = case
	when `Payment Method` in ('UNKNOWN','ERROR') or trim(`Payment Method`) = '' then null
else `Payment Method`
end
    ;

select *
from clean_data
where `Total Spent`= 'UNKNOWN' or Location = 'UNKNOWN'
;

update clean_data
set `Total Spent` = case
	when `Total Spent` in ('UNKNOWN','ERROR') or trim(`Total Spent`) = '' then null
else `Total Spent`
end
    ;
    
update clean_data
set `Location` = case
	when `Location` in ('UNKNOWN','ERROR') or trim(`Location`) = '' then null
else `Location`
end
    ;
    
-- Changing the Transaction date datatype to datetime from text

UPDATE clean_data
SET `Transaction Date` = NULL
WHERE `Transaction Date` IS NOT NULL
  AND `Transaction Date` NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$';

ALTER TABLE clean_data
MODIFY COLUMN `Transaction Date` DATE;

-- Remove invalid rows
select *
from clean_data
where `Quantity` is null and `Total Spent` is null
;

select *
from clean_data
where `Transaction ID` is null or `Transaction Date` is null
;

alter table clean_data
add column is_date_missing tinyint default 0;
update clean_data
set is_date_missing = 1
where `Transaction Date` is null
;
 
-- Validate the Transaction Calculations
alter table clean_data
add column validate_transaction varchar(100);

update clean_data
set `validate_transaction` = 'yes'
where `Quantity` is not null
	and `Price Per Unit` is not null
	and `Total Spent` is not null
	and abs(`Total Spent` - (`Quantity` * `Price Per Unit`)) = 0
;

-- Date range
select min(`Transaction Date`) as earliest_date,
max(`Transaction Date`) as latest_date
from clean_data;

-- missing values
select 
sum(case when `is_date_missing` = 1 then 1 else 0 end) as missing_transaction
from clean_data;

-- invalid transaction
select 
sum(case when `validate_transaction` is null then 1 else 0 end) as invalid_transactions
from clean_data
;




