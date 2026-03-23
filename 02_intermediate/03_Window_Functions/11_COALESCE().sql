__________________________________________________________________________
-- Intermediate SQL: COALESCE() (Handling NULL Values)
-- Purpose: Learn how to replace NULL values to prevent errors and ensure
  -- clean, usable results in queries
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management wants
  -- clean and reliable reports:

  -- Replace missing values in calculations
  -- Prevent NULL from breaking math operations
  -- Ensure reports always show meaningful numbers
  -- Maintain row-level detail while handling missing data

  -- You must handle NULL valuees properly

  -- Table: transactions
    -- transaction_id (PK) 1001         1002     1003         1004
    -- account_id (FK)      101         101       102          103
    -- amount               200         -50       500           75
    -- transaction_date  2026-01-10  2026-01-12 2026-01-05  2026-01-07
__________________________________________________________________________
-- 1️ What COALESCE() Does
-- What it does: Returns the first NON-NULL value in a list
-- Why use it: Replaces missing (NULL) values
__________________________________________________________________________
-- Important Concept:
  -- Evaluates values  from left → right
  -- Stops at the first non-NULL value
  -- Works with multiple inputs

-- Think of it like:
  -- "If this is NULL, use something else"

-- Example:
  SELECT COALESCE(NULL, NULL, 100, 200) AS result;

--Expected Result:
  -- result  100

-- Key Insight:
  -- First non-NULL value is returned

__________________________________________________________________________
-- 2 COALESCE() in Real Data
-- What it does: Replaces NULL values in a column
-- Why use it: Makes output readable and usable
__________________________________________________________________________
-- Example:
  SELECT transaction_date, amount, COALESCE(amount, 0) AS clean_amount
  FROM transactions;

-- Expected Result:
  -- transaction_date  2026-01-10  2026-01-12  2026-01-05  2026-01-07
  -- amount               200         -50          500         75
  -- clean_amount         200         -50          500         75

-- Key Insight:
  -- If amount were NULL → replaced with 0

__________________________________________________________________________
-- 3 COALESCE() with Window Functions (CRITICAL)
-- What it does: Fixes NULL results from LAG() / LEAD()
-- Why use it: Prevents NULL from breaking calculations
__________________________________________________________________________
-- Problem:
  -- LAG() and LEAD() produce NULL at edges

-- Solution:
  SELECT transaction_date, amount, amount - COALESCE(LAG(amount) OVER (
    ORDER BY transaction_date), 0) AS change
  FROM transactions;

-- Expected Result:
  -- transaction_date  2026-01-05  2026-01-07  2026-01-10  2026-01-12
  -- amount                500        75         200          -50
  -- change                500       -425        125          -250

-- Key Insight:
  -- First row no longer NULL → uses 0 instead

__________________________________________________________________________
-- 4 COALESCE() vs CASE WHEN
-- What it does: Shows alternative approach
-- Why use it: Understand simpler syntax
__________________________________________________________________________
-- Using Case:
  SELECT CASE
      WHEN amount IS NULL THEN 0
      ELSE amount
    END AS clean_amount
  FROM transactions;

-- Using COALESCE:
  SELECT COALESCE(amount, 0) AS clean_amount
  FROM transactions;

-- Expected Result:
  -- clean_amount  200  -50  500  75

-- Key Insight:
  -- COALESCE = shorter and cleaner

__________________________________________________________________________
-- 5 COALESCE() with Multiple Fallbacks
-- What it does: Provides multiple backup values
-- Why use it: Handles complex missing data scenarios
__________________________________________________________________________
-- Example Running Total:
  SELECT COALESCE(NULL, NULL, amount, 0) AS value
  FROM transactions;

-- Expected Result:
  -- value  200  -50  500  75

-- Key insight:
  -- Tries each value until it finds a non-NULL

__________________________________________________________________________
-- 6 Common Mistakes
-- What it does: Highlights frequent errors
-- Why use it: Avoids incorrect results
__________________________________________________________________________
-- Mistake:
  amount + NULL

-- Problem:
  -- Result = NULL (NULL breaks math)

-- Fix:
  amount + COALESCE(NULL, 0)

-- Another Mistake:
  COALESCE(amount)

-- Problem:
  -- Requires at least 2 arguments
    
-- Key Insight:
  -- Always provide a fallback value
