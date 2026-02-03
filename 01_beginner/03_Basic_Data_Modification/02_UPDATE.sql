__________________________________________________________________________
-- Beginner SQL: UPDATE
-- Purpose: Learn how to modify existing records (rows) in a table
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. Managment needs to
  -- update employee information when salaries change, roles are promoted,
  -- departments are switched, or status changes. 

  -- Table: employees
    -- id            1       2          3          4          5
    -- first_name  Alice     Bob       Carol       Dave       Eve
    -- last_name   Johnson  Smith      Davis      Wilson     Taylor
    -- department    HR      IT         HR         IT       Finance
    -- role        Manager  Analyst  Assistant  Developer  Accountant
    -- salary       75000    60000      50000     65000      75000
    -- status      Active   Active    Inactive   Active      Active
  
__________________________________________________________________________
-- 1️ Basic UPDATE
-- What it does: Changes the value of one or more columns for selected 
  -- rows
-- Why use it: Keep data current and accurate
-- Syntax: UPDATE table_name SET column1 = value1, column2 = value2 WHERE
  -- condition;
__________________________________________________________________________
-- Problem: 
  -- Management wants to increase Bob's salary to 65000

-- Solution: 
  UPDATE employees
    SET salary = 65000
    WHERE first_name = 'Bob' AND last_name = 'Smith';

-- Expected Results:
  -- id            1       2          3          4          5
  -- first_name  Alice     Bob       Carol       Dave       Eve
  -- last_name   Johnson  Smith      Davis      Wilson     Taylor
  -- department    HR      IT         HR         IT       Finance
  -- role        Manager  Analyst  Assistant  Developer  Accountant
  -- salary       75000    65000      50000     65000      75000
  -- status      Active   Active    Inactive   Active      Active

__________________________________________________________________________
-- 2 UPDATE Multiple Columns
-- What it does: Changes more than one column at once
-- Why use it: Save time when updating mulitple fields
-- Syntax: UPDATE table_name SET column1 = value1, column2 = value2 WHERE
  -- condition;
__________________________________________________________________________
-- Problem:
  -- Management promotes Dave to Senior Developer with a salary increase

--Solution:
  UPDATE employees
    SET role = 'Developer', salary = 70000
    WHERE first_name = 'Dave' AND last_name = 'Wilson';

-- Expected Result:
  -- id            1       2          3          4          5
  -- first_name  Alice     Bob       Carol      Dave       Eve
  -- last_name   Johnson  Smith      Davis     Wilson     Taylor
  -- department    HR      IT         HR         IT       Finance
  -- role        Manager  Analyst  Assistant  Developer  Accountant
  -- salary       75000    60000      50000     70000      75000
  -- status      Active   Active    Inactive    Active     Active

__________________________________________________________________________
-- 3 UPDATE with WHERE Multiple Conditions
-- What it does: Updates rows that match several conditions
-- Why use it: Target specific records precisely
-- Syntax: UPDATE table_name SET column = value WHERE condition1 AND 
  -- condition2;
__________________________________________________________________________
-- Problem:
  -- Management wants to reactivate Carol, who is currently Inactive

-- Solution:
  UPDATE employees 
    SET status = 'Active'
    WHERE first_name = 'Carol' AND status = 'Inactive';

-- Expected Result:
  -- id            1       2          3          4          5
  -- first_name  Alice     Bob       Carol      Dave       Eve
  -- last_name   Johnson  Smith      Davis      Wilson     Taylor
  -- department    HR      IT         HR         IT       Finance
  -- role        Manager  Analyst  Assistant  Developer  Accountant
  -- salary       75000    60000     50000      65000      75000
  -- status      Active   Active     Active     Active     Active

__________________________________________________________________________
-- 4 UPDATE Multiple Rows
-- What it does: Updates all rows that match the condition
-- Why use it: Apply bulk changes efficiently
-- Syntax: UPDATE table_name SET column = value WHERE condition;
__________________________________________________________________________
-- Problem:
  -- Management gives a $2000 raise to all employees in the IT department

-- Solution:
  UPDATE employees 
    SET salary = salary + 2000
    WHERE department = 'IT';

-- Expected Result:
  -- id            1       2          3          4          5
  -- first_name  Alice     Bob       Carol       Dave       Eve
  -- last_name   Johnson  Smith      Davis      Wilson     Taylor
  -- department    HR      IT         HR         IT       Finance
  -- role        Manager  Analyst  Assistant  Developer  Accountant
  -- salary       75000    62000      50000     67000      75000
  -- status      Active   Active    Inactive   Active      Active

__________________________________________________________________________
-- 5 UPDATE Using NULL
-- What it does: Sets columns to NULL (unknown or missing value)
-- Why use it: Remove outdated or unknown data
-- Syntax: UPDATE table_name SET column = NULL WHERE condition;
__________________________________________________________________________
-- Problem:
  -- Management wants to remove the salary for Alice, who is pending 
    -- confirmation

-- Solution:
  UPDATE employees 
    SET salary = NULL
    WHERE first_name = 'Carol' AND last_name = 'Davis';

-- Expected Result:
  -- id            1        2          3          4          5
  -- first_name  Alice     Bob       Carol      Dave        Eve
  -- last_name   Johnson  Smith      Davis      Wilson     Taylor
  -- department    HR       IT         HR         IT       Finance
  -- role        Manager  Analyst  Assistant  Developer  Accountant
  -- salary       75000     NULL     50000      65000      75000
  -- status       Active   Active    Inactive   Active     Active

__________________________________________________________________________
-- 6 UPDATE with Aliases (Optional)
-- What it does: Makes queries more readable when using joins
-- Why use it: Simplify complex updates from mulitple tables
-- Syntax: UPDATE table_name AS t SET t.column = value WHERE 
  -- t.other_column = value;
__________________________________________________________________________
-- Problem:
  -- Management wants to update all Finance employee' status to 'Inactive'
    -- using a table alias

-- Solution:
  UPDATE employees AS e
    SET status = 'Inactive'
    WHERE department = 'IT';

-- Expected Result:
  -- id            1       2          3          4          5
  -- first_name  Alice     Bob       Carol       Dave       Eve
  -- last_name   Johnson  Smith      Davis      Wilson     Taylor
  -- department    HR      IT         HR         IT       Finance
  -- role        Manager  Analyst  Assistant  Developer  Accountant
  -- salary       75000    60000      50000     65000      75000
  -- status      Active   Inactive    Inactive   Inactive      Active
