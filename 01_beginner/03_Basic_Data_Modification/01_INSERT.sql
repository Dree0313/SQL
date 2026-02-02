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

  -- Table: interns
    -- first_name  Kevin
    -- last_name  Moore
    -- department  IT
    -- salary   48000
  
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
  -- id            1       2          3          4          5          6
  -- first_name  Alice     Bob       Carol       Dave       Eve       Frank
  -- last_name   Johnson  Smith      Davis      Wilson     Taylor     Miller
  -- department    HR      IT         HR         IT       Finance      IT
  -- role        Manager  Analyst  Assistant  Developer  Accountant  Support
  -- salary       75000    60000      50000     65000      75000      55000
  -- status      Active   Active    Inactive   Active      Active     Active

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
  -- id            1       2          3          4          5          6
  -- first_name  Alice     Bob       Carol       Dave       Eve       Grace
  -- last_name   Johnson  Smith      Davis      Wilson     Taylor      Lee
  -- department    HR      IT         HR         IT       Finance    Finance
  -- role        Manager  Analyst  Assistant  Developer  Accountant  Analyst
  -- salary       75000    60000      50000     65000      75000      62000
  -- status      Active   Active    Inactive   Active      Active     Active

-- *This requires values for ALL columns in the correct order
-- *Best practice: Always specify column names
__________________________________________________________________________
-- 3 INSERT Multiple Rows
-- What it does: Inserts muliple records in one statement
-- Why use it: Faster and more efficient
-- Syntax: INSERT INTO table_name (columns) VALUES (row1_values, 
  -- (row2_values);
__________________________________________________________________________
-- Problem:
  -- Management wants to add two new HR employees at once

-- Solution:
  INSERT INTO employees (first_name, last_name, department, role, salary,
    status)
    VALUES ('Hannah', 'Brown', 'HR', 'Recruiter', 58000, 'Active'), ('Ian',
    'Clark', 'HR', 'Coordinator', 52000, 'Active');

-- Expected Result:
  -- id            1       2          3          4          5          6             7
  -- first_name  Alice     Bob       Carol       Dave       Eve      Hannah         Ian
  -- last_name   Johnson  Smith      Davis      Wilson     Taylor     Brown        Clark
  -- department    HR      IT         HR         IT       Finance      HR            HR
  -- role        Manager  Analyst  Assistant  Developer  Accountant  Recruiter  Coordinator
  -- salary       75000    60000      50000     65000      75000      58000        52000
  -- status      Active   Active    Inactive   Active      Active     Active       Active

__________________________________________________________________________
-- 4 INSERT with Default Values
-- What it does: Uses default values defined in the table
-- Why use it: Avoids manually setting common fields
-- Syntax: INSERT INTO table_name (columns) VALUES (values);
__________________________________________________________________________
-- Problem:
  -- Management wants to add Julia Adams without specifying status

-- Solution:
  INSERT INTO employees (first_name, last_name, department, role, salary)
    VALUES ('Julia', 'Adams', 'IT', 'Developer', 70000);

-- Expected Result:
  -- id            1       2          3          4          5          6
  -- first_name  Alice     Bob       Carol       Dave       Eve       Julia
  -- last_name   Johnson  Smith      Davis      Wilson     Taylor     Adams
  -- department    HR      IT         HR         IT       Finance      IT
  -- role        Manager  Analyst  Assistant  Developer  Accountant  Developer
  -- salary       75000    60000      50000     65000      75000      70000
  -- status      Active   Active    Inactive   Active      Active     Active

-- *Assumptions: status column has a DEFAULT value of 'Active'
__________________________________________________________________________
-- 5 INSERT Using SELECT
-- What it does: Inserts data from another table
-- Why use it: Copy or move data efficiently
-- Syntax: INSERT INTO table_name (columns) SELECT columns FROM 
  -- other_table WHERE condition;
__________________________________________________________________________
-- Problem:
  -- Management wants to promote interns into full employees

-- Solution:
  INSERT INTO employees (first_name, department, role, salary, staus)
    SELECT first_name, last_name, department, 'Junior Developer', salary,
    'Acitve'
    FROM interns
    WHERE department = 'IT';

-- Expected Result:
  -- id            1       2          3          4          5             6
  -- first_name  Alice     Bob       Carol       Dave       Eve          Kevin
  -- last_name   Johnson  Smith      Davis      Wilson     Taylor        Moore
  -- department    HR      IT         HR         IT       Finance         IT
  -- role        Manager  Analyst  Assistant  Developer  Accountant  Junior Developer
  -- salary       75000    60000      50000     65000      75000         48000
  -- status      Active   Active    Inactive   Active      Active        Active

__________________________________________________________________________
-- 6 INSERT with NULL Values
-- What it does: Inserts missing or unknown values
-- Why use it: Some data may not be available yet
-- Syntax: INSERT INTO table_name (columns) VALUES (value, NULL);
__________________________________________________________________________
-- Problem:
  -- Management wants to add an employee without a salary yet

-- Solution:
  INSERT INTO employees (first_name, last_name, department, role, salary, 
    status)
    VALUES ('Liam', 'Scott', 'Finance', 'Trainee', NULL, 'Active');

-- Expected Result:
  -- id            1       2          3          4          5          6
  -- first_name  Alice     Bob       Carol       Dave       Eve       Liam
  -- last_name   Johnson  Smith      Davis      Wilson     Taylor     Scott
  -- department    HR      IT         HR         IT       Finance    Finance
  -- role        Manager  Analyst  Assistant  Developer  Accountant  Trainee
  -- salary       75000    60000      50000     65000      75000       NULL
  -- status      Active   Active    Inactive   Active      Active     Active
