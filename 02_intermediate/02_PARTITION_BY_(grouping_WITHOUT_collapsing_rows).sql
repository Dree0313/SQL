__________________________________________________________________________
-- Intermediate SQL: PARTITION BY (Grouping WITHOUT Collapsing Rows)
-- Purpose: Learn how to logically group rows while still keeping every
  -- row visible using window functions
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management wants
  -- detailed transaction data, but also wants insights per account:

    -- Total transactions per account
    -- Compare each transaction to its account total
    -- Analyze account activity without losing individual rows

  -- You cannot GROUP BY because that would remove transaction detail.

  -- Table: transactions
    -- transaction_id (PK) 1001         1002     1003         1004
    -- account_id (FK)      101         101       102          103
    -- amount               200         -50       500           75
    -- transaction_date  2026-01-10  2026-01-12 2026-01-05  2026-01-07
__________________________________________________________________________
-- 1️ What PARTITION BY Does
-- What it does: Divides rows into groups (partitions)
-- Why use it: Allows calculations per group WITHOUT collapsing rows
__________________________________________________________________________
-- Important Concept:
  -- PARTITION BY creates logical groups inside OVER()
  -- Each group is calculated separately
  -- BUT all rows are still returned

-- Think of it like:
  -- GROUP BY → splits data and collapses rows
  -- PARTITION BY → splits data but keeps all rows

__________________________________________________________________________
-- 2 Basic PARTITION BY Example
-- What it does: Calculates totals per account without GROUP BY
-- Why use it: Keeps transaction-level detail
__________________________________________________________________________
-- Problem:
  -- Management wants total transactions per account AND each transaction

-- Solution:
  SELECT account_id, amount, SUM(amount) OVER (
    PARTITION BY account_id) AS account_total
  FROM transactions;

-- Expected Result:
  -- account_id     101  101  102  103
  -- amount         200  -50  500  75
  -- account_total  150  150  500  75

-- Key insight:
  -- The SUM resets for each account
  -- But rows are NOT grouped together

__________________________________________________________________________
-- 3 PARTITION BY vs No PARTITION
-- What it does: Shows how grouping changes results
-- Why use it: Prevents incorrect logic
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

