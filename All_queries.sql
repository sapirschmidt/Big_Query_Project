Importan issues

make sure you are on your project
add the public data

back tick ``




SELECT * 
=========


What is `select *`?
Selecting all the columns from the table


Action Items:
----------------------
1. Review Documentation - Official documentation on Query Syntax

https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax?hl=en


2. Run a query - copy to the Query Editor

SELECT
  *
FROM
  `sql_tutorial.customers`


3. Change table name to employees
4. Using Alias [as] to rename the column name
5. Extract column names by clicking on the table schema
6. Using alias by mistake  
7. Select * Except

Practice by yourself


06 

BigQuery SQL shortcuts
=======================


Query syntax
SELECT
  *
FROM
  `sql_tutorial.customers`


Shortcuts
---------------
Split or move active tab to right == Ctrl + Alt + ] 
Split or move active tab to left  == Ctrl + Alt + [
Table details         == Ctrl + click on the table name in the query editor
Run query             == Ctrl + Enter
Run selected query    == Ctrl + e
SQL autosuggest       == Tab  or  Ctrl + Space
Format Query          == Ctrl + Shift + f
multiline selection   == Alt + mouse
duplicate row         == Ctrl + c   &   Ctrl + v
delete row            == Ctrl + x
Comment               == Ctrl + ?
multiline comment     == /*  &   */



07 Distinct


SELECT DISTINCT
===============

A SELECT DISTINCT statement discards duplicate rows and returns only the remaining rows.

Documentation
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax?hl=en#select_distinct


DISTINCT syntax

SELECT
  DISTINCT EmployeeID,
  ShipType
FROM
  `sql_tutorial.orders`



GROUP BY syntax

SELECT
  EmployeeID,
  ShipType
FROM
  `sql_tutorial.orders`
GROUP BY
  1,
  2



08 Where

WHERE clause  - AND  / OR
===========================

Only rows whose bool_expression evaluates TRUE are included. 
Rows whose bool_expression evaluates to NULL or FALSE are discarded.


Documentation:
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax?hl=en#where_clause



How to use constrains on different Fields types?
------------------------------------------------
SELECT
  *
FROM
  `sql_tutorial.orders`
WHERE
  -- INTEGER constrain
--   ShipDuration = 32 
  -- STRING constrain
--   CustomerID = 'NOTNA'
--   CustomerID = "SALIL"
  -- DATE constrain
--   OrderDate = '2019-05-16'
        --     'YYYY-MM-DD'     
--   OrderDate = "2019-05-16"
  -- FLOAT constrain
--   ShipWeight = 152


SELECT
  CustomerID, OrderID, OrderDate
FROM
  `sql_tutorial.orders`
WHERE 
   ShipDuration = 32
   OR 
   ShipType = 'C'

  
Action Items
------------
What is bool_expression ?


-- Integers example
SELECT
  1 > 2  AS bool_expression_1,
  1 < 2  AS bool_expression_2,
  1 != 2  AS bool_expression_3,
  1 = 2 AS bool_expression_4,
  1 > cast(null as int) as bool_expression_5,
  cast(null as int) = cast(null as int) as bool_expression_6


-- String example
SELECT
  'a' > 'b'   AS bool_expression_1,
  'a' < 'b'   AS bool_expression_2,
  'a' = 'b'   AS bool_expression_3,
  'a' <  'aa'  AS bool_expression_4,
  'a' <= 'aa' AS bool_expression_5,
  'a'  >  cast(null as string) as bool_expression_6,
  cast(null as string) = cast(null as string) as bool_expression_7



logical operators
--------------------------
https://cloud.google.com/bigquery/docs/reference/standard-sql/operators#logical_operators


SELECT
  TRUE  AND TRUE   AS T_and_T,
  TRUE  AND FALSE  AS T_and_F,
  FALSE AND FALSE  AS F_and_F,
  FALSE AND TRUE   AS F_and_T,
  TRUE  OR  TRUE   AS T_or_T,
  TRUE  OR  FALSE  AS T_or_F,
  FALSE OR  FALSE  AS F_or_F,
  FALSE OR  TRUE   AS F_or_T,



9 - Where 

Where -  in / like /  between
======================


Only rows whose bool_expression evaluates to TRUE are included.
Rows whose bool_expression evaluates to NULL or FALSE are discarded.

Comparison operators
https://cloud.google.com/bigquery/docs/reference/standard-sql/operators#comparison_operators


-- IN operator
SELECT
  *
FROM
  `sql_tutorial.orders`
WHERE 
 ShipType IN ('A', 'B', 'C')


-- like operator
SELECT
  *
FROM
  `sql_tutorial.orders`
WHERE 
  CustomerID like '%NA%'


Between
-------


X [NOT] BETWEEN Y AND Z 
Returns TRUE if X is [not] within the range specified. 
The result of "X BETWEEN Y AND Z" is equivalent to "Y <= X AND X <= Z" but X is evaluated only once in the former.

-- between operator
SELECT
  *
FROM
  `sql_tutorial.orders`
WHERE 
  ShipWeight between 150 and 160
-- OrderDate between '2018-11-29' and  '2019-10-30'
-- CustomerID between 'B' and 'F'




10 

ORDER BY & LIMIT 
================
Sort the extracted results by predefined order



ORDER BY - Documentation
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#order_by_clause



-- Extract top 10 
SELECT
  *
FROM
  `sql_tutorial.orders`
ORDER BY
  ShipType
--   OrderDate
--   ShipDuration DESC
LIMIT
  10


11


Conditional expressions
=======================

https://cloud.google.com/bigquery/docs/reference/standard-sql/conditional_expressions


-- CASE
SELECT
  CASE
    WHEN ShipWeight < 145 THEN 'low'
    WHEN ShipWeight BETWEEN 145 AND 150 THEN 'medium'
  ELSE 'high' END AS Weight_class,
  ShipWeight,
  EmployeeID,
FROM
  `sql_tutorial.orders`
ORDER BY
  ShipWeight


-- COALESCE
-- Extract the first value from the field which is not null
SELECT COALESCE(NULL, 'B', 'C') as result


WITH cte_table AS (
  SELECT 90 as A, 2 as B UNION ALL
  SELECT 50, null UNION ALL
  SELECT 60, 6 UNION ALL
  SELECT 50, 10
)

SELECT
  *,
  COALESCE(B, A) as coalesce_Example
FROM cte_table

-- IF
SELECT
  IF (ShipType = 'A','Great Ship','Bad Ship' ) AS Ship_if,
  EmployeeID,
  ShipType
FROM
  `sql_tutorial.orders`
ORDER BY
  ShipType




-- IFNULL()
-------
WITH cte_table AS 
(
  SELECT 90 as A, 2 as B UNION ALL
  SELECT 50, null UNION ALL
  SELECT 60, 6 UNION ALL
  SELECT 50, 10
)

SELECT
  *,
  ifnull(B, -9) as If_Null_Example
FROM cte_table


NULLIF()
Returns NULL if expr = expr_to_match is true, otherwise returns expr.
NULLIF(expr, expr_to_match)

WITH cte_table AS 
(
  SELECT 90 as A, 2 as B UNION ALL
  SELECT 50, null UNION ALL
  SELECT 60, 6 UNION ALL
  SELECT 50, 10
)

SELECT
  *,
  NULLIF(A, 60) as NULLIF_Example
FROM cte_table



12 Null
========


NULL represent no value in the column

Can not use comparison operations GREATER or LOWER or EQUAL therefore cannot be used in join
                                     >         <        =
Documentation
https://cloud.google.com/bigquery/docs/reference/standard-sql/operators#operator_precedence



SELECT
  *,
  OwnerName IS NULL as Dont_have_Owner,
  Age IS Not NULL as have_Age
FROM
  `sql_tutorial.dogs`


SELECT 
  4 + cast(null as int64)  as Adding_Null,
  1 * cast(null as int64)  as Multiply_Null,
  1 != cast(null as int64) as Compare_Null,





13

JOIN operation
=============

 
The JOIN operation merges two tables (or subquery) so we can query them as one source
by using the join condition


Documentation:
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#join_types


SELECT
  *
FROM
  `sql_tutorial.people` AS l
JOIN
  `sql_tutorial.cities` AS r
ON
  l.CityID = r.CityID
ORDER BY
  l.CityID



14

Left / Right  join operation
=============================
  
The result of a LEFT OUTER JOIN (or simply LEFT JOIN) for two from_items always 
retains all rows of the left from_item in the JOIN operation, 
even if no rows in the right from_item satisfy the join predicate.

LEFT indicates that all rows from the left from_item are returned; 
if a given row from the left from_item does not join to any row in the right from_item, 
the row will return with NULLs for all columns from the right from_item. 
Rows from the right from_item that do not join to any row in the left from_item are discarded.


Documentation:
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#left_outer_join


SELECT
  *
FROM
  `sql_tutorial.people` AS l
LEFT JOIN
  `sql_tutorial.cities` AS r
ON
  l.CityID = r.CityID



15

FULL Join
==========

A FULL OUTER JOIN (or simply FULL JOIN) returns all fields for all rows in both from_items that meet the join condition.
FULL indicates that all rows from both from_items are returned, even if they do not meet the join condition.
OUTER indicates that if a given row from one from_item does not join to any row in the other from_item, the row will return with NULLs for all columns from the other from_item.



Documentation
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#full_join


SELECT
  *
FROM
  `sql_tutorial.people` AS l
FULL JOIN
  `sql_tutorial.cities` AS r
ON
  l.CityID = r.CityID


15

Cross Join
==============

CROSS JOIN returns the Cartesian product of the two from_items. 
In other words, it combines each row from the first from_item with each row from the second from_item.
If the rows of the two from_items are independent, 
then the result has M * N rows, given M rows in one from_item and N in the other. 
Note that this still holds for the case when either from_item has zero rows.


Documentation
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#cross_join


In a FROM clause, a CROSS JOIN can be written like this:


SELECT
  *
FROM
  `sql_tutorial.people` AS l
CROSS JOIN
  `sql_tutorial.cities` AS r



SELECT 
a,b,
a * b as res
from
(
SELECT
  a
FROM
  UNNEST (GENERATE_ARRAY(1,5)) AS a
  )
,
(
SELECT
  b
FROM
  UNNEST (GENERATE_ARRAY(1,5)) AS b
)


17


SELF join
============
 
When we join the table to itself
 

Documentation
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#inner_join

 
Task:

Generate a list of all pairs of people from the same city


 

SELECT
	*
FROM
	`sql_tutorial.people` AS l
JOIN
	`sql_tutorial.people` AS r
ON l.CityID = r.CityID



Compare between each city and the others
Which name is the longest?



18



COUNT() - agg function
=======================

Returns the number of rows in the input.
Returns the number of rows with expression evaluated to any value other than NULL.

COUNT(DISTINCT) - count only unique values


Documentation
https://cloud.google.com/bigquery/docs/reference/standard-sql/aggregate_functions#count

Queries:
- total rows per table
- total rows per dimension (1 or more Fields)
- total unique dog owners


-- total rows in the table

SELECT
  COUNT(*) as total_rows
FROM
  `sql_tutorial.dogs`


-- total dogs (rows) per gender

SELECT
  Gender,
  COUNT(*) AS total_rows
FROM
  `sql_tutorial.dogs`
GROUP BY
  1


-- How many dog owners (Unique) & how many dogs have owner?
SELECT
  COUNT( OwnerName) AS total_dogs_w_owner,
  COUNT(distinct OwnerName) AS unique_owners
FROM
  `sql_tutorial.dogs`


Practice by yourself



19


MAX / MIN - agg function
=======================

Returns the maximum/minimum value of non-NULL expressions. 
Returns NULL if there are zero input rows or expression evaluates to NULL for all rows. 
Returns NaN if the input contains a NaN.

Eligible for all the types of a field


Documentation
https://cloud.google.com/bigquery/docs/reference/standard-sql/aggregate_functions#max
https://cloud.google.com/bigquery/docs/reference/standard-sql/aggregate_functions#min


-- MAX value for each column

SELECT
  EmployeeID,
  MAX(OrderDate) AS MAX_OrderDate,
  MAX(RequiredDate) AS MAX_RequiredDate,
  MAX(ShipType) AS MAX_ShipType,
  MAX(ShipWeight) AS MAX_ShipWeight,
  MAX(ShipDuration) AS MAX_ShipDuration
FROM
  `sql_tutorial.orders`
GROUP BY
  1
ORDER BY
  1



-- MIN value for each column

SELECT
  EmployeeID,
  MIN(OrderDate) AS MIN_OrderDate,
  MIN(RequiredDate) AS MIN_RequiredDate,
  MIN(ShipType) AS MIN_ShipType,
  MIN(ShipWeight) AS MIN_ShipWeight,
  MIN(ShipDuration) AS MIN_ShipDuration
FROM
  `sql_tutorial.orders`
GROUP BY
  1
ORDER BY
  1


Practice by yourself on other tables


20

SUM / AVG - agg function
=======================

Returns the sum/average of non-null values.
If the expression is a floating point value, the sum is non-deterministic, 
which means you might receive a different result each time you use this function.

Supported Argument Types
Any supported numeric data types and INTERVAL.



Documentation
https://cloud.google.com/bigquery/docs/reference/standard-sql/aggregate_functions#sum
https://cloud.google.com/bigquery/docs/reference/standard-sql/aggregate_functions#avg


-- AVG and SUM by ShipType

SELECT
  ShipType,
  SUM(ShipWeight) AS SUM_ShipWeight,
  AVG(ShipWeight) AS AVG_ShipWeight,
  
  SUM(ShipDuration) AS SUM_ShipDuration,
  AVG(ShipDuration) AS AVG_ShipDuration,
FROM
  `sql_tutorial.orders`
GROUP BY
  1
ORDER BY
  1


21


HAVING - clause
=======================

The HAVING clause filters the results produced by GROUP BY or aggregation.



Documentation
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#having_clause



  -- HAVING clause -  Filter condition on the aggregated fields (results)
SELECT
  ShipType,
  SUM(ShipWeight) AS SUM_ShipWeight,
  AVG(ShipWeight) AS AVG_ShipWeight,
  COUNT(ShipWeight) AS Total_rows
FROM
  `sql_tutorial.orders`
GROUP BY
  1
HAVING
  Total_rows = 75
ORDER BY
  1


22 


UNION
============
Union two tables  / queries with the same schema

The UNION operator combines the result sets of two or more input queries 
by pairing columns from the result set of each query and vertically concatenating them.


Documentation
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#union


The union columns must have the same type

SELECT
  FirstName,
  LastName
FROM
  `sql_tutorial.employees`

UNION ALL

SELECT
  FirstName,
  LastName
FROM
  `sql_tutorial.customers`
 


Add additional attribute to the query


23 


SubQuery
============
Docs
https://cloud.google.com/bigquery/docs/reference/standard-sql/subqueries


A subquery is a query that appears inside another query statement. 




SELECT 
  MAX(playerID) as max_PlayerID,
  AVG(height) as AVG_height,
FROM 
-- SubQuery
  (
    SELECT  90  as playerID, 180 as height UNION ALL
    SELECT  10  as playerID, 185           UNION ALL
    SELECT  4   as playerID, 188           UNION ALL
    SELECT  100 as playerID, 168
  )




-- First order distribution
-- how many Customers made their first order
SELECT
  first_order_date,
  COUNT(1) AS Total_Customers
FROM 
  -- SubQuery
  ( -- for each Customer - first order date
  SELECT
    CustomerID,
    MIN(OrderDate) AS first_order_date
  FROM
    `sql_tutorial.orders`
  GROUP BY
    1 
  )
GROUP BY
  1
ORDER BY
  1


-- Using subquery in a JOIN

SELECT
  a.playerID,
  height,
  Weight
FROM
  (
    SELECT  90  as playerID, 180 as height UNION ALL
    SELECT  10  as playerID, 185           UNION ALL
    SELECT  4   as playerID, 188           UNION ALL
    SELECT  100 as playerID, 168
  ) as a
JOIN
  (
    SELECT  90  as playerID, 70 as Weight UNION ALL
    SELECT  12  as playerID, 75           UNION ALL
    SELECT  41   as playerID, 78           UNION ALL
    SELECT  100 as playerID, 78
  ) as b
on a.playerID = b.playerID



24

CTE - clause
=======================

Common table expression acts like a temporary table which can be used
later in the following query statement


Documentation
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#with_clause

-- define the cte
-- top 10 customers with most orders
WITH
  customers_orders AS (
  SELECT
    CustomerID,
    COUNT(1) total_orders
  FROM
    `sql_tutorial.orders`
  GROUP BY
    1
  ORDER BY
    2 DESC
  LIMIT
    10 
  )


-- join between top 10 customers with customers table
SELECT
  FirstName,
  LastName,
  Country,
  total_orders
FROM
  customers_orders AS a
JOIN
  `sql_tutorial.customers` AS b
ON
  a.CustomerID = b.CustomerID
ORDER BY
  4 DESC


-- cte example

WITH cte_table AS (
  SELECT 10 as A, 2 as B  UNION ALL
  SELECT 20,      null    UNION ALL
  SELECT null,    6       UNION ALL
  SELECT 40,      10
)

SELECT * ,
       A + B as a_plus_b
FROM
  cte_table
-- WHERE A = 20



25

Partition Table
================

Docs
https://cloud.google.com/bigquery/docs/partitioned-tables
https://cloud.google.com/bigquery/docs/partitioned-tables#combining_clustered_and_partitioned_tables
/*
You want to improve the query performance by only scanning a portion of a table.
*/


-- run a query on partition table
SELECT
   *
FROM `bigquery-public-data.google_trends.top_terms`
WHERE TRUE
  --  Constrain on partitioned column      
   AND refresh_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 2 week)







26

Window Functions - Row Number, Rank
=======================================

Marks the sequential order of every row in the table by the partition we defined


Documentation
https://cloud.google.com/bigquery/docs/reference/standard-sql/numbering_functions#row_number


WITH people AS
 (SELECT 'Andrew' as name, DATE '2022-01-03' as apply_date,
  'A' as class
  UNION ALL SELECT 'Ahron',   DATE '2022-01-05', 'B'
  UNION ALL SELECT 'Bobi',    DATE '2022-01-02', 'C'
  UNION ALL SELECT 'Camroon', DATE '2022-01-04', 'A'
  UNION ALL SELECT 'David',   DATE '2022-01-02', 'B'
  UNION ALL SELECT 'Erving',  DATE '2022-01-01', 'B'
  UNION ALL SELECT 'Foxi',    DATE '2022-01-02', 'C'
  UNION ALL SELECT 'John',    DATE '2022-01-01', 'C'
  UNION ALL SELECT 'Fredi',   DATE '2022-01-01', 'C'
)

SELECT name,
  class,
  apply_date,
  row_number() OVER (PARTITION BY class ORDER BY apply_date ASC) AS row_number,
FROM people



Action Items
1. row_number
2. Add row to the table
3. Modify the date (order)
4. Extract only top n rows for each class
5. Rank 


WITH people AS
 (SELECT 'Andrew' as name, DATE '2022-01-03' as apply_date,
  'A' as class
  UNION ALL SELECT 'Ahron',   DATE '2022-01-05', 'B'
  UNION ALL SELECT 'Bobi',    DATE '2022-01-02', 'C'
  UNION ALL SELECT 'Camroon', DATE '2022-01-04', 'A'
  UNION ALL SELECT 'David',   DATE '2022-01-02', 'B'
  UNION ALL SELECT 'Erving',  DATE '2022-01-01', 'B'
  UNION ALL SELECT 'Foxi',    DATE '2022-01-02', 'C'
  UNION ALL SELECT 'John',    DATE '2022-01-01', 'C'
  UNION ALL SELECT 'Fredi',   DATE '2022-01-01', 'C'
)

SELECT name,
  class,
  apply_date,
  rank() OVER (PARTITION BY class ORDER BY apply_date ASC) AS rank,
  row_number() OVER (PARTITION BY class ORDER BY apply_date ASC) AS row_number,
FROM people


Exercise
--------
Extract the first 2 orders for each EmployeeID



27 


QUALIFY
=======

The QUALIFY clause filters the results of window functions


Docs
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#qualify_clause


-- extract the top 2 size players from each team
with tmp as (
select 
  *
from 
  (SELECT 'Red' as team, a as size from unnest(generate_array(1,8)) as a)
union all
  (SELECT 'Blue' as team, a as size from unnest(generate_array(2,15)) as a)

)

SELECT 
  *,
FROM tmp
qualify (row_number() over (partition by team order by size desc) < 3)
order by 1,2


28

NTILE
=======================

This function divides the rows into constant_integer_expression buckets 
based on row ordering and returns the 1-based bucket number that is assigned to each row

https://cloud.google.com/bigquery/docs/reference/standard-sql/numbering_functions#ntile



 with team_a as (
  SELECT
    'Red' AS team,
    a AS size
  FROM
    UNNEST(GENERATE_ARRAY(1,10)) AS a
)

select 
  *,
  NTILE(2) OVER (PARTITION BY team ORDER BY size ASC) AS group_id
FROM team_a


Task
Split the basketball players from each team to 2 groups by height



(SELECT 'Sophia Liu' as name,  TIMESTAMP '2016-10-18 2:51:45' as finish_time,
  'F30-34' as division
  UNION ALL SELECT 'Lisa Stelzner', TIMESTAMP '2016-10-18 2:54:11', 'F35-39'
  UNION ALL SELECT 'Nikki Leith', TIMESTAMP '2016-10-18 2:59:01', 'F30-34'
  UNION ALL SELECT 'Lauren Matthews', TIMESTAMP '2016-10-18 3:01:17', 'F35-39'
  UNION ALL SELECT 'Desiree Berry', TIMESTAMP '2016-10-18 3:05:42', 'F35-39'
  UNION ALL SELECT 'Suzy Slane', TIMESTAMP '2016-10-18 3:06:24', 'F35-39'
  UNION ALL SELECT 'Jen Edwards', TIMESTAMP '2016-10-18 3:06:36', 'F30-34'
  UNION ALL SELECT 'Meghan Lederer', TIMESTAMP '2016-10-18 3:07:41', 'F30-34'
  UNION ALL SELECT 'Carly Forte', TIMESTAMP '2016-10-18 3:08:58', 'F25-29'
  UNION ALL SELECT 'Lauren Reasoner', TIMESTAMP '2016-10-18 3:10:14', 'F30-34')


29

LAG & LEAD
==========

Returns the value of the value_expression on a preceding row. 
Changing the offset value changes which preceding row is returned

We use these functions when we want to calculate 
deffrences between values in the same column

https://cloud.google.com/bigquery/docs/reference/standard-sql/navigation_functions#lag

SELECT
  *,
  -- Returns the value of the value_expression on a preceding row
  LAG(height, 1) OVER (PARTITION BY team ORDER BY height) lag_height,
  -- LAG(height, 1) OVER (PARTITION BY team ORDER BY height desc) lag_height_desc,

  -- Returns the value of the value_expression on a subsequent row
  -- LEAD(height, 1) OVER (PARTITION BY team ORDER BY height) lead_height,
  -- LEAD(height, 1) OVER (PARTITION BY team ORDER BY height desc) lead_height_desc,

FROM
  `sql_tutorial.basketball`
ORDER BY
  1,
  3

Task
-----
In the orders table,
What are the difference in days between the orders
of every customer



30

Time & Date functions
=======================


Dates functions
https://cloud.google.com/bigquery/docs/reference/standard-sql/date_functions

DateTime functions
https://cloud.google.com/bigquery/docs/reference/standard-sql/datetime_functions

Timestamp functions
https://cloud.google.com/bigquery/docs/reference/standard-sql/timestamp_functions


SELECT 
    -- Get the current date = Today
    CURRENT_DATE() AS the_date,
    -- Extract part of the date from date
    EXTRACT(DAY FROM DATE '2013-12-25') AS the_day,
    EXTRACT(Month FROM DATE '2013-11-25') AS the_month,

    -- Date Add / Sub
    DATE_ADD(DATE '2008-12-25', INTERVAL 5 DAY) AS five_days_later,
    DATE_ADD(current_date(), INTERVAL 1 month) AS one_month_later,
    DATE_SUB(current_date(), INTERVAL 1 month) AS one_month_before,

    -- Date Diff
    DATE_DIFF(DATE '2010-07-07', DATE '2008-12-25', DAY) AS days_diff,

    -- Date Trunc
    Date_TRUNC(DATE '2010-07-07', month ) as trunc_month,

    -- Date from EPOC
    DATE_FROM_UNIX_DATE(14238) AS date_from_epoch, -- 1970-01-01

    -- Last Day
    LAST_DAY(DATE '2008-11-25', MONTH) AS last_day,
    LAST_DAY(DATE '2008-11-25', YEAR) AS last_day



-- Date function

SELECT
  DATE(2016, 12, 25) AS date_ymd,
  DATE(DATETIME '2016-12-25 23:59:59') AS date_dt,
  DATE(TIMESTAMP '2016-12-25 05:30:00+07', 'America/Los_Angeles') AS date_tstz;


-- Current dates
SELECT
  CURRENT_DATE() as _CURRENT_DATE,
  CURRENT_DATETIME() _CURRENT_DATETIME, -- 2023-01-26T15:47:09.650366
  CURRENT_TIME() _CURRENT_TIME,
  CURRENT_TIMESTAMP() _CURRENT_TIMESTAMP,
  DATE '2013-12-25'




SELECT
  LAST_DAY (OrderDate, month) AS last_month_day,
  COUNT(1) t_orders
FROM
  `sql_tutorial.orders`
GROUP BY
  1
ORDER BY
  1



01_27_sql_pivot_table

https://console.cloud.google.com/bigquery?ws=!1m7!1m6!12m5!1m3!1sppltx-academy!2sus-central1!3s616c2aef-14a5-452c-a921-7d69f96b62af!2e1



31

PIVOT
======
Docs
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#pivot_operator

The PIVOT operator rotates rows into columns, using aggregation. PIVOT is part of the FROM clause.


-- Calculate the Multiplication table
with tmp as (
select 
  a,
  b,
  a * b as result
from 
  (SELECT a from unnest(generate_array(1,10)) as a)
Cross Join
  (SELECT * from unnest(generate_array(1,10)) as b)
order by 1,2
  )


SELECT 
	* 
FROM
	-- SUB QUERY
	(SELECT result, a, b FROM tmp)
pivot (sum(result) FOR b in (1,2,3))



32 

Arrays
======

Working with Arrays in BigQuery SQL
Arrays are a powerful data type in BigQuery that allow you to store an ordered list of zero or more elements of the same data type within a single row and column. They are essential for handling nested or repeated data structures often found in sources like JSON or application logs.
Why Use Arrays?
Representing Nested Data: Store lists of items related to a single record (e.g., tags for a blog post, items in an order, events in a user session).
Efficiency: Can sometimes be more efficient for storage and querying compared to normalizing data into separate tables, especially for 1-to-many relationships where the "many" side isn't excessively large or complex.
Flexibility: Simplify queries that need to operate on lists of values associated with a row.
1. Creating Arrays
You can create arrays in several ways:
a) Using Square Brackets []:
The most common way to define a literal array.
SELECT
  [1, 2, 3] AS integer_array,
  ['apple', 'banana', 'cherry'] AS string_array,
  [DATE '2025-01-01', DATE '2025-01-15'] AS date_array;


b) Using the ARRAY() Constructor with a Subquery:
Create an array dynamically from the results of a subquery.
WITH Fruits AS (
  SELECT 'apple' as fruit UNION ALL
  SELECT 'banana' as fruit UNION ALL
  SELECT 'cherry' as fruit
)
SELECT ARRAY(SELECT fruit FROM Fruits) AS fruit_array;
-- Result: ['apple', 'banana', 'cherry']


c) Using Generator Functions:
BigQuery provides functions to generate sequences.
SELECT
  GENERATE_ARRAY(1, 10, 2) AS odd_numbers, -- Start, End, Step
  GENERATE_DATE_ARRAY(DATE '2025-04-01', DATE '2025-04-05') AS date_sequence;
-- Result: [1, 3, 5, 7, 9], [2025-04-01, 2025-04-02, 2025-04-03, 2025-04-04, 2025-04-05]


2. Accessing Array Elements
You access elements using their position within the array. BigQuery supports two ways:
OFFSET(n): Accesses the element at the n-th zero-based position (0 is the first element).
ORDINAL(n): Accesses the element at the n-th one-based position (1 is the first element).
Using OFFSET is generally recommended as it aligns with most programming languages. Accessing an index outside the array bounds returns an error.

