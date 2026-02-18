__________________________________________________________________________
-- Intermediate SQL: Understanding HAVING
-- Purpose: Learn how to filter grouped results using HAVING
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management now wants
  -- summarized reports, but ONLY for certain groups that meed conditions.

  -- Only members with more than 1 transaction
  -- Only accounts with totals over $100
  -- Only active members with large balances

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
-- 1️ What HAVING Does
-- What it does: Filters grouped results
-- Why use it: Applies conditions AFTER aggregation
__________________________________________________________________________
-- Important Concept:
  -- WHERE filters rows BEFORE grouping
  -- HAVING filters groups AFTER grouping

-- Example:
  -- Show accounts where total transactions exceed $100

    SELECT amount_id, SUM (amount) AS total_amount
      FROM transactions
      GROUP BY account_id
      HAVING SUM(amount) > 100;

  -- Expected Result:
    -- account_id    101  102
    -- total_amount  150  500

    -- Account 103 is exclued because total = 75

__________________________________________________________________________
-- 2 HAVING with COUNT()
-- What it does: Filters groups based on row counts
-- Why use it: Identifies high activity members
__________________________________________________________________________
-- Problem:
  -- Management wants members with MORE THAN 1 transaction

-- Example:
  SELECT a.member_id, COUNT(t.transaction_id) AS transaction_count
    FROM accounts a
    INNER JOIN transactions 1 ON a.account_id = t.account_id
    GROUP BY a.member_id
    HAVING COUNT(t.transaction_id) > 1;

-- Expected Result:
  -- member_id          1
  -- transaction_count  3

  -- Only Alice (member_id 1) has more than 1 transaction

__________________________________________________________________________
-- 3 HAVING with JOIN
-- What it does: Filters summarized results across mulitiple tables
-- Why use it: Produces business-level filtered reports
__________________________________________________________________________
-- Problem: 
  -- Management wants total transaction amount per member BUT only for
  -- totals greater than 200

-- Solution: 
  SELECT m.first_name, SUM(t.amount) AS total_transactions
    FROM members m
    INNER JOIN accounts a ON m.members_id = a.members_id
    INNER JOIN transactions t ON a.account_id = t.account_id
    GROUP BY m.first_name
    HAVING SUM(t.amount) > 200;

-- Expected Result:
  -- first_name         Alice
  -- totatl_transactions 650

  -- Bob (75) and Carol (no transactions) are excluded

__________________________________________________________________________
-- 4 WHERE vs HAVING (Critical Difference)
-- What it does: Shows execution order
-- Why use it: Prevents logic mistakes
__________________________________________________________________________
-- Example:
  -- Incorrect:
    -- Trying to filter aggregated data using WHERE

    SELECT account_id, SUM(amount)
      FROM transactions
      WHERE SUM(amount) > 100
      GROUP BY account_id;

    -- You cannot use SUM() inside WHERE

  -- Correct:
    SELECT account_id, SUM(amount)
      FROM transactions
      GROUP BY account_id
      HAVING SUM(amount) > 100;

    -- Having works becaus it runs AFTER GROUP BY

__________________________________________________________________________
-- 5 Combining WHERE and HAVING
-- What it does: Filters rows first, then groups
-- Why use it: Efficient and precise reporting
__________________________________________________________________________
-- Problem:
  -- Management wants ACTIVE members with total transactions greater than
  -- 100

-- Solution:
  SELECT m.first_name, SUM(t.amount) AS total_amount
    FROM members m
    INNER JOIN accounts a ON m.member_id = a.member_id
    INNER JOIN transactions t ON a.account_id = t.account_id
    WHERE m.status = 'Active'
    GROUP BY m.first_name
    HAVING SUM(t.amount) > 100;

-- Expected Result:
  -- first_name   Alice  Bob
  -- total_amount  650   75

  -- WHERE filters rows first (Active members only)
  -- GROUP BY summarizes
  -- HAVING filters the grouped totals
