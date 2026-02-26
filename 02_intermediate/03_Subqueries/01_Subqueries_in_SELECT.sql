__________________________________________________________________________
-- Intermediate SQL: Subqueries in SELECT
-- Purpose: Learn how to use subqueries inside the SELECT clause to
  -- calculate values per row
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management wants
  -- detailed reports that show each member, along with calculated
  -- summaries next to their name.

    -- Total transaction per account
    -- Number of accounts per member
    -- Average transaction amount per member

  -- Instead of grouping the entire result, you will calculate summary
  -- values using subqueries directly inside SELECT.

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
-- 1️ What is a Subquery in SELECT?
-- What it does: Runs a query inside the SELECT clause
-- Why use it: Calculates values per row without grouping the outer query
__________________________________________________________________________
-- Important Concept:
  -- A subquery in SELECT runs once for EACH row returned
  -- IT is often called a correlated subquery

-- Problem:
  -- Management wants to see each member and total transaction amount

-- Solution:
  SELECT m.member_id, m.first_name, 
    (SELECT SUM (t.amount)
      FROM accounts a
      INNER JOIN transactions t ON a.account_id = t.account_id
      WHERE a.member_id = m.member_id) AS total_amount
    FROM members m;

-- Expected Result:
  -- member_id      1     2     3
  -- first_name   Alice  Bob  Carol
  -- total_amount  650   75    NULL

-- The subquery calculates totals separately from each member
-- Carol returns NULL because she has no transactions
__________________________________________________________________________
-- 2 Using COUNT() in a Subquery
-- What it does: Counts related rows per parent row
-- Why use it: Shows activity levels without GROUP BY
__________________________________________________________________________
-- Problem:
  -- Management wants number of accounts per member

-- Example:
  SELECT m.member_id, m.first_name
    (SELECT COUNT(*)
      FROM accounts a
      WHERE a.member_id = m.member_id) AS account_count
    FROM members m;

-- Expected Result:
  -- member_id      1     2     3
  -- first_name   Alice  Bob  Carol
  -- account_count  2     1     1

-- No GROUP BY neeeded in the outer query
-- Each row calculates its own count

__________________________________________________________________________
-- 3 Subquery with Multiple Tables
-- What it does: Aggregates across relationships per row
-- Why use it: Combines relational logic with row-level reporting
__________________________________________________________________________
-- Problem: 
  -- Management wants each member and average transaction amount

-- Solution: 
  SELECT m.first_name, 
    (SELECT AVG(t.amount)
      FROM accounts a
      INNER JOIN transactions t ON a.account_id = t.account_id
      WHERE a.member_id = m.member_id) AS avg_transaction
    FROM members m;

-- Expected Result:
  -- first_name       Alice  Bob  Carol
  -- avg_transaction  216.67  75  NULL

__________________________________________________________________________
-- 4 Using COALESCE with Subqueries
-- What it does: Replaces NULL results
-- Why use it: Creates cleaner reports
__________________________________________________________________________
-- Problem: Management wants zero instead of NULL

-- Solution:
    SELECT m.first_name, 
      COALESCE((SELECT SUM(t.amount)
        FROM accounts a
        INNER JOIN transactions t ON a.account_id = t.account_id
        WHERE a.member_id = m.member_id), 0) AS total_amount
      FROM members m;

-- Expected Result:
  -- first_name   Alice  Bob  Carol
  -- total_amount  650   75     0

__________________________________________________________________________
-- 5 Subquery vs GROUP BY (Important Difference)
-- What it does: Compares two approaches
-- Why use it: Helps choose correct technique
__________________________________________________________________________
-- GROUP BY version:
  Select m.member_id, SUM(t.amount)
    FROM members m
    INNER JOIN accounts a ON m.member_id = a.member_id
    INNER JOIN transactions t ON a.account_id = t.account_id
    GROUP BY m.member_id;

  -- member_id       1   2
  -- SUM(t.amount)  650  75

-- Subquery version:
  SELECT m.member_id, 
    (SELECT SUM(t.amount)
      FROM accounts a
      INNER JOIN transactions t ON a.account_id = t.account_id
      WHERE a.member_id = m.member_id)
    FROM members m;

  -- member_id    1   2    3
  -- (subquery)  650  75  NULL
  

-- Key Insight:
  -- GROUP BY changes the number of rows returned
  -- Subqueries in SELECT keep the original row count
  -- Subqueries calculate values per row

__________________________________________________________________________
-- 6 Exectuion Insight (Very Important)
-- What it does: Explains processing logic
-- Why use it: Prevents performance misunderstandings
__________________________________________________________________________
-- SQL Processing Order for Subqueries:
  -- 1. Outer FROM (members)
  -- 2. For EACH member row:
    -- Run the subquery
    -- Return calculated value
  -- 3. Return final result set
  
  -- Subqueries in SELECT can be slower on very large datasets because
  -- they execute once per row

-- Best Practice:
  -- Use subqueries for clarity
  -- Use JOIN + GROUP BY for high-performance reporting
