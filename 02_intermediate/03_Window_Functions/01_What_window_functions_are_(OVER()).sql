__________________________________________________________________________
-- Intermediate SQL: What Window Functions Are (OVER())
-- Purpose: Learn how to calculate values across related rows WITHOUT
  -- collapsing them like GROUP BY
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management wants
  -- detailed transaction reports, BUT also wants calculated insights:

    -- Running balance per account
    -- Total transaction per account (without losing rows)
    -- Ranking transactions by amount
    -- Comparing each transaction to account totals

  -- Unlike GROUP BY, you must KEEP all transaction rows while still
  -- calculating summary values.

  -- Table: transactions
    -- transaction_id (PK) 1001         1002     1003         1004
    -- account_id (FK)      101         101       102          103
    -- amount               200         -50       500           75
    -- transaction_date  2026-01-10  2026-01-12 2026-01-05  2026-01-07
__________________________________________________________________________
-- 1️ What OVER() Does
-- What it does: Turns an aggregate into a window function
-- Why use it: Allows calculations across rows WITHOUT grouping them
__________________________________________________________________________
-- Important Concept:
  -- GROUP BY collapses rows → fewer rows returned
  -- OVER() keeps rows → adds calculated columns

-- Example:
  SELECT account_id, amount, SUM(amount) OVER() AS total_all_transactions
  FROM transactions;

-- Expected Result:
  -- account_id              101  101  102  103
  -- amount                  200  -50  500  75
  -- total_all_transactions  725  725  725  725

-- Every row remains
-- SUM() is calculated across ALL rows

__________________________________________________________________________
-- 2 OVER() with PARTITION BY (Group WITHOUT collapsing)
-- What it does: Groups rows logically, but keeps all rows visible
-- Why use it: Calculates per-group values without GROUP BY
__________________________________________________________________________
-- Problem:
  -- Management wants total transactions per account BUT still see each
  -- transaction

-- Example:
  SELECT account_id, amount, SUM(amount) OVER (
    PARTITION BY account_id) AS account_total
  FROM transactions;

-- Expected Result:
  -- account_id     101  101  102  103
  -- amount         200  -50  500  75
  -- account_total  150  150  500  75

-- Key insight:
  -- PARTITION BY = "GROUP BY but keep rows"

__________________________________________________________________________
-- 3 OVER() with ORDER BY (Running Calculations)
-- What it does: Orders rows within a partition for step-by-step calcs
-- Why use it: Creates running totals, balances, rankings
__________________________________________________________________________
-- Problem: 
  -- Management wants a running balance per account

-- Solution: 
  SELECT account_id, transaction_date, amount, SUM(amount) OVER (
    PARTITION BY account_id 
    ORDER BY transaction_date) AS running_balance
  FROM transactions;

-- Expected Result:
  -- account_id       101         101
  -- date          2026-01-10  2026-01-12
  -- amount           200         -50
  -- running_balance  200         150

-- The balance updates row-by-row

__________________________________________________________________________
-- 4 Difference Between GROUP BY and OVER()
-- What it does: Shows the key conceptual difference
-- Why use it: Prevents incorrect query design
__________________________________________________________________________
-- GROUP BY version:
    SELECT account_id, SUM (amount)
    FROM transactions
    GROUP BY account_id;

-- Expected Result:
  --  account_id   101  102  103
  --  SUM(amount)  150  500  75

-- OVER() version:
  SELECT acccount_id, amount, SUM(amount) OVER (PARTITION BY account_id)
  FROM transactions;

-- Expected Result:
  -- account_id   101  101  102  103
  -- amount       200  -50  500  75
  -- SUM(amount)  150  150  500  75

-- Key Insight:
  -- GROUP BY → reduces rows
  -- OVER() → keeps rows + adds insight

__________________________________________________________________________
-- 5 Combining Window Functions with Other Columns
-- What it does: Adds analytics alongside raw data
-- Why use it: Creates powerful reporting queries
__________________________________________________________________________
-- Problem:
  Select account_id, amount, SUM(amount) OVER (
    PARTITION BY account_id) AS total_per_account, 
    amount * 1.0 / SUM(amount) OVER (
    PARTITION BY account_id) AS percent_of_total
  FROM transactions;

-- Expected Result:
  -- account_id  101   101   102   103
  -- amount      200   -50   500   75
  -- total       150   150   500   75
  -- percent    1.33  -0.33  1.00  1.00

__________________________________________________________________________
-- 6 Exectuion Insight (Very Important)
-- What it does: Explains when window functions run
-- Why use it: Prevents confusion in query logic
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
  -- Window functions run AFTER joins and filtering
  -- But BEFORE final ORDER BY
  -- That is why:
    -- You can use aggregates inside OVER()
    -- But you cannot use window functions inside WHERE
