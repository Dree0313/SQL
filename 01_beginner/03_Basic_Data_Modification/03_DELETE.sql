__________________________________________________________________________
-- Beginner SQL: DELETE
-- Purpose: Learn how to remove existing records (rows) from a table
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. Managment needs to
  -- remove employee records when someone leaves the company, was added by
  -- mistake, or whne old/inactive data must be cleaned up.

  -- Table: employees
    -- id            1       2          3          4          5
    -- first_name  Alice     Bob       Carol       Dave       Eve
    -- last_name   Johnson  Smith      Davis      Wilson     Taylor
    -- department    HR      IT         HR         IT       Finance
    -- role        Manager  Analyst  Assistant  Developer  Accountant
    -- salary       75000    60000      50000     65000      NULL
    -- status      Active   Active    Inactive   Active      Active
  
__________________________________________________________________________
-- 1️ Basic DELETE
-- What it does: Removes specific rows from a table
-- Why use it: Delete records that are no longer needeed
-- Syntax: DELETE FROM table_name WHERE condition;
__________________________________________________________________________
-- Problem: 
  -- Management wants to remove Carol from the system

-- Solution: 
  DELETE FROM employees
    WHERE first_name = 'Carol' AND last_name = 'Davis';

-- Expected Results:
  -- id            1       2          4          5
  -- first_name  Alice     Bob       Dave       Eve
  -- last_name   Johnson  Smith      Wilson     Taylor
  -- department    HR      IT         IT       Finance
  -- role        Manager  Analyst  Developer  Accountant
  -- salary       75000    65000    65000        NULL
  -- status      Active   Active    Active      Active

__________________________________________________________________________
-- 2 DELETE Using NULL
-- What it does: Deletes rows with missing or unknown values
-- Why use it: Remove incomplete or invalid records
-- Syntax: DELETE FROM table_name WHERE column IS NULL;
__________________________________________________________________________
-- Problem:
  -- Management wants to remove employees without a salary assigned

--Solution:
  DELETE FROM employees
    WHERE salary IS NULL;

-- Expected Result:
  -- id            1       2          3            4
  -- first_name  Alice     Bob       Carol        Dave
  -- last_name   Johnson  Smith      Davis        Wilson
  -- department    HR      IT         HR           IT
  -- role        Manager  Analyst  Assistant  Senior Developer
  -- salary       75000    60000      50000       70000
  -- status      Active   Active    Inactive      Active

__________________________________________________________________________
-- 3 DELETE with Aliases (Optional)
-- What it does: Uses aliases for clarity (often with joins)
-- Why use it: Cleaner queries in complex databases
-- Syntax: DELETE FROM table_name AS t WHERE condition;
__________________________________________________________________________
-- Problem:
  -- Management wants to delete all IT employees using an alias

-- Solution:
  DELETE FROM employees 
    AS e
    WHERE e.department = 'IT';

-- Expected Result:
  -- id            1         3          5
  -- first_name  Alice      Carol       Eve
  -- last_name   Johnson    Davis     Taylor
  -- department    HR        HR       Finance
  -- role        Manager  Assistant  Accountant
  -- salary       75000     50000      75000
  -- status      Active     Active     Active

__________________________________________________________________________
-- 4 DANGER ZONE: DELETE Without WHERE
-- What it does: Deletes EVERY row in the table
-- Why use it: Rarely; usually only for full resets
-- Syntax: DELETE FROM table_name;
__________________________________________________________________________
-- Problem:
  -- Management remove the entire employee table

-- Solution:
  DELETE FROM employees;

-- Expected Result:
  -- The employees table is empty
  -- Table structure remains, but all data is gone
