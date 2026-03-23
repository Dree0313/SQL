__________________________________________________________________________
-- Intermediate SQL: CASE WHEN (Conditional Logic)
-- Purpose: Learn how to apply conditional logic in queries (used for
  -- categorization, flagging, and flexible calculations)
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management wants to
  -- classify transactions and flag important ones:

  -- Flag positive vs negative transactions
  -- Categorize transactions as "High" or "Low" value
  -- Handle special cases with custom logic
  -- Maintain row-level detail while applying conditions

  -- Table: transactions
    -- transaction_id (PK) 1001         1002     1003         1004
    -- account_id (FK)      101         101       102          103
    -- amount               200         -50       500           75
    -- transaction_date  2026-01-10  2026-01-12 2026-01-05  2026-01-07
__________________________________________________________________________
-- 1️ What CASE WHEN Does
-- What it does: Applies conditional logic to each row
-- Why use it: Enables dynamic categorization and flagging
__________________________________________________________________________
-- Important Concept:
  -- Evaluates conditions in order
  -- Returns the corresponding value for the first true condition
  -- ELSE handles all remaining cases (optional)

-- Think of it like:
  -- "If this, then that; else something else"

-- Example:
  SELECT transaction_date, amount,
  CASE
  WHEN amount > 0 THEN 'Deposit'
  WHEN amount < 0 THEN 'Withdrawal'
  ELSE 'Zero'
  END AS transaction_type
  FROM transactions;

--Expected Result:
  -- transaction_date  2026-01-05  2026-01-07  2026-01-10  2026-01-12
  -- amount               500         75          200         -50
  -- transaction_type   Deposit     Deposit     Deposit    Withdrawal

-- Key Insight:
  -- Each row is evaluated independently

__________________________________________________________________________
-- 2 CASE WHEN with Multiple Conditions
-- What it does: Handles complex logic with multiple checks
-- Why use it: Creates categories or scores
__________________________________________________________________________
-- Example for Flag high-value transactions:
  SELECT transaction_date, amount,
  CASE
  WHEN amount >= 400 THEN 'High Value'
  WHEN amount >= 100  THEN 'Medium Value'
  ELSE 'Low Value'
  END AS value_category
  FROM transactions;

-- Expected Result:
  -- transaction_date  2026-01-10  2026-01-12  2026-01-05  2026-01-07
  -- amount               500         75          200         -50
  -- value_category       High       Low         Medium       Low

-- Key Insight:
  -- Conditions are checked top → bottom
  -- First matching condition wins

__________________________________________________________________________
-- 3 CASE WHEN with Math (Advanced Use)
-- What it does: Applies conditional calculations
-- Why use it: Enables dynamic computations without creating extra collums
__________________________________________________________________________
-- Example for Apply bonus only for deposits > 100:
  SELECT transaction_date, amount,
  CASE
  WHEN amount > 100 THEN amount * 0.1
  ELSE 0
  END AS bonus
  FROM transactions;

-- Expected Result:
  -- transaction_date  2026-01-05  2026-01-07  2026-01-10  2026-01-12
  -- amount                500        75         200          -50
  -- bonus                  50         0          20           0

-- Key Insight:
  -- CASE can be used in SELECT, WHERE, ORDER BY, even JOIN conditions

__________________________________________________________________________
-- 4 CASE WHEN vs COALESCE
-- What it does: Shows differences and similarities
-- Why use it: Understand when to use each function
__________________________________________________________________________
-- COALESCE Handles NULLs only:
  SELECT COALESCE(amount, 0) AS clean_amount
  FROM transactions;

-- Expected Result:
  -- clean_amount  200  -50  500  75

-- CASE WHEN Handles arbitrary conditions:
  SELECT CASE
  WHEN amount IS NULL THEN 0
  WHEN amount < 0 THEN -1
  ELSE amount
  END AS adjusted_amount FROM transactions;

-- Expected Result:
  -- adjusted_amount  200  -1  500  75

-- Key Insight:
  -- COALESCE = simple NULL replacement
  -- CASE WHEN = flexible conditional logic

__________________________________________________________________________
-- 5 Common Mistakes
-- What it does: Highlights frequent errors
-- Why use it: Avoid incorrect results
__________________________________________________________________________
-- Mistake Missing ELSE:
  SELECT CASE
  WHEN amount > 100 THEN 'Hight'
  END AS category
  FROM transactions;

-- Problem:
  -- Rows that don't match any condition → NULL

-- Fix ADD ELSE:
  SELECT CASE
  WHEN amount > 100 THEN 'High'
  ELSE 'Low'
  END AS category
  FROM transactions;

-- Another Mistake:
  -- Wrong condition order
  -- Checks should go from most specific → least specific

-- Key insight:
  -- Always plan the order of conditions
  -- ELSE ensures a default value
