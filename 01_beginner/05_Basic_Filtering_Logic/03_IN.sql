__________________________________________________________________________
-- Beginner SQL: IN
-- Purpose: Learn how to filter rows by matching a value against a list
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. Managment needs
  -- reports that filter employees based on multiple possible values in
  -- the same column. Instead of writing many OR conditions, you will use
  -- the IN operator for cleaner and more readable queries.

  -- Table: employees
    -- id            1       2          3          4          5
    -- first_name  Alice     Bob       Carol       Dave       Eve
    -- last_name   Johnson  Smith      Davis      Wilson     Taylor
    -- department    HR      IT         HR         IT       Finance
    -- role        Manager  Analyst  Assistant  Developer  Accountant
    -- salary       75000    60000      50000     65000      NULL
    -- status      Active   Active    Inactive   Active      Active
  
__________________________________________________________________________
-- 1️ Basic IN
-- What it does: Matches rows where a column value is in a given list
-- Why use it: Replaces mulitple OR conditions with cleaner syntax
-- Syntax: WHERE column_name IN (value1, value2, ...)
__________________________________________________________________________
-- Problem: 
  -- Management wants to see employees in HR or IT

-- Solution: 
  SELECT first_name, department
    FROM employees
    WHERE department IN ('HR', 'IT');

-- Expected Results:
  -- first_name  Alice  Bob  Carol  Dave
  -- department   HR    IT     HR    IT

__________________________________________________________________________
-- 2 IN with Numeric Values
-- What it does: Filters rows matching specific numeric values
-- Why use it: Targets exact numberic categories
-- Syntax: WHERE column_name IN (number1, number2, ...)
__________________________________________________________________________
-- Problem:
  -- Management wants employees with salaries of exactly 60000 or 75000

-- Solution:
  SELECT first_name, salary
    FROM employees
    WHERE salary IN (60000, 75000);

-- Expected Result:
  -- first_name  Alice   Bob
  -- salary      75000  60000

__________________________________________________________________________
-- 3 NOT IN
-- What it does: Excludes rows matching values in a list
-- Why use it: Filters out unwanted categories
-- Syntax: WHERE column_name NOT IN (...)
__________________________________________________________________________
-- Problem: 
  -- Management wants employees NOT in HR or Finance

-- Solution: 
  SELECT first_name, department
    FROM employees
    WHERE department NOT IN ('HR', 'Finance');

-- Expected Results:
  -- first_name    Bob  Dave
    -- department  IT   IT

__________________________________________________________________________
-- 4 IN and NULL Behavior
-- What it does: Demonstrates how NULL interacts with IN
-- Why use it: Prevents unexpected filtering results
__________________________________________________________________________
-- Problem: 
  -- Management wants employees with known salaries

-- Solution: 
  SELECT first_name, salary
    FROM employees
    WHERE salary IS NOT NULL;

-- Expected Results:
  -- first_name  Alice   Bob   Carol  Dave
  -- salary      75000  60000  50000  65000
