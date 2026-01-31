__________________________________________________________________________
-- Beginner SQL: ORDER BY
-- Purpose: Learn how to sort query results
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. Managment wants
  -- reports sorted in meaningful ways, such as alphabetically or by 
  -- salay. You will use ORDER BY to control the order of returned data.

  -- Table: employees
    -- id            1       2          3          4          5
    -- first_name  Alice     Bob       Carol       Dave       Eve
    -- last_name   Johnson  Smith      Davis      Wilson     Taylor
    -- department    HR      IT         HR         IT       Finance
    -- role        Manager  Analyst  Assistant  Developer  Accountant
    -- salary       75000    60000      50000     65000      75000
    -- status      Active   Active    Inactive   Active      Active

  
__________________________________________________________________________
-- 1️ Basic ORDER BY (Ascending Order)
-- What it does: Sorts results for A → Z or smallest → largest
-- Why use it: Default sorting behavior
-- Syntax: SELECT column FROM table_name ORDER BY column_name;
__________________________________________________________________________
-- Problem: 
  -- Management wants employees listed alphabetically by first name

-- Solution: 
  SELECT first_name, last_name
  FROM employees
  ORDER BY first_name;

-- Expected Results:
  -- First Name  Alice    Bob   Carol   Dave    Eve
  -- Last Name  Johnson  Smith  Davis  Wilson  Taylor

__________________________________________________________________________
-- 2 ORDER BY DESC (Descending Order)
-- What it does: Sorts results from Z → A or largest → smallest
-- Why use it: Useful for rankings and top values
-- Syntax: SELECT columns FROM table_name ORDER BY column_name DESC;
__________________________________________________________________________
-- Problem:
  -- Management wants employees ordered by highest salary first

--Solution:
  SELECT first_name, salary
  FROM employees
  ORDER BY salary DESC;

-- Expected Result:
  -- first_name  Alice   Eve   Dave    Bob   Carol
  -- salary      75000  75000  65000  60000  50000

__________________________________________________________________________
-- 3 ORDER BY ASC (Explicit Ascending)
-- What it does: Explicitly states ascending order
-- Why use it: Improves clarity in complex queries
-- Syntax: SELECT columns FROM table_name ORDER BY column_name ASC;
__________________________________________________________________________
-- Problem:
  -- Management wants employees ordered by salary from lowest to highest

-- Solution:
  SELECT first_name, salary
  FROM employees
  ORDER BY salary ASC;

-- Expected Result:
  -- first_name  Carol   Bob   Dave   Alice   Eve
  -- salary      50000  60000  65000  75000  75000

__________________________________________________________________________
-- 4 ORDER BY Multiple Columns
-- What it does: Sorts by more than one column
-- Why use it: Adds secondary sorting when values are the same
-- Syntax: SELECT columns FROM table_name ORDER BY col1, col2;
__________________________________________________________________________
-- Problem:
  -- Management wants employee sorted by department, then by last name

-- Solution:
  SELECT first_name, last_name, department
  FROM employees
  ORDER BY department, last_name;

-- Expected Result:
  -- first_name   Eve     Alice   Carol   Bob    Dave
  -- last_name   Taylor  Johnson  Davis  Smith  Wilson
  -- department  Finance   HR       HR     IT     IT

__________________________________________________________________________
-- 5 ORDER BY with DESC and ASC Together
-- What it does: Applies different sort directions per column
-- Why use it: Fine-grained control over sorting
-- Syntax: SELECT columns FROM table_name ORDER BY col1 DESC, col2 ASC;
__________________________________________________________________________
-- Problem:
  -- Management wants highest-paid employees first, but names 
    -- alphabetically within the same salary

-- Solution:
  SELECT first_name, salary
  FROM employees
  ORDER BY salary DESC, first_name ASC;

-- Expected Result:
  -- first_name  Alice     Eve       Dave      Bob       Carol
  -- salary      75000    75000      65000    60000      50000

__________________________________________________________________________
-- 6 ORDER BY with Aliases
-- What it does: Sorts results using a column alias
-- Why use it: Cleaner queries when using calculations or renamed colums
-- Syntax: SELECT column AS alias FROM table_name ORDER BY alias;
__________________________________________________________________________
-- Problem:
  -- Management wants salaries sorted using a column alias

-- Solution:
  SELECT first_name, salary AS Pay
  FROM employees
  ORDER BY Pay DESC;

-- Expected Result:
  -- first_name  Alice     Eve       Dave      Bob       Carol
  -- salary      75000    75000      65000    60000      50000
