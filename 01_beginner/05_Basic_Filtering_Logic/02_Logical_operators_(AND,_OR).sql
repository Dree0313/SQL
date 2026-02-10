__________________________________________________________________________
-- Beginner SQL: Logical Operators (AND, OR)
-- Purpose: Learn how to combine multiple conditions in WHERE clauses
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. Managment needs
  -- more precise reports that filter employees using multiple conditions
  -- at the same time. You will use logical operators (AND, OR) to control
  -- how conditions are combined.

  -- Table: employees
    -- id            1       2          3          4          5
    -- first_name  Alice     Bob       Carol       Dave       Eve
    -- last_name   Johnson  Smith      Davis      Wilson     Taylor
    -- department    HR      IT         HR         IT       Finance
    -- role        Manager  Analyst  Assistant  Developer  Accountant
    -- salary       75000    60000      50000     65000      NULL
    -- status      Active   Active    Inactive   Active      Active
  
__________________________________________________________________________
-- 1️ Logical AND
-- What it does: Requires ALL conditions to be true
-- Why use it: Narrows results to very specific rows
-- Syntax: WHERE condition1 AND condition2
__________________________________________________________________________
-- Problem: 
  -- Management wants active employees in the IT department

-- Solution: 
  SELECT *
    FROM employees
    WHERE department = 'IT' AND status = 'Active';

-- Expected Results:
  -- id            2       4
  -- first_name  Bob     Dave
  -- last_name  Smith   Wilson
  -- department  IT       IT
  -- role      Analyst  Developer
  -- salary     60000     65000
  -- status     Active    Active
__________________________________________________________________________
-- 2 Logical OR
-- What it does: Requires AT LEAST ONE condition to be true
-- Why use it: Broadens results to include mulitple possiblities
-- Syntax: WHERE condition1 OR condition2
__________________________________________________________________________
-- Problem:
  -- Management wants employees in HR OR Finance

--Solution:
  SELECT first_name, department
    FROM employees
    WHERE department = 'HR' OR department = 'Finance';

-- Expected Result:
  -- first_name  Alice  Carol  Eve
  -- department    HR    HR  Finance

__________________________________________________________________________
-- 3 AND with Comparison Operators
-- What it does: Combines value filtering with multiple conditions
-- Why use it: Precise control over numberic ranges
-- Syntax: WHERE condition1 AND condition2
__________________________________________________________________________
-- Problem:
  -- Management wants active employees earning more than 60000

-- Solution:
  SELECT first_name, salary
    FROM employees
    WHERE status = 'Active' AND salary > 65000;

-- Expected Result:
  -- first_name  Alice
  -- salary      75000

__________________________________________________________________________
-- 4 OR with Comparison Operators
-- What it does: Matches rows meeting any numeric condition
-- Why use it: Identifies outliers or multiple thresholds 
-- Syntax: WHERE condition1 OR condition2
__________________________________________________________________________
-- Problem:
  -- Management wants employees earning less than 55000 OR more than 70000

-- Solution:
  SELECT first_name, salary
    FROM employees
    WHERE salary < 55000 OR salary > 70000;

-- Expected Result:
  -- first_name  Alice  Carol
  -- salary      75000  50000

__________________________________________________________________________
-- 5 Combining AND + OR (Operator Precedence)
-- What it does: Combines multiple logical rules
-- Why use it: Models real business logic
-- Syntax: WHERE (condition1 OR condition2) AND condition3
__________________________________________________________________________
-- Problem: 
  -- Management wants employees in HR or IT who are Active

-- Solution: 
  SELECT first_name, department, status
    FROM employees
    WHERE (department = 'HR' OR department = 'IT') AND status = 'Active';

-- Expected Results:
  -- first_name  Alice  Dave  Eve
    -- department  HR    IT   IT

-- *Note: Parentheses control evaluation order
