__________________________________________________________________________
-- Intermediate SQL: ORDER BY in Window Functions (Row Sequencing)
-- Purpose: Learn how ORDER BY inside OVER() controls the sequence of
  -- calculations across rows (critical for running totals & rankings)
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management wants
  -- time-based insights from transaction data:

    -- Running balances per account
    -- Transactions in order of activity
    -- Step-by-step accumulation of values
    -- Ranking transactions by amount

  -- You must control the ORDER of calculations WITHOUT changing the
  -- final output structure

  -- Table: transactions
    -- transaction_id (PK) 1001         1002     1003         1004
    -- account_id (FK)      101         101       102          103
    -- amount               200         -50       500           75
    -- transaction_date  2026-01-10  2026-01-12 2026-01-05  2026-01-07
__________________________________________________________________________
-- 1️ What ORDER BY Does in OVER()
-- What it does: Defines the sequence of rows for calculation
-- Why use it: Enables running totals, rankings, and time-based logic
__________________________________________________________________________
-- Important Concept:
  -- ORDER BY inside OVER() does NOT sort final results
  -- It ONLY controls how calculatiions are performed

-- Think of it like:
  -- ORDER BY (outside) → controls display
  -- ORDER BY (inside OVER) → controls calculations

__________________________________________________________________________
-- 2 ORDER BY Without PARTITION (Whole Table Sequence)
-- What it does: Applies ordering across entire dataset
-- Why use it: Calculates running totals across all rows
__________________________________________________________________________
-- Problem:
  -- Management wants a running total across ALL transactions

-- Solution:
  SELECT account_id, transaction_date, amount, SUM(amount) OVER (
    ORDER BY transaction_date) AS running total
  FROM transactions;

-- Expected Result:
  -- account_id     102        103         101         101
  -- date       2026-01-05  2026-01-07  2026-01-10  2026-01-12
  -- amount         500        75          200         -50
  -- account_total  500        575         775         725

-- Key insight:
  -- One continuous sequence across ALL rows

__________________________________________________________________________
-- 3 ORDER BY with PARTITION BY (Per-Grouping Sequencing)
-- What it does: Orders rows within each group separately
-- Why use it: Enables running totals per account
__________________________________________________________________________
-- Problem: 
  -- Management wants running balance per account

-- Solution: 
  SELECT account_id, transaction_date, amount, SUM(amount) OVER (
    PARTITION BY account_id ORDER BY transaction_date) AS running_balance
  FROM transactions;

-- Expected Result:
  -- account_id        101         101         102         103
  -- date           2026-01-10  2026-01-12  2026-01-05  2026-01-07
  -- amount            200         -50         500          75
  -- total_per_amount  200         150         500          75

-- Key Insight:
  -- ORDER BY resets within each PARTITION

__________________________________________________________________________
-- 4 ORDER BY vs No ORDER BY
-- What it does: Shows why sequencing matters
-- Why use it: Prevents incorrect assumptions
__________________________________________________________________________
-- Without ORDER By:
  SELECT account_id, amount, SUM(amount) OVER (
    PARTITION BY account_id) AS total_per_amount
  FROM transactions;

-- Expected Result:
  -- account_id  101  101  102  103
  -- amount      200  -50  500  75
  -- total       150  150  500  75

-- With ORDER BY:
    SELECT account_id, transaction_date, amount, SUM (amount) OVER (
      PARTITION BY account_id ORDER BY transaction_date) AS running_total
    FROM transactions;

-- Expected Result:
  --  account_id       101         101
  --  amount           200         -50
  --  running_balance  200         150

-- Key Insight:
  -- No ORDER BY → full total
  -- ORDER BY → step-by-step calculation

__________________________________________________________________________
-- 5 ORDER BY for Ranking
-- What it does: Assigns position based on value order
-- Why use it: Identifies top transactions
__________________________________________________________________________
-- Problem:
  -- Management wants to rank transactions by amount

-- Solution:
  Select account_id, amount, ROW_NUMBER() OVER (
    ORDER BY amount DESC) AS rank
  FROM transactions;

-- Expected Result:
  -- account_id  102   101   103   101
  -- amount      500   200    75   -50
  -- rank         1     2     3     4

-- Key insight:
  -- ORDER BY determines ranking order

__________________________________________________________________________
-- 6 Execution Insight (Very Important)
-- What it does: Explains when ORDER BY in OVER() runs
-- Why use it: Prevents confusion between sorting and calculation
__________________________________________________________________________
-- SQL Order:
  -- FROM
  -- JOIN
  -- WHERE
  -- GROUP BY
  -- HAVING
  -- SELECT (Window functions run here)
  -- ORDER BY (final output sorting

-- That is why:
  -- You can have different ordering for calculation vs display
