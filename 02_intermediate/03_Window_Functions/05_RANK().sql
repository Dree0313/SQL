__________________________________________________________________________
-- Intermediate SQL: RANK() (Handling Ties in Ranking)
-- Purpose: Learn how to assign rankings to rows where equal values share
  -- the same rank (used for leaderboards, comparisons, analytics)
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management wants
  -- ranking and insights that correctly handle ties:

  -- Rank transactions by amount (with ties)
  -- Identify top-performing transactions
  -- Compare transactions fairly when values are equal
  -- Under ranking gaps

  -- You must ranke rows WITHOUT collapsing data and while handling ties
    -- correctly

  -- Table: transactions
    -- transaction_id (PK) 1001         1002     1003         1004
    -- account_id (FK)      101         101       102          103
    -- amount               200         -50       500           75
    -- transaction_date  2026-01-10  2026-01-12 2026-01-05  2026-01-07
__________________________________________________________________________
-- 1️ What RANK() Does
-- What it does: Assigns a rank to rows, allowing ties
-- Why use it: Ensures equal values receive the same ranking
__________________________________________________________________________
-- Important Concept:
  -- RANK() requires ORDER BY
  -- Equal values → same rank
  -- Skips numbers after ties

-- Think of it like:
  -- "Give equal performers the same position, even if it creates gaps"

-- Example:
  SELECT account_id, amount, RANK() OVER (
    ORDER BY amount DESC) AS rank_num
  FROM transactions;

--Expected Result:
  -- account_id  102  101  103  101
  -- amount      500  200  75  -50
  -- row_num      1    2    3    4

-- Key Insight:
  -- Ranking is based on value order

__________________________________________________________________________
-- 2 RANK() with Ties (Important Behavior)
-- What it does: Demonstrates how ties affect ranking
-- Why use it: Prevents misunderstanding in real datasets
__________________________________________________________________________
-- If amounts were:
  -- 500, 200, 200, 75

-- Query:
  SELECT amount, RANK() OVER (ORDER BY amount DESC) AS rank_num
  FROM transactions;

-- Expected Result:
  -- amount         500        200          200         75
  -- row_num         1          2            2          4

-- Key insight:
  -- Rank 3 is skipped because of the tie

__________________________________________________________________________
-- 3 Getting the MOst Recent Row Per Group
-- What it does: Filters to only the top-ranked row
-- Why use it: Common real-world requirement
__________________________________________________________________________
-- Problem: 
  -- Management wants the most recent transaction per account

-- Solution (using CTE): 
  WITH ranked_transactions AS (
    SELECT account_id, transaction_date, amount, ROW_NUMBER() OVER (
      PARTITION BY account_id ORDER BY transaction_date DESC) AS rn
    FROM transactions)
  SELECT account_id, transaction_date, amount
  FROM ranked_transactions
  WHERE rn = 1;

-- Expected Result:
  -- account_id        101         102         103
  -- date           2026-01-12  2026-01-05  2026-01-07
  -- amount            -50         500         75

-- Key Insight:
  -- rn = 1 → top row per group

__________________________________________________________________________
-- 4 ROW_NUMBER() vs RANK()
-- What it does: Shows difference in ranking behavior
-- Why use it: Prevents confusion in ranking logic
__________________________________________________________________________
-- ROW_NUMBER:
  -- Always unique numbers (no ties)
  -- 1, 2, 3, 4

-- If amounts were:
  -- 500, 200, 200, 75

-- ROW_NUMBER() result:
    -- 1, 2, 3, 4

-- Key Insight:
  -- Even equal values get different numbers

__________________________________________________________________________
-- 5 Deduplication Using ROW_NUMBER()
-- What it does: Removes duplicate rows
-- Why use it: Cleans data efficiently
__________________________________________________________________________
-- Problem:
  -- Remove duplicate transactions per account (keep latest)

-- Solution:
  WITH deduped AS (SELECT *, ROW_NUMBER() OVER ( 
      PARTITION BY account_id ORDER BY transaction_date DESC) AS rn
    FROM transactions)
  SELECT *
  FROM deduped
  WHERE rn = 1;

-- Expected Result:
  -- transaction_id       1002        1003       1004
  -- account_id            101         102        103
  -- amount                -50         500         75
  -- transacctions_date 2026-01-12  2026-01-05  2026-01-07
  -- rn                     1            1         1

-- Key insight:
  -- Keeps only the "best" row per group

__________________________________________________________________________
-- 6 Execution Insight (Very Important)
-- What it does: Explains when ROW_NUMBER() runs
-- Why use it: Prevents logical mistakes
__________________________________________________________________________
-- SQL Order:
  -- FROM
  -- JOIN
  -- WHERE
  -- GROUP BY
  -- HAVING
  -- SELECT (Window functions run here)
  -- ORDER BY

-- Important:
  -- ROW_NUMBER() is calculated during SELECT
  -- You cannot filter it directly in WHERE
  -- Use a CTE or subquery to filter
