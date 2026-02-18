__________________________________________________________________________
-- Intermediate SQL: Understanding GROUP BY
-- Purpose: Learn how to group rows and calculate summaries using
  -- aggregate functions
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management does not
  -- want to see every individual transaction. Insteaed, they want
  -- summarized reports such as total balances, transaction counts, and
  -- averages per member or per account

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
-- 1️ What GROUP BY Does
-- What it does: Groups rows that share the same column value
-- Why use it: Allows aggregate calculations on grouped data
__________________________________________________________________________
-- Example:
  -- Without GROUP BY
    SELECT amount FROM transaction;

  -- Result:
    -- amount  200  -50  500  75

 -- With GROUP BY:
  SELECT account_id, SUM(amount) AS total_amount
    FROM transactions
    GROUP BY account_id;

  -- Result:
    -- account_id    101  102  103
    -- total_amount  150  500  75

    -- Transactions were grouped by account_id
    -- Then SUM() was calculated per group

__________________________________________________________________________
-- 2 Aggregate Functions Used with GROUP BY
-- What it does: Performs calculations per group
-- Why use it: Creates meaningful summary reports
__________________________________________________________________________
-- Common Aggregate Functions:
  -- COUNT() → Counts rows
  -- SUM() → Adds values
  -- AVG() → Calculates averages
  -- MIN() → Smallest value
  -- MAX() → Largest value

-- Example:
  SELECT account_id, COUNT(transaction_id) AS transaction_count
    FROM transactions
    GROUP BY account_id;

-- Expected Result:
  -- account_id        101  102  103
  -- transaction_count  2    1    1

__________________________________________________________________________
-- 3 GROUP BY with JOIN
-- What it does: Groups data across related tables
-- Why use it: Produces business-level reporting
__________________________________________________________________________
-- Problem: 
  -- Management wants total transaction amount per member

-- Solution: 
  SELECT m.first_name, SUM(t.amount) AS total_transactions
    FROM members m
    INNER JOIN accounts a ON m.members_id = a.members_id
    INNER JOIN transactions t ON a.account_id = t.account_id
    GROUP BY m.first_name;

-- Expected Result:
  -- first_name         Alice  Bob
  -- totatl_transactions 650   75

__________________________________________________________________________
-- 4 Important GROUP BY Rule
-- What it does: Enforces grouping consistency
-- Why use it: Prevents SQL errors
__________________________________________________________________________
-- Rule:
  -- Every column in SELECT must either:
    -- Be inside an aggregate function
    -- OR appear in the GROUP BY clause

-- Example:
  -- Incorrect:
    SELECT first_name, account_id, SUM(amount)
      FROM transactions
      GROUP BY first_name;

    -- This causes an error beecause account_id is not grouped or 
    -- aggregated

  -- Correct:
    SELECT account_id, SUM(amount)
      FROM transactions
      GROUP BY account_id;

__________________________________________________________________________
-- 5 Using HAVING with GROUP BY
-- What it does: Filters grouped results
-- Why use it: Filters AFTER aggregation
__________________________________________________________________________
-- Problem:
  -- Management only wants accounts with total transactions over 100

-- Solution:
  SELECT account_id, SUM(amount) AS total_amount
    FROM transactionse
    GROUP BY account_id
    HAVING SUM(amount) > 100;

-- Expected Result:
  -- account_id    101  102
  -- total_amount  150  500

  -- WHERE filters rows BEFORE grouping
  -- HAVING filters groups AFTER grouping
