__________________________________________________________________________
-- Beginner SQL: Comparison Operators
-- Purpose: Learn how to filter data using comparison operatores (=, !=,
  -- <, >, <=, >=)
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. Managment needs 
  -- reports that filter employees based on salary, status, or other 
  -- conditions. You will use comparison operators in WHERE clauses to
  -- control which rows are returned.

  -- Table: employees
    -- id            1       2          3          4          5
    -- first_name  Alice     Bob       Carol       Dave       Eve
    -- last_name   Johnson  Smith      Davis      Wilson     Taylor
    -- department    HR      IT         HR         IT       Finance
    -- role        Manager  Analyst  Assistant  Developer  Accountant
    -- salary       75000    60000      50000     65000      NULL
    -- status      Active   Active    Inactive   Active      Active
  
__________________________________________________________________________
-- 1️ Equality Operator (=)
-- What it does: Matches rows where ravlues are exactly equal
-- Why use it: Filters for one specific value
-- Syntax: WHERE column_name = value
__________________________________________________________________________
-- Problem: 
  -- Management wants to see only IT employees

-- Solution: 
  SELECT *
    FROM employees
    WHERE department = 'IT';

-- Expected Results:
   -- id            2       4
    -- first_name  Bob     Dave
    -- last_name  Smith   Wilson
    -- department  IT       IT
    -- role      Analyst  Developer
    -- salary     60000     65000
    -- status     Active    Active
__________________________________________________________________________
-- 2 NOT Equal Operator (!=)
-- What it does: Excludes rows matching a value
-- Why use it: Removes unwanted categories
-- Syntax: WHERE column_name != value
__________________________________________________________________________
-- Problem:
  -- Management wants all employees who are NOT inactive

--Solution:
  SELECT *
    FROM employees
    WHERE status != 'Inactive';

-- Expected Result:
  -- id            1       2         4          5
  -- first_name  Alice     Bob      Dave       Eve
  -- last_name   Johnson  Smith     Wilson     Taylor
  -- department    HR      IT         IT       Finance
  -- role        Manager  Analyst  Developer  Accountant
  -- salary       75000    60000     65000       NULL
  -- status      Active   Active     Active     Active

__________________________________________________________________________
-- 3 Greater Than (>)
-- What it does: Returns rows with values above a threshold
-- Why use it: Filters high-perfoming or high-value records
-- Syntax: WHERE column_name > value
__________________________________________________________________________
-- Problem:
  -- Management wants employees earning more than 65000

-- Solution:
  SELECT first_name, salary
    FROM employees
    WHERE salary > 65000;

-- Expected Result:
  -- first_name  Alice
  -- salary       75000

__________________________________________________________________________
-- 4 Less Than (<)
-- What it does: Returns rows with values below a threshold
-- Why use it: Identifies lower ranges or outliers
-- Syntax: WHERE column_name < value
__________________________________________________________________________
-- Problem:
  -- Management wants employees earning less than 60000

-- Solution:
  SELECT first_name, salary
    FROM employees
    WHERE salary < 60000;

-- Expected Result:
  -- first_name  Carol
  -- salary       50000

__________________________________________________________________________
-- 5 Greater Than or Equal To (>=)
-- What it does: Includes values equal to or above a threshold
-- Why use it: Inclusive filtering
-- Syntax: WHERE column_name >= value
__________________________________________________________________________
-- Problem: 
  -- Management wants employees earning at least 65000

-- Solution: 
  SELECT first_name, salary
    FROM employees
    WHERE salary >= 65000;

-- Expected Results:
  -- first_name  Alice      Dave       Eve
  -- salary       75000    65000       NULL

__________________________________________________________________________
-- 6 Less Than or Equal To (<=)
-- What it does: Includes values equal to or below a threshold
-- Why use it: Inclusive lower-bound filter
-- Syntax: WHERE column_name >= value
__________________________________________________________________________
-- Problem: 
  -- Management wants employees earning 60000 or less

-- Solution: 
  SELECT first_name, salary
    FROM employees
    WHERE salary <= 60000;

-- Expected Results:
  -- first_name  Bob   Carol
  -- salary     60000  50000
