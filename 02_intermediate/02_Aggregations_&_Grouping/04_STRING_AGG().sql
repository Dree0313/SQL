__________________________________________________________________________
-- Intermediate SQL: STRING_AGG()
-- Purpose: Learn how to combine text from multiple rows into a single 
  -- string
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management wants
  -- reports that list related items in a single row:

    -- All account types per member
    -- Transaction IDs per account
    -- Emails or phone numbers for each customer as a comma-separated
      -- list

  -- The data is stored across related tables and must be joined before
  -- aggregation.

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
-- 1️ Why STRING_AGG() Matters
-- What it does: Combines multiple text values into a single string
-- Why use it: Makes multi-row data easier to read and report
__________________________________________________________________________
-- Problem Without STRING_AGG():
  -- Management wants all account types per member

-- Using regular JOIN + GROUP BY only gives you multiple rows:
  SELECT m.first_name, a.account_type
  FROM memebers m
  INNER JOIN accounts a ON m.member_id = a.member_id;

-- Expected result:
  -- first_name     Alice     Alice     Bob      Carol
  -- account_type  Checking  Savings  Checking  Savings

-- Key Insight:
  -- Multiplle rows make reports messy; you need a single row per member

__________________________________________________________________________
-- 2 Basic STRING_AGG() Usage
-- What it does: Concatenates values per group
-- Why use it: Produces a clean, single-row-per-group result
__________________________________________________________________________
-- Example All account types per member (comma-separated):
  SELECT m.first_name, STRING_AGG(a.account_type, ',') AS account_types
  FROM members m
  INNER JOIN accounts a ON m.member_id = a.member_id
  GROUP BY m.first_name;

-- Expected Result:
  -- first_name           Alice          Bob      Carol
  -- account_types  Checking, Savings  Checking  Savings

  -- Key Insight:
    -- STRING_AGG(column, separator) lets you control the delimiter

__________________________________________________________________________
-- 3 Using STRING_AGG() With ORDER BY
-- What it does: Orders concatenated values within the string
-- Why use it: Improves readability in reports
__________________________________________________________________________
-- Example Account types alphabetically per member: 
  SELECT m.first_name, STRING_AGG(a.account_type, ',' 
    ORDER BY a.account_type) AS account_types
  FROM members m
  INNER JOIN accounts a ON m.member_id = a.member_id
  GROUP BY m.first_name;

-- Expected Result:
  -- first_name          Alice
  -- account_type  Checking, Savings --(alphabetically)

-- Key Insight:
  -- ORDER BY inside STRING_AGG() ensures predictable order

__________________________________________________________________________
-- 4 STRING_AGG() With LEFT JOIN
-- What it does: Includes members who may have no accounts
-- Why use it: Produces complete reporting without missing rows
__________________________________________________________________________
-- Example:
  SELECT m.first_name, COALESCE(
    STRING_AGG(a.account_type, ','), 'No accounts') AS account_types
  FROM members m
  LEFT JOIN accounts a ON m.member_id = a.member_id
  GROUP BY m.first_name;

-- Expected Result:
  -- first_name           Alice         Bob      Carol
  -- account_type  Checking, Savings  Checking  Savings -- (or "No accounts" if Carol had none)

-- Key Insight:
  -- COALESCE handles NULL from missing matches

__________________________________________________________________________
-- 5 Combining STRING_AGG() With Other Aggregates
-- What it does: Allows multiple summaries in one query
-- Why use it: Reports can include both text lists and numeric aggregates
__________________________________________________________________________
-- Example List accounts and total transactions per member:
  Select m.first_name, STRING_AGG(a.account_type, ',') AS account_types,
    SUM(t.amount) AS total_transactions
  FROM members m
  INNER JOIN accounts a ON m.member_id = a.member_id
  INNER JOIN transactions t ON a.account_id = t.account_id
  GROUP BY m.first_name;

-- Expected result
  -- first_name         Alice           Bob
  -- account_type  Checking, Savings  Checking
  -- total_transactions  650             75

-- Key Insight:
  -- STRING_AGG() works seamlessly alongside SUM(), COUNT(), etc.

__________________________________________________________________________
-- 6 Common Mistakes
-- What it does: Highlights pitfalls with STRING_AGG()
-- Why use it: Avoid logic errors and messy reports
__________________________________________________________________________
-- Mistake 1 Forgetting GROUP BY:
  -- STRING_AGG() requires grouping; otherwise SQL errors

-- Mistake 2 Not handling NULLs:
  -- Missing values may produce NULL instead of a usable string

-- Mistake 3 Ignoring order:
  -- Without ORDER BY, concatenated values may appear in random order

-- Key Insight:
  -- STRING_AGG() is a grouped aggregate like SUM() or COUNT()
  -- Always consider GROUP BY, NULLs, and ordering
