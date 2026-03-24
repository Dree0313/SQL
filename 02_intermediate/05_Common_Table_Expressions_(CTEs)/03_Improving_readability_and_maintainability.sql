__________________________________________________________________________
-- Intermediate SQL: Improving Readability & Maintainability
-- Purpose: Learn how to write clean, understandable, and maintainabile
  -- SQL so queries are easy to debug, modify, and reuse
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Your queries work,
  -- but they are becoming difficult for others (and future you) to read
  -- and maintain.

  -- Goals:
    -- Write clear and readable SQL
    -- Avoid duplication of logic
    -- Make queries easy to debug and modify
    -- Follow consistent structure and formatting

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
-- 1 Use Meaningful Aliases
-- What it does: Makes queries easier to understand
-- Why it's harder: Avoids confusion in complex joins
__________________________________________________________________________
-- Bad:
  SELECT m.first_name, SUM(t.amount)
  FROM members m
  JOIN accounts x ON m.member_id = x.member_id
  JOIN transactions y ON x.account_id = y.account_id
  GROUP BY m.first_name;

-- Good:
  SELECT m.first_name, SUM(t.amount) AS total_amount
  FROM members m
  JOIN accounts a ON m.member_id = a.member_id
  JOIN transactions t ON a.account_id = t.account_id
  GROUP BY m.first_name;

-- Key Insight:
  -- Use logical aliases (m, a, t)
  -- Avoid random letters

__________________________________________________________________________
-- 2 Avoid Repeating Logic (DRY Principle)
-- What it does: Prevents duplication
-- Why use it: Easier updates and fewer bugs
__________________________________________________________________________
-- Problem:
  -- Repeating the same calculations

-- Bad:
  SELECT m.first_name, SUM(t.amount) AS total_amount
  FROM members m
  JOIN accounts a ON m.member_id = a.memeber_id
  JOIN transactions t ON a.account_id = t.account_id
  GROUP BY m.first_name
  HAVING SUM(t.amount) > 500;

-- Better (Using CTE):
  WITH member_totals AS (
    SELECT m.member_id, m.first_name, SUM(t.amount) AS total_amount
    FROM members m
    JOIN accounts a ON m.member_id = a.member_id
    JOIN transactions t ON a.account_id = t.account_id
    GROUP BY m.member_id, m.first_name)
  SELECT *
  FROM member_totals
  WHERE total_amount > 500;

-- Expected Result:
  -- first_name   Alice
  -- total_amount  650

-- Key Insight:
  -- Write logic once, reuse it

__________________________________________________________________________
-- 3 Use Step-by-Step Structure (CTEs)
-- What it does: Breaks complex logic into clear steps
-- Why use it: Easier to debug and mmodify
__________________________________________________________________________
-- Example Multi-step calculation:
  WITH account_totals AS (
    SELECT account_id, SUM(amount) AS total
    FROM transactions
    GROUP BY account_id
  ),
  member_totals AS (
    SELECT a.member_id, SUM(at.total) AS total_amount
    FROM accounts a
    JOIN account_totals at ON a.account_id = at.account_id
    GROUP BY a.member_id
  )
  SELECT *
  FROM member_totals;

-- Expected Result:
  -- member_id      1    2   3
  -- total_amount  650  500  75

-- Key Insight:
  -- Each step has one responsibility

__________________________________________________________________________
-- 4 Consistent Formatting & Structure
-- What it does: Standardizes how queries are written
-- Why use it: Improves team collaboration
__________________________________________________________________________
-- Best Practices:
  -- Uppercase SQL keywords (SELECT, FROM, WHERE)
  -- One column per line
  -- Indent JOIN conditions
  -- Align clauses (SELECT, FROM, WHERE, GROUP BY)

-- Example:
  SELECT 
  m.first_name,
  SUM(t.amount) AS total_amount
  FROM members m
  INNER JOIN accounts a
  ON m.member_id = a.member_id
  INNER JOIN transactions t
  ON a.account_id = t.account_id
  WHERE m.status = 'Active'
  GROUP BY m.first_name;

-- Key Insight:
  -- Consistency = professionalism

__________________________________________________________________________
-- 5 Common Readability Mistakes
-- What it does: Highlights issues that make SQL harder to maintain
-- Why use it: Avoids confusion and errors
__________________________________________________________________________
-- Mistake Selecting unnecessary columns:
  SELECT *

  -- Problem:
    -- Harder to understand and slower performance

  -- Fix:
    -- SELECT specific columns only

-- Mistake No aliases:

  -- Problem:
    -- Hard to track columns in joins

-- Mistake Long nested queries

  -- Problem:
    -- Difficult to debug

  -- Fix:
    -- Use CTEs to simplify

-- Key Insight:
  -- Write SQL fro humans first, machines second
