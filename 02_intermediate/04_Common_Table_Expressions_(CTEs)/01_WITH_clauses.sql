__________________________________________________________________________
-- Intermediate SQL: Using WITH Clauses (Common Table Expressions - CTEs)
-- Purpose: Learn how to simplify complex queries by breaking them into
  -- readable, reusable steps
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management wants
  -- complex reports, but your queries are becoming hard to read and debug.

  -- Instead of writing large nested subqueries, you can use WITH clauses
  -- (CTEs) to:
    -- Break queries into logical steps
    -- Improve readability
    -- Reuse intermediate results

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
-- 1️ What is a WITH Clause (CTE)?
-- What it does: Creates a temporary named result set
-- Why use it: Make complex queries easier to read and manage
__________________________________________________________________________
-- Example:
  WITH cte_name AS (
    SELECT ...
  }
  SELECT ...
  FROM cte_name;

-- Solution:
  SELECT m.member_id, m.first_name 
    (SELECT SUM (t.amount)
    FROM accounts a
    INNER JOIN transactions t ON a.account_id = t.account_id
    WHERE a.member_id = m.member_id) AS total_amount
  FROM members m;

-- Key Idea:
  -- Think of a CTE as a temporary table you define at the top
  -- It only exists for that query

__________________________________________________________________________
-- 2 Replacing a Subquery with a CTE
-- What it does: Moves nested logic into a readable step
-- Why it's harder: Improves clarity and debugging
__________________________________________________________________________
-- Problem:
  -- Management wants total transaction amount per member

-- Subquery Version (harder to read):
  SELECT m.member_id, m.first_name, 
    (SELECT SUM(t.amount)
    FROM amounts a
    INNER JOIN transactions t ON a.account_id = t.account_id
    WHERE a.member_id = m.member_id) AS total_amount
  FROM members m;

  CTE Version (cleaner):
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
  -- total_amount 650   75    NULL

__________________________________________________________________________
-- 3 Using CTE for Filtering
-- What it does: Separates calculation from filtering
-- Why use it: Make business logic clearer
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
  -- Step 2: Filter results
  -- Very clear separation of logic

__________________________________________________________________________
-- 4 When CTEs (Breaking Problems into Steps)
-- What it does: Chains multiple logical steps
-- Why use it: Handles complex queries cleanly
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
  }
  SELECT m.first_name, mt.total_amount
  FROM members m
  INNER JOIN member_totals mt ON m.memeber_id = mt.member_id
  WHERE mt.total_amount > (SELECT avg_amount FROM average_total);

-- Expected Result:
  -- first_name   Alice
  -- total_amount  650

__________________________________________________________________________
-- 5 CTE vs Subquery vs JOIN
-- What it does: Helps choose the best approach
-- Why use it: Improves query design decisions
__________________________________________________________________________
-- Subquery         Simple       per-row logic
-- JOIN + GROUP BY  Performance  large datasets
-- CTE (WITH)       Readability  complex logic
