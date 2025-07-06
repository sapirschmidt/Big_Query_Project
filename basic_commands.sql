/*

Basic Commands

*/



# Create Dataset:
create schema `my_first_schema` options (description = "This is the first dataset I created")



# Create table:
create or replace table `my_first_schema.my_first_table`
  AS
SELECT 
  'MY_NAME' as name,
  DATE "YYYY-MM-DD" as birth_date, -- update your birth date
  True as Highly_motivated,
  current_date() as course_start

