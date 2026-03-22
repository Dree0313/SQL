__________________________________________________________________________
-- Intermediate SQL: RANK() (Handling Ties in Ranking)
-- Purpose: Learn how to assign rankings to rows where equal values share
  -- the same rank (used for leaderboards, comparisons, analytics)
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management wants
  -- ranking and insights that correctly handle ties:

  -- Rank transactions by amount (with ties)
  -- Identify top-performing transactions
  -- Compare transactions fairly when values are equal
  -- Under ranking gaps

  -- You must ranke rows WITHOUT collapsing data and while handling ties
    -- correctly

  -- Table: transactions
    -- transaction_id (PK) 1001         1002     1003         1004
    -- account_id (FK)      101         101       102          103
    -- amount               200         -50       500           75
    -- transaction_date  2026-01-10  2026-01-12 2026-01-05  2026-01-07
__________________________________________________________________________
-- 1️ What RANK() Does
-- What it does: Assigns a rank to rows, allowing ties
-- Why use it: Ensures equal values receive the same ranking
__________________________________________________________________________
-- Important Concept:
  -- RANK() requires ORDER BY
  -- Equal values → same rank
  -- Skips numbers after ties

-- Think of it like:
  -- "Give equal performers the same position, even if it creates gaps"

-- Example:
  SELECT account_id, amount, RANK() OVER (
    ORDER BY amount DESC) AS rank_num
  FROM transactions;

--Expected Result:
  -- account_id  102  101  103  101
  -- amount      500  200  75  -50
  -- row_num      1    2    3    4

-- Key Insight:
  -- Ranking is based on value order

__________________________________________________________________________
-- 2 RANK() with Ties (Important Behavior)
-- What it does: Demonstrates how ties affect ranking
-- Why use it: Prevents misunderstanding in real datasets
__________________________________________________________________________
-- If amounts were:
  -- 500, 200, 200, 75

-- Query:
  SELECT amount, RANK() OVER (ORDER BY amount DESC) AS rank_num
  FROM transactions;

-- Expected Result:
  -- amount         500        200          200         75
  -- rank            1          2            2          4

-- Key insight:
  -- Rank 3 is skipped because of the tie

__________________________________________________________________________
-- 3 RANK() with PARTITION BY (Per-Group Ranking)
-- What it does: Ranks rows within each group separately
-- Why use it: Compare values within categories (accounts)
__________________________________________________________________________
-- Problem: 
  -- Management wants to rank transactions per account

-- Solution (using CTE): 
  SELECT account_id, amount, RANK() OVER (
    PARTITION BY account_id ORDER BY amount DESC) AS rank_num
  FROM transactions;

-- Expected Result:
  -- account_id  101  101  102  103
  -- amount      200  -50  500  75
  -- rank         1    2    1    1

-- Key Insight:
  -- Ranking resets for each amount

__________________________________________________________________________
-- 4 RANK() vs ROW_NUMBER()
-- What it does: Highlights key difference
-- Why use it: Prevents incorrect ranking choice
__________________________________________________________________________
-- If amount were:
  -- 500, 200, 200, 75

-- ROW_NUMBER():
  -- 1, 2, 3, 4

-- RANK():
  -- 1, 2, 2, 4

-- Key Insight:
  -- ROW_NUMBER() → always unique
  -- RANK() → allows ties, skips numbers

__________________________________________________________________________
-- 5 Top-N with Ties Using RANK()
-- What it does: Retrieves top values including ties
-- Why use it: Common business requirement
__________________________________________________________________________
-- Problem:
  -- Get top 2 transactions by amount, including ties

-- Solution:
  WITH ranked AS (SELECT account_id, amount, RANK() OVER (
      ORDER BY amount DESC) AS rank_num
    FROM transactions)
  SELECT *
  FROM ranked
  WHERE rank_num <= 2;

-- Expected Result (if ties exist):
  -- amount  500  200  200
  -- rank     1    2    2

-- Key insight:
  -- RANK() includes all tied values within cutoff
