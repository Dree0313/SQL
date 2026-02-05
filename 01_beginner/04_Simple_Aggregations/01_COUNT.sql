__________________________________________________________________________
-- Beginner SQL: Using WHERE Safely with Write Operations
-- Purpose: Learn how to safely use WHERE with INSERT, UPDATE, and DELETE
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. Managment needs 
  -- changes made to employee data, but mistakes can cause permanent data
  -- loss. You must use WHERE safely when performing write opertations 
  -- (UPDATE and DELETE).

  -- Table: employees
    -- id            1       2          3          4          5
    -- first_name  Alice     Bob       Carol       Dave       Eve
    -- last_name   Johnson  Smith      Davis      Wilson     Taylor
    -- department    HR      IT         HR         IT       Finance
    -- role        Manager  Analyst  Assistant  Developer  Accountant
    -- salary       75000    60000      50000     65000      NULL
    -- status      Active   Active    Inactive   Active      Active
  
__________________________________________________________________________
-- 1️ ALWAYS Preview with SELECT First
-- What it does: Shows exactly which rows will be affected
-- Why use it: Prevents accidental mass updates or deletes
-- Rule: If you wouldn't run it as SELECT, don't run it as UPDATE/DELETE
__________________________________________________________________________
-- Problem: 
  -- Management wants to delete Carol

-- Solution: 
  SELECT *
    FROM employees
    WHERE first_name = 'Carol' AND last_name = 'Davis';

DELETE FROM employees
  WHERE first_name = 'Carol' AND last_name = 'Davis';

-- Expected Results:
  -- id            1       2          4          5
  -- first_name  Alice     Bob       Dave       Eve
  -- last_name   Johnson  Smith      Wilson     Taylor
  -- department    HR      IT         IT       Finance
  -- role        Manager  Analyst  Developer  Accountant
  -- salary       75000    60000    65000        NULL
  -- status      Active   Active    Active      Active

__________________________________________________________________________
-- 2 Use Multiple Conditions (Be Specific)
-- What it does: Narrows down affected rows
-- Why use it: Reduces risk of deleting or updating the wrong data
-- Best Practice: Combine columns like name + department or id
__________________________________________________________________________
-- Problem:
  -- Management wants to update Bob's salary

--Solution:
  UPDATE employees
    SET salary = 65000
    WHERE first_name = 'Bob' AND last_name = 'Smith';

-- Expected Result:
  -- id            1       2          3            4        5
  -- first_name  Alice     Bob       Carol        Dave     Eve
  -- last_name   Johnson  Smith      Davis        Wilson  Taylor
  -- department    HR      IT         HR           IT     Finance
  -- role        Manager  Analyst  Assistant  Developer  Accountant
  -- salary       75000    65000      50000       70000     NULL
  -- status      Active   Active    Inactive      Active   Active

__________________________________________________________________________
-- 3 Use Primary Keys When Possible
-- What it does: Targets exactly one row
-- Why use it: IDs are unique and safest
-- Best Practice: Prefer id over names
__________________________________________________________________________
-- Problem:
  -- Management wants to activate Carol

-- Solution:
  UPDATE employees 
    SET status = 'Active'
    WHERE id = 3;

-- Expected Result:
  -- id            1       2          3          4          5
  -- first_name  Alice     Bob       Carol       Dave       Eve
  -- last_name   Johnson  Smith      Davis      Wilson     Taylor
  -- department    HR      IT         HR         IT       Finance
  -- role        Manager  Analyst  Assistant  Developer  Accountant
  -- salary       75000    60000      50000     65000       NULL
  -- status      Active   Active    Active      Active     Active

__________________________________________________________________________
-- 4 Handle NULLs Correctly
-- What it does: Safely filters rows with missing values
-- Why use it: NULL does NOT work
-- Rule: Always us IS NULL or IS NOT NULL
__________________________________________________________________________
-- Problem:
  -- Management remove employees without a salary

-- Solution:
  DELETE FROM employees
    WHERE salary IS NULL;

-- Expected Result:
  -- id            1       2          3          4
  -- first_name  Alice     Bob       Carol      Dave
  -- last_name   Johnson  Smith      Davis     Wilson
  -- department    HR      IT         HR         IT
  -- role        Manager  Analyst  Assistant  Developer
  -- salary       75000    60000      50000     65000
  -- status      Active   Active    Inactive   Active

__________________________________________________________________________
-- 5 Protect Yourself from Full-Table Updates
-- What it does: Prevents updating every row accidentally
-- Why use it: Missing WHERE affects ALL rows
__________________________________________________________________________
-- Problem: 
  -- Management only wants to set works in the IT department as inactive

-- Solution: 
  UPDATE employees
    SET status = 'Inactive'
    WHERE department = 'IT';

-- Expected Results:
  -- id            1       2          3          4          5
  -- first_name  Alice     Bob       Carol       Dave       Eve
  -- last_name   Johnson  Smith      Davis      Wilson     Taylor
  -- department    HR      IT         HR         IT       Finance
  -- role        Manager  Analyst  Assistant  Developer  Accountant
  -- salary       75000    60000      50000     65000      NULL
  -- status      Active   Inactive    Inactive   Inactive      Active

__________________________________________________________________________
-- 6 Use LIMIT (When Supported) for Extra Safety
-- What it does: Limits the number of affected rows
-- Why use it: Acts as a safety brake
-- Note: Not supported in all databases
__________________________________________________________________________
-- Problem:
  -- Management wants to delete on one inactive employee

--Solution:
  DELETE FROM employees
    WHERE status = 'Inactive'
    LIMIT 1;

-- Expected Result:
  -- id            1       2          4          5
  -- first_name  Alice     Bob       Dave       Eve
  -- last_name   Johnson  Smith     Wilson     Taylor
  -- department    HR      IT         IT       Finance
  -- role        Manager  Analyst  Developer  Accountant
  -- salary       75000    60000     65000       NULL
  -- status      Active   Active    Active      Active

__________________________________________________________________________
-- 3 Wrap Risky Writes in Transactions (Advanced Safety)
-- What it does: Allows rollback if something goes wrong
-- Why use it: Ultimate protection in production systems
__________________________________________________________________________
-- Problem:
  -- Management wants to activate Carol

-- Solution:
  BEGIN TRANSACTION;
  DELETE FROM employees
    WHERE department = 'Finance';

  ROLLBACK;

  COMMIT;

-- Expected Result:
  -- id            1       2          3          4
  -- first_name  Alice     Bob       Carol       Dave
  -- last_name   Johnson  Smith      Davis      Wilson
  -- department    HR      IT         HR         IT
  -- role        Manager  Analyst  Assistant  Developer
  -- salary       75000    60000      50000     65000
  -- status      Active   Active    Inactive    Active
