__________________________________________________________________________
-- Intermediate SQL: Aggregating Across Related Tables
-- Purpose: Learn how to calculate summaries across multiple connected
  -- tables using JOIN + GROUP BY
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management does not
  -- want raw transaction rows. They want business-level summaries:

    -- Total balance per member
    -- Total transaction per account
    -- Average transaction per member
    -- Total deposits across all active members

  -- The data is stored across related tables and must be JOINED before
  -- aggregation.

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
-- 1️ Why Aggregating Across Tables Matters
-- What it does: Combines data before summarizing
-- Why use it: Produces real business insights
__________________________________________________________________________
-- Important Concept:
  -- You cannot summarize member totals directly from transactions
  -- because transactions connect to accounts first

-- Relationship chain:
  -- members → accounts → transactions

-- So aggregation requires JOIN + GROUP BY

__________________________________________________________________________
-- 2 Total Transaction Amount Per Member
-- What it does: Aggregates across 3 related tabels
-- Why use it: Shows full financial activity per member
__________________________________________________________________________
-- Problem:
  -- Management wants total transaction amount per member

-- Example:
  SELECT m.member_id, m.first_name, SUM(t.amount) AS total_amount
    FROM members m
    INNER JOIN accounts a ON m.member_id = a.member_id
    INNER JOIN transactions t ON a.account_id = t.account_id
    GROUP BY m.member_id, m.first_name;

-- Expected Result:
  -- member_id      1     2
  -- first_name   Alice  Bob
  -- total_amount  650   75

  -- Alice:
    -- Account 101 → 200 - 50
    -- Account 102 → 500
    -- Total = 650

__________________________________________________________________________
-- 3 Counting Transactions Per Member
-- What it does: Uses COUNT() across joined tables
-- Why use it: Identifies high activity members
__________________________________________________________________________
-- Problem: 
  -- Management wants number of transactions per member

-- Solution: 
  SELECT m.first_name, COUNT(t.transaction_id) AS transaction_count
    FROM members m
    INNER JOIN accounts a ON m.members_id = a.members_id
    INNER JOIN transactions t ON a.account_id = t.account_id
    GROUP BY m.first_name;

-- Expected Result:
  -- first_name       Alice  Bob
  -- transaction_count  3     1

__________________________________________________________________________
-- 4 LEFT JOIN for Complete Aggregation
-- What it does: Includes members with NO transactions
-- Why use it: Produces complete reporting
__________________________________________________________________________
-- Problem: Management wants ALL members, even those with no transactions

-- Solution:
    SELECT m.first_name, COALESCE(SUM(t.amount), 0) AS total_amount
      FROM members m
      LEFT JOIN accounts a ON m.member_id = a.member_id
      LEFT JOIN transactions t ON a.acount_id = t.account_id
      GROUP BY m.first_name;

-- Expected Result:
  -- first_name   Alice  Bob  Carol
  -- total_amount  650   75     0

  -- LEFT JOIN keeps Carol
  -- SUM() returns NULL for no matches
  -- COALESCE converts NULL to 0

__________________________________________________________________________
-- 5 Multi-Level Aggregation Insight
-- What it does: Shows how grouping level changes results
-- Why use it: Prevents incorrect summaries
__________________________________________________________________________
-- Example 1 (Grouped by Account):
  Select a.account_id, SUM(t.amount)
    FROM accounts a
    INNER JOIN transactions t ON a.account_id = t.account_id
    GROUP BY a.account_id;

  -- account_id   101  102  103
  -- SUM(amount)  150  500  75

-- Example 2 (Grouped by Member):
  SELECT m.member_id, SUM(t.amount)
    FROM members m
    INNER JOIN accounts a ON m.member_id = a.member_id
    INNER JOIN transactions t ON a.account_id = t.account_id
    GROUP BY m.member_id;

  -- member_id     1   2   3
  -- SUM(amount)  650  75  0

-- Key Insight:
  -- The GROUP BY column determines the level of summary
  -- Group by account_id → account-level totals
  -- Group by member_id → member-level totals

__________________________________________________________________________
-- 6 Exectuion Order (Very Important)
-- What it does: Explains how SQL processes aggregation queries
-- Why use it: Prevents logic errors
__________________________________________________________________________
-- SQL Order:
  -- FROM
  -- JOIN
  -- WHERE
  -- GROUP BY
  -- HAVING
  -- SELECT
  -- ORDER BY

-- Joins happen BEFORE grouping
-- Aggregation happens AFTER joining
-- That is why row multiplication affects totals

