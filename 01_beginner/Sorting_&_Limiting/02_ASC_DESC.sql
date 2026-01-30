__________________________________________________________________________
-- Beginner SQL: ASC / DESC
-- Purpose: Learn how to control sort direction in SQL queries
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. Managment wants
  -- reports sorted in different directions depending on the question 
  -- being asked. You will use ASC and DESC to control sorting order.

  -- Table: employees
    -- id            1       2          3          4          5
    -- first_name  Alice     Bob       Carol       Dave       Eve
    -- last_name   Johnson  Smith      Davis      Wilson     Taylor
    -- department    HR      IT         HR         IT       Finance
    -- role        Manager  Analyst  Assistant  Developer  Accountant
    -- salary       75000    60000      50000     65000      75000
    -- status      Active   Active    Inactive   Active      Active

  
__________________________________________________________________________
-- 1️ ASC (Ascending Order)
-- What it does: Sorts results for lowest → highest or A → Z
-- Why use it: Default sorting behavior in SQL
-- Syntax: SELECT columns FROM table_name ORDER BY column_name ASC;
__________________________________________________________________________
-- Problem: 
  -- Management wants employees sorted alphabetically by last name

-- Solution: 
SELECT first_name, last_name
FROM employees
ORDER BY last_name ASC;

-- Expected Results:
  -- First Name  Carol   Alice    Bob    Eve    Dave
  -- Last Name   Davis  Johnson  Smith  Taylor  Wilson

__________________________________________________________________________
-- 2 DESC (Descending Order)
-- What it does: Sorts results from highest → lowest or Z → A
-- Why use it: Useful for rankings and top values
-- Syntax: SELECT columns FROM table_name ORDER BY column_name DESC;
__________________________________________________________________________
-- Problem:
  -- Management wants highest-paid employees listed first

--Solution:
SELECT first_name, salary
FROM employees
ORDER BY salary DESC;

-- Expected Result:
  -- first_name  Alice   Eve   Dave    Bob   Carol
  -- salary      75000  75000  65000  60000  50000

__________________________________________________________________________
-- 3 ASC Is Optional
-- What it does: Uses ascending order without writing ASC
-- Why use it: Cleaner queries when ascending order is obvious
-- Syntax: SELECT columns FROM table_name ORDER BY column_name;
__________________________________________________________________________
-- Problem:
  -- Management wants employees sorted by department (default order)

-- Solution:
SELECT first_name, department
FROM employees
ORDER BY department;

-- Expected Result:
  -- first_name    Eve   Alice  Carol  Bob  Dave
  -- department  Finance  HR     HR     IT   IT

__________________________________________________________________________
-- 4 Mixing ASC and DESC
-- What it does: Applies different sort directions to multiple columns
-- Why use it: Precise control over complex sorting
-- Syntax: SELECT columns FROM table_name ORDER BY col1 ASC, col2 DESC;
__________________________________________________________________________
-- Problem:
  -- Management wants employees grouped by department (A → Z), but highest
    -- salary listed first within each department

-- Solution:
SELECT first_name, department, salary
FROM employees
ORDER BY department ASC, salary DESC;

-- Expected Result:
  -- first_name    Eve    Alice  Carol  Dave   Bob
  -- department  Finance   HR     HR     IT     IT
  -- salary       75000  75000   50000  65000  60000

__________________________________________________________________________
-- 5 ASC / DESC with Aliases
-- What it does: Sorts using a renamed column
-- Why use it: Cleaner queries with calculations or labels
-- Syntax: SELECT column AS alias FROM table_name ORDER BY alias DESC;
__________________________________________________________________________
-- Problem:
  -- Management wants salaries sorted using a readable column name

-- Solution:
SELECT first_name, salary AS Pay
FROM employees
ORDER BY Pay DESC;

-- Expected Result:
  -- first_name  Alice     Eve       Dave      Bob       Carol
  -- salary      75000    75000      65000    60000      50000
