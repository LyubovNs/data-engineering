# Задание для модуля 2

## Установка БД
Установлена БД postgres на windows (в перспективе будет запущена в docker)
В качестве интерфейса выбрана aqua data studio и установлен DBear в том числе

## Загрузка данных в БД
Для загрузки использованы готовые [скрипты](https://github.com/Data-Learn/data-engineering/tree/master/DE-101%20Modules/Module02/DE%20-%20101%20Lab%202.1)

## SQL запросы
Выполнено несколько простых 

1. Месячные продажи по сегментам
```
select
  order_date,
  segment,
  sales,
  sum(sales) over(partition by segment order by date_trunc('month', order_date))
from module02.orders
```
2. Количество продаж по категориям (по месяцам)
```
select 
  category,
  order_date,
  order_id,
  sales,
  count(sales) over(partition by category order by date_trunc('year', order_date))
from module02.orders
```
3. Выручка по годам
```
select distinct
  to_char(date_trunc('year', order_date::timestamp), 'yyyy'),
  sum(profit) over(partition by date_trunc('year', order_date::timestamp))
from module02.orders
order by to_char(date_trunc('year', order_date::timestamp), 'yyyy')
```
4. Продажи по катеогриям по годам
```
select 
  category,
  order_id,
  sales,
  order_date,
  to_char(date_trunc('year', order_date), 'yyyy') as year,
  round(sum(sales) over(partition by category order by date_trunc('year', order_date)), 2) as sum_sale_by_category_per_year,
  count(order_id) over(partition by category order by date_trunc('year', order_date)) as count_order_by_category_per_year
from module02.orders
```

## Нарисовать модель данных в SQLdbm

## Нарисовать графики в Google Sheets

## Нарисовать графики в KlipFolio