__________________________________________________________________________
-- Beginner SQL: TOP
-- Purpose: Learn how to retrieve only the first N rows in SQL Server
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. Managment wants to
  -- see only the top employees by salary, performance, or any metric. You
  -- will use TOP to limit the number of rows returned in queries

  -- Table: employees
    -- id            1       2          3          4          5
    -- first_name  Alice     Bob       Carol       Dave       Eve
    -- last_name   Johnson  Smith      Davis      Wilson     Taylor
    -- department    HR      IT         HR         IT       Finance
    -- role        Manager  Analyst  Assistant  Developer  Accountant
    -- salary       75000    60000      50000     65000      75000
    -- status      Active   Active    Inactive   Active      Active

  
__________________________________________________________________________
-- 1️ Basic TOP
-- What it does: Returns the first N rows of a query
-- Why use it: Quickly get a subset of results without fetching the entire
  -- table
-- Syntax: SELECT TOP (number) columns FROM table_name;
__________________________________________________________________________
-- Problem: 
  -- Management wants to see only the first 3 employees

-- Solution: 
  SELECT TOP (3) first_name, last_name
    FROM employees;

-- Expected Results:
  -- first_name  Alice    Bob   Carol
  -- last_name  Johnson  Smith  Davis

-- *Without ORDER BY, the rows returned are not guaranteed 
__________________________________________________________________________
-- 2 TOP with ORDER BY
-- What it does: Returns the top N rows after sorting
-- Why use it: Ensures you get the actual top values
-- Syntax: SELECT TOP (number) columns FROM table_name ORDER BY column 
  -- DESC;
__________________________________________________________________________
-- Problem:
  -- Management wants the top 2 highest-paid employees

--Solution:
  SELECT TOP (2) first_name, salary
    FROM employees
    ORDER BY salary DESC;

-- Expected Result:
  -- first_name  Alice   Eve
  -- salary      75000  75000

__________________________________________________________________________
-- 3 TOP with ASC (Lowest Values)
-- What it does: Returns the lowest N values
-- Why use it: Useful for finding bottom performers or minimum values
-- Syntax: SELECT TOP (number) columns FROM table_name ORDER BY column 
  -- ASC;
__________________________________________________________________________
-- Problem:
  -- Management wants the 2 lowest-paid employees

-- Solution:
  SELECT TOP (2) first_name, salary
    FROM employees
    ORDER BY salary ASC;

-- Expected Result:
  -- first_name  Carol   Bob
  -- salary      50000  60000

__________________________________________________________________________
-- 4 TOP with Multiple Sort Rules
-- What it does: Returns top N rows after multi-column sorting
-- Why use it: Handles ties and precise ranking
-- Syntax: SELECT TOP (number) columns FROM table_name ORDER BY col1 DESC, 
  -- col2 ASC;
__________________________________________________________________________
-- Problem:
  -- Management wants employees the top 3 highest-paid employees, sorted
    -- alphabetically if salaries tie

-- Solution:
  SELECT TOP (3) first_name, salary
    FROM employees
    ORDER BY salary DESC, first_name ASC;

-- Expected Result:
  -- first_name  Alice   Eve   Dave
  -- salary      75000  75000  65000

__________________________________________________________________________
-- 5 TOP with WHERE
-- What it does: Limits results after filtering
-- Why use it: Focus on specific subset of data
-- Syntax: SELECT TOP (number) columns FROM table_name WHERE condition
  -- ORDER BY column DESC;
__________________________________________________________________________
-- Problem:
  -- Management wants the top 2 highest-paid IT employees

-- Solution:
  SELECT TOP (2) first_name, department, salary
    FROM employees
    WHERE department = 'IT'
    ORDER BY salary DESC;

-- Expected Result:
  -- first_name  Dave    Bob
  -- department   IT     IT
  -- salary      65000  60000

__________________________________________________________________________
-- 6 TOP with Aliases
-- What it does: Uses renamed columns in sorting and limiting
-- Why use it: Cleaner and more readable queries
-- Syntax: SELECT TOP (number) columns AS alias FROM table_name ORDER BY 
  -- alias DESC;
__________________________________________________________________________
-- Problem:
  -- Management wants top 3 salaries using a readable column name

-- Solution:
  SELECT TOP (3) first_name, salary AS Pay
    FROM employees
    ORDER BY Pay DESC;

-- Expected Result:
  -- first_name  Alice   Eve   Dave
  -- Pay         75000  75000  65000

__________________________________________________________________________
-- 5 TOP with PERCENT
-- What it does: Returns the top percentage of rows
-- Why use it: Useful for relative rankings iinstead of fixed counts
-- Syntax: SELECT TOP (percent) columns FROM table_name ORDER BY column 
  -- DESC;
__________________________________________________________________________
-- Problem:
  -- Management wants the top 40% highest-paid employees

-- Solution:
  SELECT TOP (40) PERCENT first_name, salary
    FROM employees
    ORDER BY salary DESC;

-- Expected Result:
  -- first_name  Alice  Eve
  -- salary      75000  75000

