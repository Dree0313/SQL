__________________________________________________________________________
-- Beginner SQL: LIKE
-- Purpose: Learn how to filter rows using pattern matching
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. Managment needs
  -- reports that search for employees based on partial text machines
  -- (such as names, roles, or departments) instead of exact values.

  -- Table: employees
    -- id            1       2          3          4          5
    -- first_name  Alice     Bob       Carol       Dave       Eve
    -- last_name   Johnson  Smith      Davis      Wilson     Taylor
    -- department    HR      IT         HR         IT       Finance
    -- role        Manager  Analyst  Assistant  Developer  Accountant
    -- salary       75000    60000      50000     65000      NULL
    -- status      Active   Active    Inactive   Active      Active
  
__________________________________________________________________________
-- 1️ Basic LIKE
-- What it does: Filters rows where text matches a pattern
-- Why use it: Allows partial string searching
-- Syntax: WHERE column_name LIKE 'pattern'
__________________________________________________________________________
-- Problem: 
  -- Management wants employees whose first name starts with 'A'

-- Solution: 
  SELECT first_name
    FROM employees
    WHERE first_name LIKE 'A%';

-- Expected Results:
  -- first_name  Alice

-- *Notes: % matches any number of characters

__________________________________________________________________________
-- 2 LIKE with Ending Pattern
-- What it does: Matches text that ends with specific characters
-- Why use it: Useful for last names or standardized titles
__________________________________________________________________________
-- Problem:
  -- Management wants employees whose last name ends with 'son'

-- Solution:
  SELECT first_name, last_name
    FROM employees
    WHERE last_name LIKE '%son';

-- Expected Result:
  -- first_name  Alice    Dave
  -- last_name  Johnson  Wilson

__________________________________________________________________________
-- 3 LIKE with Containing Pattern
-- What it does: Matches text that contains a sequence everywhere
-- Why use it: Flexible searching without knowing exact placement
__________________________________________________________________________
-- Problem: 
  -- Management wants employees whose role contains the word 'Assist'

-- Solution: 
  SELECT first_name, role
    FROM employees
    WHERE role LIKE '%Assist';

-- Expected Results:
  -- first_name   Carol
  -- role       Assistant

__________________________________________________________________________
-- 4 NOT LIKE
-- What it does: Excludes rows matching a pattern
-- Why use it: Filters out unwanted text values
-- Syntax: WHERE column_name NOT LIKE 'pattern'
__________________________________________________________________________
-- Problem:
  -- Management wants employees whose department is NOT IT

-- Solution:
  SELECT first_name, department
    FROM employees
    WHERE department NOT LIKE 'IT';

-- Expected Result:
  -- first_name  Alice  Carol  Eve
  -- department   HR     HR  Finance

__________________________________________________________________________
-- 5 LIKE and NULL Behavior
-- What it does: Demonstrates how NULL behaves with LIKE
-- Why use it: Prevents missing rows in text searches
__________________________________________________________________________
-- Problem: 
  -- Management wants employees with known roles

-- Solution: 
  SELECT first_name, role
    FROM employees
    WHERE role IS NOT NULL;

-- Expected Results:
  -- first_name  Alice     Bob      Carol      Dave        Eve
  -- role       Manager  Analyst  Assistant  Developer  Accountant
