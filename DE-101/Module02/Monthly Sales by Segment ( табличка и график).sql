--Monthly Sales by Segment ( табличка и график)
select 
  segment,
  sales,
  order_date,
  round(sum(sales) over(partition by segment order by date_trunc('month', order_date)), 2)
from module02.orders