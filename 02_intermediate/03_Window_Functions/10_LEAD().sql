__________________________________________________________________________
-- Intermediate SQL: LEAD() (Forward Row Comparison)
-- Purpose: Learn how to compare a row to a next row without 
  -- collapsing data (used for forecasting, trends, and analysis)
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management wants
  -- insights into future transaction behavior:

  -- Compare each transaction to the next one
  -- Identify upcoming increases or decreases
  -- Predict spending patterns
  -- Maintain row-level detail while analyzing forward movement

  -- You must compare rows WITHOUT grouping data

  -- Table: transactions
    -- transaction_id (PK) 1001         1002     1003         1004
    -- account_id (FK)      101         101       102          103
    -- amount               200         -50       500           75
    -- transaction_date  2026-01-10  2026-01-12 2026-01-05  2026-01-07
__________________________________________________________________________
-- 1️ What LEAD() Does
-- What it does: Retrieves the value from the next row
-- Why use it: Enables forward-looking comparison
__________________________________________________________________________
-- Important Concept:
  -- Looks "forward" in the dataset
  -- Requires ORDER BY to define row sequence
  -- Does NOT collapse rows

-- Think of it like:
  -- "Give me the value from the next row"

-- Example:
  SELECT transaction_date, amount, LEAD(amount) OVER (
    ORDER BY transaction_date) AS next_amount
  FROM transactions;

--Expected Result:
  -- transaction_date  2026-01-05  2026-01-07 2026-01-10  2026-01-12
  -- amount               500         75        200           -50
  -- previous_amount      75          200       -50          NULL

-- Key Insight:
  -- Last row has no next value → NULL

__________________________________________________________________________
-- 2 Difference Between Rows (Forward Comparison)
-- What it does: Calculates change between current and next rows
-- Why use it: Detects upcoming increases or decreases
__________________________________________________________________________
-- Problem:
  -- Management wants to predict how the next transaction differs

-- Solution:
  SELECT transaction_date, amount, LEAD(amount) OVER (
    ORDER BY transaction_date ) - amount AS future_change
  FROM transactions;

-- Expected Result:
  -- date       2026-01-05  2026-01-07  2026-01-10  2026-01-12
  -- amount         500         75          200         -50
  -- change        -425        125         -250        NULL

-- Key Insight:
  -- Positive = increase
  -- Negative = decrease

__________________________________________________________________________
-- 3 LEAD() Per Group (CRITICAL)
-- What it does: Resets forward comparison within each group
-- Why use it: Prevents mixing unrelated data
__________________________________________________________________________
-- Problem:
  -- You want foward comparisons per account

-- Solution:
  SELECT account_id, transaction_date, amount, LEAD(amount) OVER (
    PARTITION BY account_id ORDER BY transaction_date) AS next_amount
  FROM transactions;

-- Expected Result:
  -- account_id            101        101         102         103
  -- transaction_date  2026-01-10  2026-01-12  2026-01-05  2026-01-07
  -- amount                200        -50         500          75
  -- previous_amount       -50       NULL         NULL        NULL

-- Key Insight:
  -- LEAD() restarts for each acccount

__________________________________________________________________________
-- 4 LEAD() with Offset (Advanced)
-- What it does: Looks forward multiple rows
-- Why use it: Analyze future trends further ahead
__________________________________________________________________________
-- Example:
  SELECT transaction_date, amount, LEAD(amount, 2) OVER (
    ORDER BY transaction_date) AS two_rows_ahead
  FROM transactions;

-- Expected Result:
  -- transaction_date  2026-01-05  2026-01-07  2026-01-10  2026-01-12
  -- amount                500        75          200         -50
  -- previous_amount       200       -50          NULL        NULL

-- Key Insight:
  -- LEAD(column, N) → looks N rows forward

__________________________________________________________________________
-- 5 LEAD() vs LAG()
-- What it does: Highlights direction difference
-- Why use it: Prevents confusion
__________________________________________________________________________
-- LAG():
  -- Looks backward (previous row)

-- LEAD():
  -- Looks forward (next row)

-- Example Running Total:
  SELECT transcation_date, amount, LAG(amount) OVER (
    ORDER BY transaction_date AS previous_amount, LEAD(amount) OVER (
    ORDER BY transaction_date) AS next_amount
  FROM transactions;

-- Expected Result:
  -- transaction_date  2026-01-05  2026-01-07  2026-01-10  2026-01-12
  -- amount                500        75          200         -50
  -- previous_amount       NULL       500          75         200
  -- next_amount           75         200         -50         NULL

-- Key insight:
  -- LAG = past
  -- LEAD = future

__________________________________________________________________________
-- 6 Handling NULL Values (Important)
-- What it does: Replaces missing next values
-- Why use it: Prevents NULL from breaking calculations
__________________________________________________________________________
-- Problem:
  -- Last row returns NULL
    
-- Solution:
  SELECT transaction_date, amount, COALESCE(LEAD(amount) OVER (
    ORDER BY transaction_date), 0) - amount AS future_change
  FROM transactions;
