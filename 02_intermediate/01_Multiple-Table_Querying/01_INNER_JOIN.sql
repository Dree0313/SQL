__________________________________________________________________________
-- Beginner SQL: Understanding How NULL Behaves in Queries
-- Purpose: Learn how NULL affects comparisons, filtering, and results
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. Managment has 
  -- noticed inconsistencies in reports caused by missing data. To prevent
  -- bugs and incorrect results, you must understand how NULL behaves in
  -- SQL querries and why it requires special handling.

  -- Table: employees
    -- id            1       2          3          4          5
    -- first_name  Alice     Bob       Carol       Dave       Eve
    -- last_name   Johnson  Smith      Davis      Wilson     Taylor
    -- department    HR      IT         HR         IT       Finance
    -- role        Manager  Analyst    NULL    Developer  Accountant
    -- salary       75000    60000     50000     65000        NULL
    -- status      Active   Active    Inactive   Active      Active
  
__________________________________________________________________________
-- 1️ NULL Is Not a Value
-- What it does: Demonstrates that NULL means "unknown", not zero or empty
-- Why use it: Prevents incorrect assumptions about missing data
__________________________________________________________________________
-- Problem: 
  -- Management asks if any employee has a salary of 0

-- Solution: 
  SELECT first_name, salary
    FROM employees
    WHERE salary = 0;

-- Expected Results:
  -- No rows returned
  -- NULL does not equal 0, empty, or any number

__________________________________________________________________________
-- 2 NULL Breaks Comparison Operators
-- What it does: Shows how comparisons with NULL always return UNKNOWN
-- Why use it: Explains why rows disappear unexpectedly
__________________________________________________________________________
-- Problem:
  -- Management wants employees earning more than 60000

-- Solution:
  SELECT first_name, salary
    FROM employees
    WHERE salary > 60000;

-- Expected Result:
  -- first_name  Alice   Dave
  -- salary      75000  65000

  -- Eve is excluded because NULL > 60000 is UNKNOWN, not TRUE

__________________________________________________________________________
-- 3 NULL and NOT Conditions
-- What it does: Shows how NULL behaves with NOT
-- Why use it: Avoids missing rows in exclusion filters
__________________________________________________________________________
-- Problem: 
  -- Management wants employees NOT earning more than 60000

-- Solution: 
  SELECT first_name, salary
    FROM employees
    WHERE NOT (salary > 60000);

-- Expected Results:
  -- first_name   Carol
  -- salary       50000

  -- Bob (60000) and Eve (NULL) are excluded
  -- NOT UNKNOWN is still UNKNOWN

__________________________________________________________________________
-- 4 NULL in Logical AND / OR
-- What it does: Demonstrates how NULL affects logical experessions
-- Why use it: Prevents faulty business logic
__________________________________________________________________________
-- Problem:
  -- Management wants employees who are Active AND earn more than 60000

-- Solution:
  SELECT first_name, status, salary
    FROM employees
    WHERE status = 'Active' AND salary > 60000;

-- Expected Result:
  -- first_name  Alice  Dave
  -- status     Active  Active
  -- salary      75000  65000

  -- Eve is Active, but salary is NULL
  -- TRUE AND UNKNOWN = UNKNOWN → row excluded

__________________________________________________________________________
-- 5 NULL and Aggregate Functions
-- What it does: Shows how NULL is handled in COUNT
-- Why use it: Prevents incorrect totals
__________________________________________________________________________
-- Problem: 
  -- Management wants to count how many employees have salaries

-- Solution: 
  SELECT COUNT(salary) AS salary_count
    FROM employees;

-- Expected Results:
  -- salary_count  4

  -- COUNT(column) ignores NULL values
  -- COUNT(*) counts all rows

__________________________________________________________________________
-- 6 Handling NULL Safely
-- What it does: Introduces safe NULL handling using IS NULL
-- Why use it: Ensures accurate filtering
__________________________________________________________________________
-- Problem: 
  -- Management wants to employees with missing roles or salaries

-- Solution: 
  SELECT first_name, role, salary
    FROM employees
    WHERE role IS NULL OR salary IS NULL;

-- Expected Results:
  -- first_name  Carol     Eve
  -- role         NULL  Accountant
  -- salary      50000     NULL
