select *
from module02.orders
/
select *
from module02.people
/
select *
from module02.returns
/
--Total Sales
select 
  round(sum(sales), 2)
from module02.orders 
/
--Total Profit
select 
  round(sum(profit), 2)
from module02.orders 
/
--Profit per Order (прибыль с каждого заказа)
select 
  order_id, 
  profit
from module02.orders
/
--Sales per Customer
select 
  order_id, 
  customer_id,
  customer_name
from module02.orders
/
--Avg. Discount
select 
  round(avg(discount), 2)
from module02.orders
/
--Monthly Sales by Segment ( табличка и график)
select 
  order_date,
  segment,
  sales,
  sum(sales) over(partition by segment order by date_trunc('month', order_date))
from module02.orders
/
--Monthly Sales by Product Category (табличка и график)
select 
  order_date,
  category,
  sales,
  sum(sales) over(partition by category order by date_trunc('month', order_date))
from module02.orders
/
--Sales by Product Category over time (Продажи по категориям)
select 
  order_date,
  category,
  sales,
  count(sales) over(partition by category order by date_trunc('month', order_date))
from module02.orders
/
--Sales and Profit by Customer
select 
  customer_id,
  customer_name,
  round(sales, 2),
  round(profit, 2),
  round(sum(sales) over(partition by customer_id), 2) as sales_by_customer,
  round(sum(profit) over(partition by customer_id), 2) as profit_by_customer
from module02.orders
/
--Sales per region
select 
  region,
  sales,
  round(sum(sales) over(partition by region order by date_trunc('month', order_date)), 2) as sales_by_region,
  order_date,
  dense_rank() over(partition by date_trunc('month', order_date) order by region)
from module02.orders