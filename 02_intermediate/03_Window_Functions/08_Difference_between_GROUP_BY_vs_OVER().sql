__________________________________________________________________________
-- Intermediate SQL: GROUP BY vs OVER() (Aggregation vs Window Functions)
-- Purpose: Learn the difference between summarizing data vs analyzing 
  -- data while keeping row-level detail
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management wants
  -- both summary reports AND detailed transaction insights:

  -- Total balance per amount
  -- See each transaction AND its account total
  -- Compare individual transactions to overall totals
  -- Maintain row-level detail while showing aggregates

  -- You must understand WHEN to collapse rows and WHEN to keep them

  -- Table: transactions
    -- transaction_id (PK) 1001         1002     1003         1004
    -- account_id (FK)      101         101       102          103
    -- amount               200         -50       500           75
    -- transaction_date  2026-01-10  2026-01-12 2026-01-05  2026-01-07
__________________________________________________________________________
-- 1️ What GROUP BY Does
-- What it does: Aggregates data and collapses rows into groups
-- Why use it: Creates summary-level insights
__________________________________________________________________________
-- Important Concept:
  -- GROUP BY reduces the number of rows
  -- One result per group
  -- Cannot access individual row detail after grouping

-- Think of it like:
  -- "Summarize everything into one result per category"

-- Example:
  SELECT account_id, SUM(amount) AS total_balance
  FROM transactions
  GROUP BY account_id;

--Expected Result:
  -- account_id     101  102  103
  -- total_balance  150  500  75

-- Key Insight:
  -- Multiple rows → ONE row per account

__________________________________________________________________________
-- 2 What OVER() Does (Window Functions)
-- What it does: Performs calculations WITHOUT collapsing rows
-- Why use it: Adds insights while keeeping full detail
__________________________________________________________________________
-- Important Concept:
  -- Uses OVER() instead of GROUP BY
  -- Keeps ALL original rows
  -- Adds calculated columns

-- Think of it like:
  -- "Show the total, but keep every transaction"

-- Solution:
  SELECT account_id, transaction_date, amount, SUM(amount) OVER (
    PARTITION BY account_id ) AS total_balance
  FROM transactions;

-- Expected Result:
  -- account_id     101         101         102        103
  -- date       2026-01-10  2026-01-12  2026-01-05  2026-01-07
  -- amount         200         -50         500         75
  -- total_balance  150         150         500         75

-- Key Insight:
  -- Same total repeated per row → no data loss

__________________________________________________________________________
-- 3 Key Difference (CRITICAL)
-- What it does: Direct comparison of behavior
-- Why use it: Prevents major SQL mistakes
__________________________________________________________________________
-- GROUP BY: 
  -- Collapses rows
  -- Removes detail
  -- One row per group

-- OVER():
  -- Keeeps rows
  -- Adds calculations
  -- Works across rows

-- Example Comparison:

-- GROUP  BY:
  SELECT account_id, SUM(amount)
  FROM transactions
  GROUP BY account_id;

-- OVER():
  SELECT account_id, transaction_datee, amount,
    SUM(amount) OVER (PARTITION BY account_id)
  FROM transactions;

-- Key Insight:
  -- GROUP BY = summary table
  -- OVER() = enriched dataset

__________________________________________________________________________
-- 4 Combining GROUP BY and OVER() (Advanced Insight)
-- What it does: Shows how both can be used together
-- Why use it: Enables layered analysis
__________________________________________________________________________
-- Example:
  SELECT account_id, amount, SUM(amount) OVER () AS overall_total
  FROM transactions;

-- Or using a subquery:
  SELECT account_id, total_balance, total_balance / SUM(total_balance) 
    OVER () AS percent_of total
  FROM
    (SELECT account_id, SUM(amount) AS total_balance
    FROM transactions
    GROUP BY account_id) AS t;
    
-- Key Insight:
  -- GROUP BY can create summaries
  -- OVER() can analyze those summaries

__________________________________________________________________________
-- 5 Common Mistake
-- What it does: Highlights frequent confusion
-- Why use it: Avoid incorrect results
__________________________________________________________________________
-- Mistake:
  SELECT account_id, SUM(amount)
  FROM transactions;

-- Problem:
  -- Missing GROUP BY → error

-- Another Mistake:
  SUM(amount) OVER ()

-- Problem:
  -- No PARTITION BY → calculates over ALL rows

-- Key insight:
  -- GROUP BY defines groups
  -- OVER() defines calculation scope

