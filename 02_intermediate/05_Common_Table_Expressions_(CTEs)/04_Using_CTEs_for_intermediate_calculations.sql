__________________________________________________________________________
-- Intermediate SQL: Using CTEs for Intermediate Calculations
-- Purpose: Learn how to use CTEs (WITH clauses) to store intermediate
  -- results so you can build complex queries step-by-step
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management wants
  -- insights that require multiple layers of calculations:

  -- Total transactions per account
  -- Total per member
  -- Cmparisons and filtering based on those totals

  -- instead of calculating everything at once, you will store
  -- intermediate results using CTEs

  -- Table: members
    -- member_id (PK)  1       2        3
    -- first_name    Alice    Bob     Carol
    -- status        Active  Active  Inactive

  -- Table: accounts
    -- account_id (PK)  101        102      103      104
    -- member_id (FK)    1          1        2        3
    -- account_type    Checking  Savings  Checking  Savings

  -- Table: transactions
    -- transaction_id (PK) 1001  1002  1003  1004
    -- account_id (FK)     101   101   102   103
    -- amount              200   -50   500   75

__________________________________________________________________________
-- 1 What Intermediate Calculations Are
-- What it does: Stores partial results for later use
-- Why it's harder: Simplifies complex queries and avoids repeating logic
__________________________________________________________________________
-- Key Concept:
  -- Break a big problem into smaller calculations
  -- Store each step in a CTE
  -- Reuse results in later steps

-- Think of it like:
  -- "Calculate once, reuse many times"

-- Example:
  WITH step1 AS (
    SELECT account_id, SUM(amount) AS total
    FROM transactions
    GROUP BY account_id
  )
  SELECT *
  FROM step1;

-- Expected Result:
  -- account_id  101  102  103
  -- total       150  500  75

-- Key Insight:
  -- This result can now be reused in other calculations

__________________________________________________________________________
-- 2 Using CTE for Account-Level Calculations
-- What it does: Calculates totals per account
-- Why use it: Creates a reusable intermediate dataset
__________________________________________________________________________
-- Problem:
  -- Management wants you to calculate total transaction per account

-- Solution:
  WITH account_totals AS (  
    SELECT account_id, SUM(amount) AS total
    FROM transactions
    GROUP BY account_id
  )
  SELECT *
  FROM account_totals;

-- Expected Result:
  -- account_id  101  102  103
  -- total       150  500  75

-- Key Insight:
  -- This avoids recalculating SUM(amount) multiple times

__________________________________________________________________________
-- 3 Use Intermediate Results for Member Totals
-- What it does: Builds on previous calculation
-- Why use it: Demonstrates step-by-step logic
__________________________________________________________________________
-- Problem:
  -- Management wants you to calculate total transactions per member

-- Solution:
  WITH account_totals AS (
    SELECT account_id, SUM(amount) AS total
    FROM transactions
    GROUP BY account_id
  ),
  member_totals AS (
    SELECT a.member_id, SUM(at.total) AS total_amount
    FROM accounts a
    JOIN account_totals at ON a.account_id = at.account_id
    GROUP BY a.member_id
  )
  SELECT *
  FROM member_totals;

-- Expected Result:
  -- member_id      1    2   3
  -- total_amount  150  500  75

-- Key Insight:
  -- Each step builds on the previous one

__________________________________________________________________________
-- 4 Using Intermediate Results for Comparisons
-- What it does: Uses stored results for business logic
-- Why use it: Keeps logic clean and separated
__________________________________________________________________________
-- Problem:
  -- Management wants you to find members whose totals are above average

-- Solution:
  WITH account_totals AS (
    SELECT account_id, SUM(amount) AS total
    FROM transactions
    GROUP BY account_id
  ),
  member_totals AS (
    SELECT a.member_id, SUM(at.total) AS total_amount
    FROM accounts a
    JOIN account_totals at ON a.account_id = at.account_id
    GROUP BY a.member_id
  ),
  avg_total AS (
    SELECT AVG(total_amount) AS avg_value
    FROM member_totals
  )
  SELECT *
  FROM member_totals
  WHERE total_amount > (SELECT avg_value FROM avg_total);

-- Expected Result:
  -- member_id      2
  -- total_amount  500

-- Key Insight:
  -- Intermediate results make comparisons simple

__________________________________________________________________________
-- 5 Reusing Intermediate Calculations
-- What it does: Using the same calculation multiple times
-- Why use it: Avoids duplication and improves performance
__________________________________________________________________________
-- Example:
  WITH account_totals AS (
    SELECT account_id, SUM(amount) AS total
    FROM transactions
    GROUP BY account_id
  )
  SELECT
  account_id,
  total,
  total * 0.1 AS bonus,
  total + 50 AS adjusted_total
  FROM account_totals;

-- Expected Result:
  -- account_id  101  102  103
  -- total  150  500  75
  -- bonus  15  50  7.5
  -- adjusted 200 550 125

-- Key Insight:
  -- One calculation → multiple uses

__________________________________________________________________________
-- 6 Common Mistakes
-- What it does: Highlights erros when using intermediate calculations
-- Why use it: Prevents incorrect results
__________________________________________________________________________
-- Mistake Skipping intermediate steps:
  -- Leads to complex, unreadable queries

-- Mistake Repeating calculations:
  -- Wastes performance and increases bugs

-- Mistake Not naming CTEs clearly:
  -- Confusing for others

  -- Fix:
    -- Use clear names like account_totals, member_totals

-- Key Insight:
  -- Intermediate steps = clarity + maintainability

