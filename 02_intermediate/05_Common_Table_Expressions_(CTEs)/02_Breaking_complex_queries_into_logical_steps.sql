__________________________________________________________________________
-- Intermediate SQL: Breaking Complex Queries into Logical Steps (CTEs &
  -- Stepwise Thinking)
-- Purpose: Learn how to tackle complex queries by separating logic into
  -- clear, reusable steps
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management wants
  -- insights across multiple tables, but the queries are becoming hard to
  -- read and debug.

  -- Goals:
    -- Calculate Intermediate results step by steps
    -- Keep queries readable and maintainable
    -- Reuse results without duplicating logic

  -- Table: members
    -- member_id (PK)  1       2        3
    -- first_name    Alice    Bob     Carol
    -- status        Active  Active  Inactive

  -- Table: accounts
    -- account_id (PK)  101        102      103      104
    -- member_id (FK)    1          1        2        3
    -- account_type    Checking  Savings  Checking  Savings

  -- Table: transactions
    -- transaction_id (PK) 1001  1002  1003  1004
    -- account_id (FK)     101   101   102   103
    -- amount              200   -50   500   75
__________________________________________________________________________
-- 1️ Why Break Queries into Steps
-- What it does: Makes complex logic understandable
-- Why use it: Easier debugging, reusable logic, and clarity
__________________________________________________________________________
-- Key Concept:
  -- Each CTE is a temporary named resulted set
  -- You can chain multiple CTEs for sequential steps
  -- Improves clarity compared to deeply nested subqueries

-- Think of it like:
  -- "Solve one part at a time instead of all at once"

-- Example:
  WITH step1 AS (
      SELECT ...),
    step2 AS (
      SELECT ...FROM step1 ...)
  SELECT *
  FROM step2;

-- Key Insight:
  -- CTE isolates a calculation and gives it a name

__________________________________________________________________________
-- 2 Replacing Nested Subqueries
-- What it does: Moves complicated calculations out of main SELECT
-- Why it's harder: Improves readability and maintenance
__________________________________________________________________________
-- Problem:
  -- Managements wants Total transactions per member

-- Nested Subquery Version (Harder to Read):
  SELECT m.member_id, m.first_name,
    (SELECT SUM(t.amount)
    FROM accounts a
    INNER JOIN transactions t ON a.account_id = t.account_id
    WHERE a.member_id = m.member_id) AS total_amount
  FROM members m;

-- CTE Version (Readable):
    WITH member_totals AS (
      SELECT a.member_id, SUM(t.amount) AS total_amount
      FROM accounts a
      INNER JOIN transactions t ON a.account_id = t.account_id
      GROUP BY a.member_id
    )
    SELECT m.member_id, m.first_name, mt.total_amount
    FROM members m
    LEFT JOIN member_totals mt ON m.member_id = mt.member_id;

-- Expected Result:
  -- member_id     1     2     3
  -- first_name  Alice  Bob  Carol
  -- total_amount 650   500    75

-- Key Insight:
  -- Calculation logic is separate → much easier to read

__________________________________________________________________________
-- 3 Filtering Using a CTE
-- What it does: Separates calculation from business logic
-- Why use it: Make your queries more understandable
__________________________________________________________________________
-- Problem:
-- Managment wants members with total transactions > 500

-- Solution:
  WITH member_totals AS (
    SELECT a.member_id, SUM(t.amount) AS total_amount
    FROM accounts a
    INNER JOIN transactions t ON a.account_id = t.account_id
    GROUP BY a.member_id
  )
  SELECT m.member_id, m.first_name, mt.total_amount
  FROM members m
  INNER JOIN member_totals mt ON m.member_id = mt.member_id
  WHERE mt.total_amount > 500;

-- Expected Results:
  -- member_id      1
  -- first_name   Alice
  -- total_amount  650

-- Why this is readable:
  -- Step 1: Calculate totals
  -- Step 2: Apply business rule (filter)

__________________________________________________________________________
-- 4 Chaining Multiple CTEs
-- What it does: Breaks a problem into sequential steps
-- Why use it: Handles multi-step calculations cleanly
__________________________________________________________________________
-- Problem:
  -- Management wants members whose totals exceed the average

-- Solution:
  WITH member_totals AS (
    SELECT a.member_id, SUM(t.amount) AS total_amount
    FROM accounts a
    INNER JOIN transactions t ON a.account_id = t.account_id
    GROUP BY a.member_id
  ),
  average_total AS (
    SELECT AVG(total_amount) AS avg_amount
    FROM member_totals
  )
  SELECT m.first_name, mt.total_amount
  FROM members m
  INNER JOIN member_totals mt ON m.memeber_id = mt.member_id
  WHERE mt.total_amount > (SELECT avg_amount FROM average_total);

-- Expected Result:
  -- first_name   Alice
  -- total_amount  650

-- Key Insight:
  -- Each step is clear and modular → easier to maintain

__________________________________________________________________________
-- 5 CTE vs Subqueries vs JOINs
-- What it does: Helps choose the best approach for readability and 
  -- performance
-- Why use it: Optimizes query design
__________________________________________________________________________
-- Subquery         Simple       single-use calculations
-- JOIN + GROUP BY  Performance-focuseed for large datasets
-- CTE (WITH)       Readability  sequential steps  Complex logic

-- Key Insight:
  -- Break queries into logical steps to simplify debugging and 
    -- understanding
  -- Each step can be validated independently
