__________________________________________________________________________
-- Intermediate SQL: Row-Based Calculations (Per-Row Analytics)
-- Purpose: Learn how to perform calculations between rows without 
  -- collapsing date (used for comparisons, trends, and analysis)
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management wants
  -- deeper insight into how individual transactions relate to each other:

  -- Compare each transaction to the previous one
  -- Identify increases or decreases in spending
  -- Analyze transaction patterns over time
  -- Maintain row-level detail while adding insights

  -- You must calculate differences BETWEEN rows without grouping data

  -- Table: transactions
    -- transaction_id (PK) 1001         1002     1003         1004
    -- account_id (FK)      101         101       102          103
    -- amount               200         -50       500           75
    -- transaction_date  2026-01-10  2026-01-12 2026-01-05  2026-01-07
__________________________________________________________________________
-- 1️ What Row-Based Calculations Do
-- What it does: Compares values across rows using window functions
-- Why use it: Enables trend analysis and change detection
__________________________________________________________________________
-- Important Concept:
  -- Uses LAG() or LEAD()
  -- Requires ORDER BY to define row sequence
  -- Does NOT collapse rows

-- Think of it like:
  -- "Look at the row before or after this one"

-- Example:
  SELECT account_id, transaction_date, amount, LAG(amount) OVER (
    ORDER BY transaction_date) AS previous_amount
  FROM transactions;

--Expected Result:
  -- date          2026-01-05  2026-01-07  2026-01-10  2026-01-12
  -- amount           500          75          200        -50
  -- previous_amount  NULL         500         75        200

-- Key Insight:
  -- First row has no previous value → NULL

__________________________________________________________________________
-- 2 Difference Between Rows (Most Common Use Case)
-- What it does: Calculates change between current and previous rows
-- Why use it: Detects increasees, decreases, or anomalies
__________________________________________________________________________
-- Problem:
  -- Management wants to know how each transaction changed from the 
  -- previous

-- Solution:
  SELECT account_id, transaction_date, amount, amount - LAG(amount) OVER (
    ORDER BY transaction_date) AS change
  FROM transactions;

-- Expected Result:
  -- date     2026-01-05  2026-01-07  2026-01-10  2026-01-12
  -- amount      500         75         200         -50
  -- change      NULL       -425        125         -250

-- Key Insight:
  -- Positive = increase
  -- Negative = decrease

__________________________________________________________________________
-- 3 Row-Based Calculations Per Account
-- What it does: Compares rows within each group
-- Why use it: Prevents mixing data across accounts
__________________________________________________________________________
-- Problem: 
  -- Management wants changes per account, not globally

-- Solution: 
  SELECT account_id, transaction_date, amount, amount - LAG(amount) OVER (
    PARTITION BY account_id ORDER BY transaction_date) AS change
  FROM transactions;

-- Expected Result:
  -- account_id  101         101        102         103
  -- date    2026-01-10  2026-01-12  2026-01-05  2026-01-07
  -- amount      200         -50        500          75
  -- change      NULL        -250       NULL        NULL

-- Key Insight:
  -- LAG() resets for each account

__________________________________________________________________________
-- 4 LAG() vs LEAD()
-- What it does: Shows direction of comparison
-- Why use it: Choose whether to look backward or forward
__________________________________________________________________________
-- LAG() → looks backward (previous row)
-- LEAD() → looks forward (next row)

-- Example:
  SELECT transactions_date, amount, LEAD(amount) OVER (
    ORDER BY transaction_date) AS next_amount
  FROM transactions;

-- Expected Result:
  -- date      2026-01-05  2026-01-07  2026-01-10  2026-01-12
  -- amount       500          75          200        -50
  -- neext_amount  75          200         -50        NULL

-- Key Insight:
  -- Last row has no next value → NULL

__________________________________________________________________________
-- 5 Row-Based Calculations vs Running Totals
-- What it does: Highlights key difference
-- Why use it: Prevents confusion between concepts
__________________________________________________________________________
-- Running Total:
  -- Adds values cumulatively
  -- Looks at ALL previous rows

-- Row-Based Calculation:
  -- Compares ONE row to another
  -- Focuses on differences

-- Example Running Total:
  SUM(amount) OVER (ORDER BY transaction_date)

-- Example Row Comparison:
  amount - LAG(amount) OVER (ORDER BY transaction_date)

-- Key insight:
  -- Running total = accumulation
  -- Row-based = comparison

__________________________________________________________________________
-- 6 Advanced: Handling NULL Values
-- What it does: Replaces missing comparisons
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
