---- how many orders has been made by any type of ship type in the year 2019?
SELECT
  ShipType,
  COUNT(orderid) as num_of_orders
FROM
  `lyrical-flame-462317-k8`.`sql_tutorial`.`orders`
WHERE
  SUBSTR(CAST(orderdate AS STRING), 1, 4) = '2019'
GROUP BY
  1;

  ---- show the average height in any basketball team and the highest player in any team
SELECT
  basketball.team,
  AVG(basketball.height) AS average_height,
  MAX(basketball.height) AS highest_player
FROM
  `lyrical-flame-462317-k8`.`sql_tutorial`.`basketball` AS basketball
GROUP BY
  1;

  ---- show the cities that have more than 3 employees
  select e.city, count(e.EmployeeID) as Num_of_employees
  from `sql_tutorial.employees` as e
  group by e.city
  having count(e.EmployeeID) >=3

  ---- join orders and customers and show top 5 countries with the highest freight weight
SELECT
  customers.Country,
  ROUND(SUM(orders.ShipWeight), 2) AS TotalFreightWeight
FROM
  `lyrical-flame-462317-k8`.`sql_tutorial`.`orders` AS orders
INNER JOIN
  `lyrical-flame-462317-k8`.`sql_tutorial`.`customers` AS customers
ON
  orders.CustomerID = customers.CustomerID
GROUP BY
  1
ORDER BY
  TotalFreightWeight DESC
LIMIT
  5;

 -- --calculate for every employee the number of orders he took care of
--   --in comparison for the department average
WITH
  employee_order_count AS (
  SELECT
    employees.EmployeeID,
    employees.Title,
    COUNT(orders.OrderID) AS order_count
  FROM
    `lyrical-flame-462317-k8`.`sql_tutorial`.`employees` AS employees
  INNER JOIN
    `lyrical-flame-462317-k8`.`sql_tutorial`.`orders` AS orders
  ON
    employees.EmployeeID = orders.EmployeeID
  GROUP BY
    1,
    2 ),
  department_average AS (
  SELECT
    Title,
    AVG(order_count) AS average_order_count
  FROM
    `employee_order_count`
  GROUP BY
    1 )
SELECT
  employee_order_count.EmployeeID,
  employee_order_count.Title,
  employee_order_count.order_count,
  department_average.average_order_count
FROM
  `employee_order_count`
INNER JOIN
  `department_average`
ON
  employee_order_count.Title = department_average.Title;

  ---- is man or woman are a higher percentage in the sales team?
SELECT
  employees.Gender,
  ROUND( COUNT(employees.EmployeeID) / (
    SELECT
      COUNT(employees.EmployeeID)
    FROM
      `lyrical-flame-462317-k8`.`sql_tutorial`.`employees` AS employees
    WHERE
      employees.Title LIKE '%Sales%' ) * 100, 2) AS Percentage
FROM
  `lyrical-flame-462317-k8`.`sql_tutorial`.`employees` AS employees
WHERE
  employees.Title LIKE '%Sales%'
GROUP BY
  1;

  ---- which customers havent made any order in 2019?
SELECT
  customers.CustomerID
FROM
  `lyrical-flame-462317-k8`.`sql_tutorial`.`customers` AS customers
LEFT OUTER JOIN
  `lyrical-flame-462317-k8`.`sql_tutorial`.`orders` AS orders
ON
  customers.CustomerID = orders.CustomerID
WHERE
  orders.OrderDate IS NULL;

---- calculate for every order the ship duration and put it into "flag" bins and count the numbers of flags in any shiptype
SELECT
  orders.ShipType,
  CASE
    WHEN orders.ShipDuration <= 10 THEN '0-10'
    WHEN orders.ShipDuration > 10
  AND orders.ShipDuration <= 20 THEN '10-20'
    WHEN orders.ShipDuration > 20 AND orders.ShipDuration <= 30 THEN '20-30'
    WHEN orders.ShipDuration > 30
  AND orders.ShipDuration <= 40 THEN '30-40'
    WHEN orders.ShipDuration > 40 AND orders.ShipDuration <= 50 THEN '40-50'
    ELSE '50+'
END
  AS flag,
  COUNT(orders.OrderID) as Num_of_order_in_flag
FROM
  `lyrical-flame-462317-k8`.`sql_tutorial`.`orders` AS orders
GROUP BY
  1,
  2;

---- for every dog owner show the highest age + average number of dogs for every owner
SELECT
  OwnerName,
  MAX(Age) highest_age,
  AVG(COUNT(DogID)) OVER (PARTITION BY OwnerName) AS avg_num_dogs
FROM
  `lyrical-flame-462317-k8`.`sql_tutorial`.`dogs`
GROUP BY
  OwnerName;

---- find streaks of the same shiptype in the order list by order date, fetch the longest streak for any shiptype
SELECT
  ShipType,
  MAX(streak) AS longest_streak
FROM (
  SELECT
    ShipType,
    COUNT(*) AS streak
  FROM (
    SELECT
      ShipType,
      ROW_NUMBER() OVER (PARTITION BY ShipType ORDER BY OrderDate) - ROW_NUMBER() OVER (ORDER BY OrderDate) AS group_id
    FROM
      `lyrical-flame-462317-k8`.`sql_tutorial`.`orders` )
  GROUP BY
    ShipType,
    group_id )
GROUP BY
  ShipType;

  ---- calculate a  ntile measure for deliveries and shipment for every quarter in 2019 show orders that are the top 20% from the quarter average
WITH
  OrdersWithQuarters AS (
  SELECT
    OrderID,
    CustomerID,
    EmployeeID,
    OrderDate,
    RequiredDate,
    ShipType,
    ShipWeight,
    ShipDuration,
    FORMAT_DATE('%Y-%m', OrderDate) AS OrderQuarter
  FROM
    `lyrical-flame-462317-k8`.`sql_tutorial`.`orders`
  WHERE
    EXTRACT(YEAR
    FROM
      OrderDate) = 2019 ),
  QuarterAverages AS (
  SELECT
    OrderQuarter,
    AVG(ShipDuration) AS AvgShipDuration,
    AVG(ShipWeight) AS AvgShipWeight
  FROM
    `OrdersWithQuarters`
  GROUP BY
    1 ),
  NtileOrders AS (
  SELECT
    OrderID,
    CustomerID,
    EmployeeID,
    OrderDate,
    RequiredDate,
    ShipType,
    ShipWeight,
    ShipDuration,
    OrderQuarter,
    NTILE(5) OVER (PARTITION BY OrderQuarter ORDER BY ShipDuration) AS ShipDurationNtile,
    NTILE(5) OVER (PARTITION BY OrderQuarter ORDER BY ShipWeight) AS ShipWeightNtile
  FROM
    `OrdersWithQuarters` ),
  Top20PercentOrders AS (
  SELECT
    OrderID,
    CustomerID,
    EmployeeID,
    OrderDate,
    RequiredDate,
    ShipType,
    ShipWeight,
    ShipDuration,
    OrderQuarter
  FROM
    `NtileOrders`
  WHERE
    ShipDuration = 5
    OR ShipWeightNtile = 5 )
SELECT
  Top20PercentOrders.*,
  QuarterAverages.AvgShipDuration,
  QuarterAverages.AvgShipWeight
FROM
  `Top20PercentOrders`
JOIN
  `QuarterAverages`
ON
  Top20PercentOrders.OrderQuarter = QuarterAverages.OrderQuarter;

  ---- write an array query of every dog id who is NOT sterile by gender, also fetch the number of elements

SELECT
  dogs.Name,
  dogs.Gender,
  ARRAY_AGG(
  IF
    (dogs.Gender = 'F', dogs.DogID, NULL) IGNORE NULLS) AS FemaleDogs,
  ARRAY_LENGTH(ARRAY_AGG(
    IF
      (dogs.Gender = 'M', dogs.DogID, NULL) IGNORE NULLS)) AS MaleDogCount,
  ARRAY_LENGTH(ARRAY_AGG(
    IF
      (dogs.Gender = 'F', dogs.DogID, NULL) IGNORE NULLS)) AS FemaleDogCount
FROM
  `lyrical-flame-462317-k8`.`sql_tutorial`.`dogs` AS dogs
GROUP BY
  dogs.Name,
  dogs.Gender;

  ---- update in the employees table every employee who reports to null and change it to report to employeeid "18", retrieve the number of rows that has been changed
UPDATE
  `lyrical-flame-462317-k8`.`sql_tutorial`.`employees`
SET
  ReportsTo = 18
WHERE
  ReportsTo IS NULL;
SELECT
  ROW_COUNT()
FROM
  `lyrical-flame-462317-k8`.`sql_tutorial`.`employees`;

---- for every employee calculat the tenure in the company in years.and show only the top 10 %
SELECT
  *
FROM (
  SELECT
    FirstName,
    LastName,
    DATE_DIFF(CURRENT_DATE(), HireDate, YEAR) AS Tenure
  FROM
    `lyrical-flame-462317-k8`.`sql_tutorial`.`employees` )
WHERE
  Tenure >= (
  SELECT
    MIN(Tenure)
  FROM (
    SELECT
      DATE_DIFF(CURRENT_DATE(), HireDate, YEAR) AS Tenure
    FROM
      `lyrical-flame-462317-k8`.`sql_tutorial`.`employees` ) ) + (
  SELECT
    MAX(Tenure)
  FROM (
    SELECT
      DATE_DIFF(CURRENT_DATE(), HireDate, YEAR) AS Tenure
    FROM
      `lyrical-flame-462317-k8`.`sql_tutorial`.`employees` ) ) * 0.1;
  
  ---- create a pivot that retrieve the frieght weight by month in year 2019 when the colums are shiptype and months
SELECT
  orders.ShipType,
  CASE
    WHEN EXTRACT(MONTH FROM orders.OrderDate) = 1 THEN orders.ShipWeight
    ELSE NULL
END
  AS January,
  CASE
    WHEN EXTRACT(MONTH FROM orders.OrderDate) = 2 THEN orders.ShipWeight
    ELSE NULL
END
  AS February,
  CASE
    WHEN EXTRACT(MONTH FROM orders.OrderDate) = 3 THEN orders.ShipWeight
    ELSE NULL
END
  AS March,
  CASE
    WHEN EXTRACT(MONTH FROM orders.OrderDate) = 4 THEN orders.ShipWeight
    ELSE NULL
END
  AS April,
  CASE
    WHEN EXTRACT(MONTH FROM orders.OrderDate) = 5 THEN orders.ShipWeight
    ELSE NULL
END
  AS May,
  CASE
    WHEN EXTRACT(MONTH FROM orders.OrderDate) = 6 THEN orders.ShipWeight
    ELSE NULL
END
  AS June,
  CASE
    WHEN EXTRACT(MONTH FROM orders.OrderDate) = 7 THEN orders.ShipWeight
    ELSE NULL
END
  AS July,
  CASE
    WHEN EXTRACT(MONTH FROM orders.OrderDate) = 8 THEN orders.ShipWeight
    ELSE NULL
END
  AS August,
  CASE
    WHEN EXTRACT(MONTH FROM orders.OrderDate) = 9 THEN orders.ShipWeight
    ELSE NULL
END
  AS September,
  CASE
    WHEN EXTRACT(MONTH FROM orders.OrderDate) = 10 THEN orders.ShipWeight
    ELSE NULL
END
  AS October,
  CASE
    WHEN EXTRACT(MONTH FROM orders.OrderDate) = 11 THEN orders.ShipWeight
    ELSE NULL
END
  AS November,
  CASE
    WHEN EXTRACT(MONTH FROM orders.OrderDate) = 12 THEN orders.ShipWeight
    ELSE NULL
END
  AS December
FROM
  `lyrical-flame-462317-k8`.`sql_tutorial`.`orders` AS orders
WHERE
  EXTRACT(YEAR
  FROM
    orders.OrderDate) = 2019;