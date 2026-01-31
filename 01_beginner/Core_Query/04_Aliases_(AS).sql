__________________________________________________________________________
-- Beginner SQL: Aliases (AS)
-- Purpose: Learn how to rename columns and tables for readability
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. Managment wants
  -- reports that are easy to read and professional. You will use aliases
  -- to rename columns and tables in query results

  -- Table: employees
    -- id            1       2          3          4          5
    -- first_name  Alice     Bob       Carol       Dave       Eve
    -- last_name   Johnson  Smith      Davis      Wilson     Taylor
    -- department    HR      IT         HR         IT       Finance
    -- role        Manager  Analyst  Assistant  Developer  Accountant
    -- salary       75000    60000      50000     65000      75000
    -- status      Active   Active    Inactive   Active      Active

  
__________________________________________________________________________
-- 1️ Column Aliases
-- What it does: Renames a column in the result set
-- Why use it: Makes output clearer and more readable for reports
-- Syntax: SELECT * column_name AS alias_name FROM table_name;
__________________________________________________________________________
-- Problem: 
  -- Management wants first and last names displayed as "First Name" and
    -- "Last Name"

-- Solution: 
  SELECT first_name AS "First Name", last_name AS "Last Name"
  FROM employees;

-- Expected Results:
  -- First Name  Alice    Bob   Carol   Dave    Eve
  -- Last Name  Johnson  Smith  Davis  Wilson  Taylor

__________________________________________________________________________
-- 2 Aliases without AS (shorthand)
-- What it does: Renames a column without using the AS keyword
-- Why use it: Shorter syntax (common in real-world SQL)
-- Syntax: SELECT column_name FROM table_name;
__________________________________________________________________________
-- Problem:
  -- Management wants department shown as Dept

--Solution:
  SELECT department Dept
  FROM employees;

-- Expected Result:
  -- Dept   HR      IT     HR      IT  Finance

__________________________________________________________________________
-- 3 Aliases with Calculations
-- What it does: Names calculated columns
-- Why use it: Makes computed values understandable
-- Syntax: SELECT expression AS alias_name FROM table_name;
__________________________________________________________________________
-- Problem:
  -- Management wants to see annual salary labeled clearly

-- Solution:
  SELECT first_name, salary * 1 AS annual_salary
  FROM employees;

-- Expected Result:
  -- first_name     Alice   Bob   Carol  Dave    Eve
  -- annual_salary  75000  60000  50000  65000  75000

__________________________________________________________________________
-- 4 Aliases for Tables
-- What it does: Assigns a short name to a table
-- Why use it: Simplifies queries and improves readability (especially 
  -- with joins)
-- Syntax: SELECT columns FROM table_name AS alias;
__________________________________________________________________________
-- Problem:
  -- Management wants employee names and departments using a table alias

-- Solution:
  SELECT e.first_name, e.department
  FROM employees AS e;

-- Expected Result:
  -- Table name: e
  -- first_name  Alice   Carol   Eve
  -- department   HR      HR    Finance

__________________________________________________________________________
-- 5 Aliases with SELECT*
-- What it does: Renames the table while selecting all columns
-- Why use it: Prepares you for comples queries and joins
-- Syntax: SELECT alias.* FROM table_name AS alias;
__________________________________________________________________________
-- Problem:
  -- Management wants all employee data using a table alias

-- Solution:
  SELECT e.*
  FROM employees AS e;

-- Expected Result:
  -- id            1       2          3          4           5
  -- first_name  Alice     Bob       Carol      Dave        Eve
  -- last_name   Johnson  Smith      Davis     Wilson     Taylor
  -- department    HR      IT         HR         IT       Finance
  -- role        Manager  Analyst  Assistant  Developer  Accountant
  -- salary       75000    60000      50000     65000      75000
  -- status      Active   Active    Inactive   Active      Active
