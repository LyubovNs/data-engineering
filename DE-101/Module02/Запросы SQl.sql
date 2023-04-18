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

--Monthly Sales by Segment
select 
  order_date,
  segment,
  sales,
  sum(sales) over(partition by segment order by date_trunc('month', order_date))
from module02.orders
/

--Monthly Sales by Product Category 
select 
  category,
  sales,
  sum(sales) over(partition by category, date_trunc('month', order_date)),
  order_date
from module02.orders
/

--Sales by Product Category over time (Продажи по категориям)
select 
  category,
  order_id,
  sales,
  order_date,
  to_char(date_trunc('year', order_date), 'yyyy') as year,
  round(sum(sales) over(partition by category order by date_trunc('year', order_date)), 2) as sum_sale_by_category_per_year,
  count(order_id) over(partition by category order by date_trunc('year', order_date)) as count_order_by_category_per_year
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
/

---Profit by year
select distinct
  to_char(date_trunc('year', order_date::timestamp), 'yyyy'),
  sum(profit) over(partition by date_trunc('year', order_date::timestamp))
from module02.orders
order by to_char(date_trunc('year', order_date::timestamp), 'yyyy')
/
select 
  sum(profit) over(partition by date_trunc('year', order_date::timestamp)),
  date_trunc('year', order_date::timestamp),
  order_date::date
from module02.orders
where order_date::date <= '31.12.2016'
