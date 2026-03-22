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
  -- amount         200        -50         500          75
  -- account_total  150        150         500          75

-- Key insight:
  -- One continuous sequence across ALL rows

__________________________________________________________________________
-- 3 ORDER BY with PARTITION BY (Per-Grouping Sequencing)
-- What it does: Orders rows within each group separately
-- Why use it: Enables running totals per account
__________________________________________________________________________
-- No PARTITION (entire table): 
  SELECT account_id, amount, SUM(amount) OVER () AS total_all
  FROM transactions;

-- Expected Results:
  -- account_id  101  101  102  103
  -- amount      200  -50  500  75
  -- total_all   725  725  725  725

-- With PARTITION: 
  SELECT account_id, amount, SUM(amount) OVER (
    PARTITION BY account_id) AS total_per_amount
  FROM transactions;

-- Expected Result:
  -- account_id        101  101  102  103
  -- amount            200  -50  500  75
  -- total_per_amount  150  150  500  75

-- Key Insight:
  -- No PARTITION → one big group
  -- PARTITION BY → multiple small groups

__________________________________________________________________________
-- 4 PARTITION BY with ORDER BY (Combining Concepts)
-- What it does: Adds sequencing inside each group
-- Why use it: Enables running totals per group
__________________________________________________________________________
-- Problem:
  -- Management wants running balance per account

-- Solution:
    SELECT account_id, transaction_date, amount, SUM (amount) OVER (
      PARTITION BY account_id ORDER BY transaction_date) AS running_balance
    FROM transactions;

-- Expected Result:
  --  account_id       101        101         102         103
  --  date         2026-01-10  2026-01-12  2026-01-05  2026-01-07
  --  amount           200         -50        500          75
  --  running_balance  200         150        500          75

-- Key Insight:
  -- PARTITION BY = grouping
  -- ORDER BY = sequence within group

__________________________________________________________________________
-- 5 Using PARTITION BY for Comparisons
-- What it does: Compares each row to its group total
-- Why use it: Useful for analytics and reporting
__________________________________________________________________________
-- Problem:
  -- Management wants to know how much each transaction contributes to its
  -- account total

-- Solution:
  Select account_id, amount, SUM(amount) OVER (
    PARTITION BY account_id) AS total, 
    amount * 1.0 / SUM(amount) OVER (
    PARTITION BY account_id) AS percent_of_total
  FROM transactions;

-- Expected Result:
  -- account_id  101   101   102   103
  -- amount      200   -50   500   75
  -- total       150   150   500   75
  -- percent    1.33  -0.33  1.00  1.00
