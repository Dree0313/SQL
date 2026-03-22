__________________________________________________________________________
-- Intermediate SQL: Running Totals (Running Balances)
-- Purpose: Learn how to calculate cumulative sums across rows (used for
  -- balances, trends, and financial tracking)
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management wants
  -- transaction insight that show how balances change over time:

  -- Running balance per account
  -- Track deposits and withdrawals cumulatively
  -- View financial trends over time
  -- Maintain row-level detail while calculating totals

  -- You must calculate totals WITHOUT collapsing rows

  -- Table: transactions
    -- transaction_id (PK) 1001         1002     1003         1004
    -- account_id (FK)      101         101       102          103
    -- amount               200         -50       500           75
    -- transaction_date  2026-01-10  2026-01-12 2026-01-05  2026-01-07
__________________________________________________________________________
-- 1️ What a Running Total Does
-- What it does: Calculates a cumulative sum across ordered rows
-- Why use it: Tracks how values build over time
__________________________________________________________________________
-- Important Concept:
  -- Uses SUM() with OVER()
  -- Requires ORDER BY to define sequence
  -- Each row includes all previous values

-- Think of it like:
  -- "Keep adding each transaction to a growing total"

-- Example:
  SELECT account_id, transaction_date, amount, SUM(amount) OVER (
    ORDER BY transaction_date) AS running_total
  FROM transactions;

--Expected Result:
  -- date        2026-01-05  2026-01-07  2026-01-10  2026-01-12
  -- amount         500          75          200        -50
  -- running_total  500          575         775        725

-- Key Insight:
  -- Each row includes all previous amounts

__________________________________________________________________________
-- 2 Running Total Per Account (Most Common Use Case)
-- What it does: Calculates cumulative totals within each group
-- Why use it: Tracks balances per account
__________________________________________________________________________
-- Problem:
  -- Management wants a running balance for each account

-- Solution:
  SELECT account_id, transaction_date, amount, SUM(amount) OVER (
    PARTITION BY account_id ORDER BY transaction_date) AS running_balance
  FROM transactions;

-- Expected Result:
  -- account_id  101         101         102        103
  -- date     2026-01-10  2026-01-12  2026-01-05  2026-01-07
  -- amount      200         -50         500         75
  -- balance     200         150         500         75

__________________________________________________________________________
-- 3 Ordering Matters (Critical Concept)
-- What it does: Shows how order affects results
-- Why use it: Prevents incorrect calculations
__________________________________________________________________________
-- Problem: 
  -- What if order is wrong?

-- Example (incorrect logic): 
  SUM(amount) OVER (PARTITION BY account_id)

-- Result:
  -- Returns total per account (NOT running total)

-- Correct:
  SUM(amount) OVER (PARTITION BY account_id ORDER BY transaction_date)

-- Key Insight:
  -- No ORDER BY = no "running", just total

__________________________________________________________________________
-- 4 Running Total vs GROUP BY
-- What it does: Shows difference in behavior
-- Why use it: Prevents confusion
__________________________________________________________________________
-- GROUP BY:
  -- Collapses rows
  -- One row per account

-- Running Total:
  -- Keeps all rows
  -- Adds cumulative column

-- Example GROUP BY:
  SELECT account_id, SUM(amount)
  FROM transactions
  GROUP BY account_id;

-- Example Running Total:
  SELECT account_id transaction_date, amount, SUM(amount) OVER (
    PARTITION BY account_id ORDER BY transaction_date)
  FROM transactions;

-- Expected Result:
  -- account_id            101        101          102          103
  -- transaction_date  2026-01-10  2026-01-12  2026-01-05  2026-01-07
  -- amount                200        -50          500           75
  -- running_balance       200        150          500           75

-- Key Insight:
  -- GROUP BY = summary
  -- Running total = timeline

__________________________________________________________________________
-- 5 Advanced: Defining the Window Frame
-- What it does: Controls which rows are included in calculations
-- Why use it: Fine-tunes running logic
__________________________________________________________________________
-- Default behavior:
  -- Includes all previous rows up to current

-- Explicit version:
  SELECT account_id, transaction_date, amount, SUM(amount) OVER (
    PARTITION BY account_id 
    ORDER BY transaction_date 
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_balance
  FROM transactions;

-- Expected Result:
  -- account_id            101        101          102          103
  -- transaction_date  2026-01-10  2026-01-12  2026-01-05  2026-01-07
  -- amount                200        -50          500           75
  -- running_balance       200        150          500           75

-- Key insight:
  -- This defines the "start → current row" range
