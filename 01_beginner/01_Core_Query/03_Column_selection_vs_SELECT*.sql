__________________________________________________________________________
-- Beginner SQL: Column Selection vs Select*
-- Purpose: Learn the difference between selecting all columns and
  -- specific columns
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. Managment wants to
  -- retrieve data from the employees table, but sometimes they want all
  -- the data, and sometimes only certain details

  -- Table: employees
    -- id            1       2          3          4          5
    -- first_name  Alice     Bob       Carol       Dave       Eve
    -- last_name   Johnson  Smith      Davis      Wilson     Taylor
    -- department    HR      IT         HR         IT       Finance
    -- role        Manager  Analyst  Assistant  Developer  Accountant
    -- salary       75000    60000      50000     65000      75000
    -- status      Active   Active    Inactive   Active      Active

  
__________________________________________________________________________
-- 1️ Mixing SELECT* and Specific Columns (not typical, but possible)
-- What it does: Returns all columns plus any additional expressions you
  -- specify
-- Why use it: Useful when combining all data with computed values
-- Syntax: SELECT*, expression AS alias FROM table_name;
__________________________________________________________________________
-- Problem: 
  -- Management wants all details and a new column showing if 
    -- salary > 65000

-- Solution: 
  SELECT*, salary > 65000 AS high_salary
    FROM employees;

-- Expected Results:
  -- id            1       2          3          4          5
  -- first_name  Alice     Bob       Carol       Dave       Eve
  -- last_name   Johnson  Smith      Davis      Wilson     Taylor
  -- department    HR      IT         HR         IT       Finance
  -- role        Manager  Analyst  Assistant  Developer  Accountant
  -- salary       75000    60000      50000     65000      75000
  -- status      Active   Active    Inactive   Active      Active
  -- high_salary  true     false      false     false       true

__________________________________________________________________________
-- 2 When to  use SELECT* vs column selection
-- SELECT* Good for: quick exploration, small tables, debugging
-- SELECT* Avoid for: production queries, large tables, 
  -- performance-sensitivity tasks
-- Column selection Good for: production queries, reports, performance
  -- optimization, readability
__________________________________________________________________________
-- Problem:
  -- Management wants to see first_name, role, and salary only

--Solution:
  SELECT first_name, role, salary
    FROM employees;

-- Expected Result:
  -- first_name  Alice    Bob      Carol       Dave        Eve
  -- role       Manager  Analyst  Assistant  Developer  Accountant
  -- salary      75000    60000    50000       65000      75000
