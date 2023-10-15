-- ----------------------------------------------------------------------------------
-- ------------------------ Exploring Data  And Cleaning ----------------------------
-- calculate Discount Value

select	
	round(Sales,2) as Sales,
	Quantity,
	Discount,
	round(Profit,2) as Profit,
	round(Sales * Discount,2) as discountvalue,
	Sales - Profit - Discount as cost
from Orders

-- add new column called DiscountValue
alter table Orders
add DiscountValue float

-- Entered the calculation in DiscountVAlue
update Orders
set DiscountValue = round(Sales * Discount,2)



-- calculate Cost
select	
	round(Sales,2) as Sales,
	Quantity,
	Discount,
	round(Profit,2) as Profit,
	DiscountValue,
	-(Profit + DiscountValue - Sales) as Cost
	-- Sales - Profit as Cost

from Orders

-- add new column
alter table Orders
add Cost float


-- entered the calculation in Cost
update Orders
set Cost = -(Profit + DiscountValue - Sales)

-- calculate the cost per unit
select	
	sales,
	Quantity,
	Discount,
	round(Profit,2) as Profit,
	DiscountValue,
	COGS,
	Sales/ Quantity  as "Unit cost"
from Orders
-- where Sales = 2443.905

-- add new column 
alter table Orders
add "Unit cost" float

-- entered the calculation
update Orders
set "Unit cost" = Sales/ Quantity

select GETDATE()

select 
	[Ship Date]
from Orders
-- top 10 customer id buy
select top 10 
	[Customer ID],
	count(*) as cou,
	[Customer Name],
	Segment
from Orders
group by [Customer ID], [Customer Name], Segment
order by cou desc;


-- sales by category
select 
	distinct(Category),
	round(sum(Profit),2) as total_profit
from orders
group by Category 
order by total_profit desc

-- returned ordres
select *
from Orders as ord
join returns as ret
on ord.[Order ID] = ret.[Order ID]
where ret.[Order ID] = ord.[Order ID]
order by ord.[Row ID] asc

-- Best selling manager
select 
	p.People,
	ord.Region,
	round(sum(ord.Profit),2) as total
from Orders as ord
join People as p
on ord.Region = p.Region
group by p.People , ord.Region
order by total desc


-- top 10 customer
select 
	distinct[Customer ID],
	count(*) as coun
from orders
group by [Customer ID]
order by coun desc;

select distinct([Ship Mode])
from Orders