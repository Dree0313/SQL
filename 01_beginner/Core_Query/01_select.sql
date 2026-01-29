__________________________________________________________________________
-- 01_select.sql
-- Beginner SQL: SELECT statement
-- Purpose: Learn basic data retrieval
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. HR needs reports 
  -- from the employee database, and you have to write queries to retrieve 
  -- specific information.

  -- Table: employees
![Employee Departments](SQL/Charts/Employees_Table.png)

  
__________________________________________________________________________
-- 1️ Select all columns from a table
-- What it does: Retrieves every column for every row in a table
-- Why use it: Quick way to see all data in a table
-- Syntax: SELECT * FROM table_name;
__________________________________________________________________________
-- Problem: 
  -- HR wants to see everything in the employees table to understand
  -- the database

-- Solution: 
SELECT *
FROM employees;

__________________________________________________________________________
-- 2 Select Specific columns
-- What it does: Retrieves only the columns specified
-- Why use it: Helps focus on relevant data and reduce clutter
-- Syntax: SELECT column1, column2 FROM table_name;
__________________________________________________________________________
-- Problem:
  -- HR only wants first and last names to send birthday emails

--Solution:
SELECT first_name, last_name
FROM employees;

__________________________________________________________________________
-- 3 Column aliases
-- What it does: Gives a temporary name to a column for readability
-- Why use it: Makes results easier to understnad, especially for reports
-- Syntax: SELECT column AS alias_name FROM table_name;
__________________________________________________________________________
-- Problem:
  -- HR wants the columns labeled nicely in the report

-- Solution:
SELECT first_name AS "First Name", last_name AS "Last Name"
FROM employees;

__________________________________________________________________________
-- 4 DISTINCT keyword
-- What it does: Returns only unique values, removing duplicates
-- Why use it: Helps identify unique entries or categories in a table
-- Syntax: SELECT DISTINCT column FROM table_name;
__________________________________________________________________________
-- Problem:
  -- HR wants a list of unique departments

-- Solution:
SELECT DISTINCT department
FROM employees;

__________________________________________________________________________
-- 6 Literals
-- What it does: Adds static text or numbers to query results
-- Why use it: Can label results or add context without changing the table
-- Syntax: SELECT column, 'Literal' AS alias FROM table_name;
__________________________________________________________________________
-- Problem:
  -- HR wants a list of employees with their roles labeled

-- Solution:
SELECT first_name, 'Employee' AS role
FROM employees;

__________________________________________________________________________
-- 7 Concatenation (SQLite-specific)
-- What it does: Combines values from multiple columns into one
-- Why use it: Useful for full names, addresses, or other combined fields
-- Syntax: SELECT column || ' ' || column2 AS alias FROM table_name;
__________________________________________________________________________
-- Problem:
  -- HR wants full names in one column

-- Solution:
SELECT first_name || ' ' || last_name AS full_name
FROM employees;
