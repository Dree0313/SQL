__________________________________________________________________________
-- Beginner SQL: INSERT
-- Purpose: Learn how to add new records (rows) into a table
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. Managment needs to
  -- add new employees to the database as people are hired, promoted, or
  -- transferred. You will use INSERT to add data into tables safely and
  -- corrrectly.

  -- Table: employees
    -- id            1       2          3          4          5
    -- first_name  Alice     Bob       Carol       Dave       Eve
    -- last_name   Johnson  Smith      Davis      Wilson     Taylor
    -- department    HR      IT         HR         IT       Finance
    -- role        Manager  Analyst  Assistant  Developer  Accountant
    -- salary       75000    60000      50000     65000      75000
    -- status      Active   Active    Inactive   Active      Active

  
__________________________________________________________________________
-- 1️ Basic INSERT
-- What it does: Adds a single new row to a table
-- Why use it: Store new records in the database
-- Syntax: INSERT INTO table_name (column1, column2) VALUES (value1, 
  -- value2;
__________________________________________________________________________
-- Problem: 
  -- Management wants to add a new employee named Frank Miller

-- Solution: 
  INSERT INTO employees (first_name, last_name, department, role, salary,
    status)
    VALUES ('Frank', 'Miller', 'IT', 'Support', 55000, 'Active');

-- Expected Results:
  -- A new role is added to the employees table with Frank's information

__________________________________________________________________________
-- 2 INSERT Without Column List
-- What it does: Inserts values into every column in order
-- Why use it: Faster, but risky if table structure changes
-- Syntax: INSERT INTO table_name VALUES (value1, value2, value3, ...);
__________________________________________________________________________
-- Problem:
  -- Management wants to add employee Grace Lee with all fields filled

--Solution:
  INSERT INTO employees
    VALUES (6, 'Grace', 'Lee', 'Finance', 'Analyst', 62000, 'Active');

-- Expected Result:
  -- first_name  Alice   Eve
  -- salary      75000  75000

-- *This requires values for ALL columns in the correct order
__________________________________________________________________________
-- 3 LIMIT with ASC (Lowest Values)
-- What it does: Returns the lowest N values
-- Why use it: Find bottom values or minimum records
-- Syntax: SELECT columns FROM table_name ORDER BY column ASC LIMIT 
  -- number;
__________________________________________________________________________
-- Problem:
  -- Management wants the 2 lowest-paid employees

-- Solution:
  SELECT first_name, salary
  FROM employees
  ORDER BY salary ASC
  LIMIT 2;

-- Expected Result:
  -- first_name  Carol   Bob
  -- salary      50000  60000

__________________________________________________________________________
-- 4 LIMIT with Multiple Sort Rules
-- What it does: Applies LIMIT after multi-column sorting
-- Why use it: Precise ranking and filtering
-- Syntax: SELECT columns FROM table_name ORDER BY col1 DESC, col2 ASC 
  -- LIMIT number;
__________________________________________________________________________
-- Problem:
  -- Management wants the top 3 highest-paid employees, sorted
    -- alphabetically when salaries tie

-- Solution:
  SELECT first_name, salary
  FROM employees
  ORDER BY salary DESC, first_name ASC
  LIMIT 3;

-- Expected Result:
  -- first_name  Alice   Eve   Dave
  -- salary      75000  75000  65000

__________________________________________________________________________
-- 5 LIMIT with WHERE
-- What it does: Limits results after filtering
-- Why use it: Focus on a subset of data
-- Syntax: SELECT columns FROM table_name WHERE condition ORDER BY column
  -- LIMIT number;
__________________________________________________________________________
-- Problem:
  -- Management wants the top 2 highest-paid IT employees

-- Solution:
  SELECT first_name, department, salary
  FROM employees
  WHERE department = 'IT'
  ORDER BY salary DESC
  LIMIT 2;

-- Expected Result:
  -- first_name  Dave    Bob
  -- department   IT     IT
  -- salary      65000  60000

__________________________________________________________________________
-- 6 LIMIT with Aliases
-- What it does: Uses renamed colums in sorting and limiting
-- Why use it: Cleaner and more readable queries
-- Syntax: SELECT columns AS alias FROM table_name ORDER BY alias DESC
  -- LIMIT number;
__________________________________________________________________________
-- Problem:
  -- Management wants the top 3 salaries using a readable column name

-- Solution:
  SELECT first_name, salary AS Pay
  FROM employees
  ORDER BY Pay DESC
  LIMIT 3;

-- Expected Result:
  -- first_name  Alice   Eve   Dave
  -- Pay         75000  75000  65000
