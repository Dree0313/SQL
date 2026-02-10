__________________________________________________________________________
-- Beginner SQL: IS NULL / IS NOT NULL
-- Purpose: Learn how to filter rows with missing (NULL) values
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. Managment needs
  -- reports that identify missing or incomplete employee data (such as
  -- missing salaries or roles). You will use IS NULL and IS NOT NULL to 
  -- correctly filter these records

  -- Table: employees
    -- id            1       2          3          4          5
    -- first_name  Alice     Bob       Carol       Dave       Eve
    -- last_name   Johnson  Smith      Davis      Wilson     Taylor
    -- department    HR      IT         HR         IT       Finance
    -- role        Manager  Analyst    NULL    Developer  Accountant
    -- salary       75000    60000     50000     65000        NULL
    -- status      Active   Active    Inactive   Active      Active
  
__________________________________________________________________________
-- 1️ Basic IS NULL
-- What it does: Filters rows where column has no value
-- Why use it: Finds missing or incomplete data
-- Syntax: WHERE column_name IS NULL
__________________________________________________________________________
-- Problem: 
  -- Management wants employees with missing salary information

-- Solution: 
  SELECT first_name, salary
    FROM employees
    WHERE salary IS NULL;

-- Expected Results:
  -- first_name  Eve
  -- salary      NULL

__________________________________________________________________________
-- 2 IS NOT NULL
-- What it does: Filters rows where a column has a value
-- Why use it: Ensures only complete records are returned
-- Syntax: WHERE column_name IS NOT NULL
__________________________________________________________________________
-- Problem:
  -- Management wants employees with known salaries

-- Solution:
  SELECT first_name, salary
    FROM employees
    WHERE salary IS NOT NULL;

-- Expected Result:
  -- first_name  Alice   Bob   Carol  Dave
  -- salary      75000  60000  50000  65000

__________________________________________________________________________
-- 3 NULL vs Comparison Operators
-- What it does: Shows why NULL cannot be compared using = or !=
-- Why use it: Prevents common beginner mistake
__________________________________________________________________________
-- Problem: 
  -- A developer tries to find missing salaries using = NULL (this is 
    -- wrong)

-- Incorrect: 
  SELECT first_name
    FROM employees
    WHERE salary = NULL;

-- Solution:
  SELECT first_name
    FROM employees
    WHERE salary IS NULL;

-- Expected Results:
  -- first_name   Eve

__________________________________________________________________________
-- 4 IS NULL with Logical Conditions
-- What it does: Combines NULL checks with other filters
-- Why use it: Models real-world business logic
__________________________________________________________________________
-- Problem:
  -- Management wants active employees who are missing salary data

-- Solution:
  SELECT first_name, status, salary
    FROM employees
    WHERE status = 'Active' AND salary IS NULL;

-- Expected Result:
  -- first_name  Eve
  -- status     Active
  -- salary      NULL

__________________________________________________________________________
-- 5 IS NULL vs Empty Strings
-- What it does: Explains the difference between NULL and empty text
-- Why use it: Avoids data quality bugs
__________________________________________________________________________
-- Problem: 
  -- Management wants employees whose role is missing

-- Solution: 
  SELECT first_name, role
    FROM employees
    WHERE role IS NULL;

-- Expected Results:
  -- first_name  Carol
  -- role         NULL
