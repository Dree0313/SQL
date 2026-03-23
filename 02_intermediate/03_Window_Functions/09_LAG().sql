__________________________________________________________________________
-- Intermediate SQL: LAG() (Row-to-Row Comparison)
-- Purpose: Learn how to compare a row to a previous row without 
  -- collapsing data (used for trends, changes, and analysis)
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management wants
  -- insights into how transadctions change over time:

  -- Compare each transaction to the previous one
  -- Identify increases or decreases in spending
  -- Track patterns within each account
  -- Maintain row-level detail while each account

  -- You must compare rows WITHOUT grouping data

  -- Table: transactions
    -- transaction_id (PK) 1001         1002     1003         1004
    -- account_id (FK)      101         101       102          103
    -- amount               200         -50       500           75
    -- transaction_date  2026-01-10  2026-01-12 2026-01-05  2026-01-07
__________________________________________________________________________
-- 1️ What LAG() Does
-- What it does: Retrieves the value from a previous row
-- Why use it: Enables row-by-row comparison
__________________________________________________________________________
-- Important Concept:
  -- Looks "backward" in the dataset
  -- Requires ORDER BY to define row sequence
  -- Does NOT collapse rows

-- Think of it like:
  -- "Give me the value from the row before this one"

-- Example:
  SELECT transaction_date, amount, LAG(amount) OVER (
    ORDER BY transaction_date) AS previous_amount
  FROM transactions;

--Expected Result:
  -- transaction_date  2026-01-05  2026-01-07 2026-01-10  2026-01-12
  -- amount               500         75        200           -50
  -- previous_amount      NULL        500        75           200

-- Key Insight:
  -- First row has no previous value → NULL

__________________________________________________________________________
-- 2 Difference Between Rows (Most Common Use Case)
-- What it does: Calculates change between current and previous rows
-- Why use it: Detects, increases, decreases, or anomalies
__________________________________________________________________________
-- Problem:
  -- Management wants to know how each transaction changed fromt the 
  -- previous

-- Solution:
  SELECT transaction_date, amount, amount - LAG(amount) OVER (
    ORDER BY transaction_date ) AS change
  FROM transactions;

-- Expected Result:
  -- date       2026-01-05  2026-01-07  2026-01-10  2026-01-12
  -- amount         500         75          200         -50
  -- change         NULL       -425         125        -250

-- Key Insight:
  -- Positive = increase
  -- Negative = decrease

__________________________________________________________________________
-- 3 LAG() Per Group (CRITICAL)
-- What it does: Resets comparison within each group
-- Why use it: Prevents mixing unrelated data
__________________________________________________________________________
-- Problem:
  -- Management want comparisons per account, not across all accounts

-- Solution:
  SELECT account_id, transaction_date, amount, LAG(amount) OVER (
    PARTITION BY account_id ORDER BY transaction_date) AS previous_amount
  FROM transactions;

-- Expected Result:
  -- account_id            101        101         102         103
  -- transaction_date  2026-01-10  2026-01-12  2026-01-05  2026-01-07
  -- amount                200        -50         500          75
  -- previous_amount       NULL       200         NULL        NULL

-- Key Insight:
  -- LAG() restarts for each acccount

__________________________________________________________________________
-- 4 LAG() with Offset (Advanced)
-- What it does: Looks back multiple rows
-- Why use it: Compare against earlier history
__________________________________________________________________________
-- Example:
  SELECT transaction_date, amount, LAG(amount, 2) OVER (
    ORDER BY transaction_date) AS two_rows_back
  FROM transactions;

-- Expected Result:
  -- transaction_date  2026-01-05  2026-01-07  2026-01-10  2026-01-12
  -- amount                500        75          200         -50
  -- previous_amount       NULL       NULL        500          75

-- Key Insight:
  -- LAG(column, N) → looks N rows back

__________________________________________________________________________
-- 5 LAG() vs Running Totals
-- What it does: Highlights key differences
-- Why use it: Prevents confusion between concepts
__________________________________________________________________________
-- Running Total:
  -- Adds values cumulatively
  -- Looks at ALL previous rows

-- LAG():
  -- Compares ONE row to a previous row
  -- Focuses on differences

-- Example Running Total:
  SUM(amount) OVER (ORDER BY transaction_date)

-- Example LAG():
  LAG(amount) OVER (ORDER BY transaction_date)

-- Key insight:
  -- Running total = accumulation
  -- LAG() = comparison

__________________________________________________________________________
-- 6 Handling NULL Values (Important)
-- What it does: Replaces missing previous values
-- Why use it: Prevents NULL from breaking calculations
__________________________________________________________________________
-- Problem:
  -- First row returns NULL
    
-- Solution:
  SELECT transaction_date, amount, amount - COALESCE(LAG(amount) OVER (
    ORDER BY transaction_date), 0) AS change
  FROM transactions;

-- Key insight:
  -- COALESCE replaces NULL with a default value
