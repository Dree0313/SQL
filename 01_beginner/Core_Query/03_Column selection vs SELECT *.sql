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
  -- first_name  Alice    Bob   Carol   Dave    Eve
  -- last_name  Johnson  Smith  Davis  Wilson  Taylor
  -- department   HR      IT     HR      HR      IT

__________________________________________________________________________
-- 3 Multiple conditions with AND
-- What it does: Returns rows that meet all conditions
-- Why use it: Combine multiple filters
-- Syntax: SELECT columns FROM table_name WHERE condition1 AND condition2;
__________________________________________________________________________
-- Problem:
  -- Management wants employees in IT with a salary greater than 60000

-- Solution:
SELECT first_name, last_name, department, salary
FROM employees
WHERE department = 'IT' AND salary > 60000;

-- Expected Result:
  -- first_name  Dave
  -- last_name  Wilson
  -- department   IT
  -- salary     650000

__________________________________________________________________________
-- 4 Multiple conditions with OR
-- What it does: Returns rows that meet at least one condition
-- Why use it: Broader filtering options
-- Syntax: SELECT columns FROM table_name WHERE condition1 OR condition2;
__________________________________________________________________________
-- Problem:
  -- Management wants employees in HR or with a salary above 70000

-- Solution:
SELECT first_name, last_name, department, salary
FROM employees
WHERE department = 'HR' OR salary > 70000;

-- Expected Result:
  -- first_name  Alice   Carol   Eve
  -- last_name  Johnson  Davis  Taylor
  -- department   HR      HR    Finance
  -- salary      75000   50000   75000

__________________________________________________________________________
-- 5 Range filtering with BETEWEEN
-- What it does: Returns rows where value falls within a range
-- Why use it: Quickly find values between two limits
-- Syntax: SELECT columns FROM table_name WHERE column BETWEEN low AND high;
__________________________________________________________________________
-- Problem:
  -- HR wants a employees with salaries between 60000 and 70000

-- Solution:
SELECT first_name, last_name, salary
FROM employees
WHERE salary BETWEEN 60000 AND 70000;

-- Expected Result:
  -- first_name  Bob    Dave
  -- last_name  Smith  Wilson
  -- salary     60000  60000
__________________________________________________________________________
-- 6 Filter using IN
-- What it does: Returns rows where a column matches any value in a list
-- Why use it: Quick way to filter multiple specific values
-- Syntax: SELECT columns FROM table_name WHERE column IN (value1, value2, ...);
__________________________________________________________________________
-- Problem:
  -- Management wants employees in HR or IT

-- Solution:
SELECT first_name, last_name, department
FROM employees
WHERE department IN ('HR', 'IT');

-- Expected Result:
  -- first_name  Alice    Bob   Carol   Dave
  -- last_name  Johnson  Smith  Davis  Wilson
  -- department   HR      IT     HR      IT

__________________________________________________________________________
-- 7 Filter using LIKE
-- What it does: Returns rows that match a patter
-- Why use it: Useful for partial matches in strings
-- Syntax: SELECT columns FROM table_name WHERE column LIKE 'pattern';
__________________________________________________________________________
-- Problem:
  -- Management wants employees whose first name starts with 'D'

-- Solution:
SELECT first_name, last_name
FROM employees
WHERE first_name Like 'D%';

-- Expected Result:
  -- first_name  Dave
  -- last_name  Wilson

__________________________________________________________________________
-- 8 Handling NULL
-- What it does: Returns rows where a column is (or isn't) NULL
-- Why use it: Identifies missing or optional data
-- Syntax: SELECT columns FROM table_name WHERE column IS NULL/IS NOT NULL;
__________________________________________________________________________
-- Problem:
  -- HR wants employees who have a department assigned (no NULLs)

-- Solution:
SELECT first_name, last_name, department
FROM employees
WHERE department IS NOT NULL;

-- Expected Result:
  -- first_name  Alice    Bob   Carol   Dave    Eve
  -- last_name  Johnson  Smith  Davis  Wilson  Taylor
  -- department   HR      IT     HR      IT    Finance
