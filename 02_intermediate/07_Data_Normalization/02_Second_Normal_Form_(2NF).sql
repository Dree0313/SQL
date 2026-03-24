__________________________________________________________________________
-- Intermediate SQL: Second Normal Form (2NF)
-- Purpose: Learn how to organize tables so that all non-key columns
  -- depend fully on the PRIMARY KEY, eliminating partial dependencies
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. After applying 1NF,
  -- tables are clean, but you notice some columns depend only on part of
  -- a composite key, causing redundant data and update anomalies.

  -- Problems:
    -- Partial dependencies in tables with composite keys
    -- Repetition of data across multiple rows
    -- Difficult to maintiain consistency

  -- Solution:
    -- Apply Second Normal Form (2NF) to remove partial dependencies

  -- Table: account_transactions (Not 2NF)
    -- account_id           101         101
    -- transaction_date  2026-01-10  2026-01-12
    -- account_type       checking    checking
    -- amount               200         -50

__________________________________________________________________________
-- 1 What Second Normal Form (2NF) Is
-- What it does: Ensures that non-key columns depend on the ENTIRE PRIMARY
  -- KEY
-- Why it's harder: Eliminates redundant data and prevents anomalies
__________________________________________________________________________
-- Key Rules of 2NF:
  -- Must already be in 1NF
  -- All non-key columns fully depend on the whole primary key
  -- Remove columns that depend on only part of a composite key

-- Bad Example (Violates 2NF):
  -- PRIMARY KEY (account_id, transaction_date)
  -- account_type depends only on account_id ❌ partial dependency

-- Good Example (2NF Compliant):
  -- Table: accounts
    -- account_id (PK)  101      102
    -- account_type   checking  savings

  -- Table: transactions
    -- account_id                101         101
    -- transaction_date (PK)  2026-01-10  2020-01-12
    -- amount                    200         -50

-- Key Insight:
  -- Non-key columns now depend fully on the entire key, not just part

__________________________________________________________________________
-- 2 Why 2NF Matters
-- What it does: Removes redundancy and makes updates easier
-- Why use it: Avoids anomalies when data changes
__________________________________________________________________________
-- Problem (Not in 2NF):
  -- Changing account_type requires updating multiple rows

-- Example:
  UPDATE account_transactions
  SET account_type = 'savings'
  WHERE account_id = 101; -- ❌ must update multiple rows in the orginal

-- With 2NF:
  UPDATE account_transactions
  SET account_type = 'savings'
  WHERE account_id = 101; -- only one row changes

-- Key Insight:
  -- Updates are simpler, consistent, and less error-prone

__________________________________________________________________________
-- 3 Splitting Tables to Achieve 2NF
-- What it does: Separates data into multiple related tables
-- Why use it: Eliminates partial dependencies and redundancy
__________________________________________________________________________
-- Original Table (Not 2NF):
  -- account_id           101         101
  -- transaction_date  2026-01-10  2026-01-12
  -- account_type       checking    checking
  -- amount               200         -50

-- Step 1: Move account_type to accounts table
-- Step 2: Keep only transaction-specific data in transactions table

-- New Tables (2NF):
  -- Table: accounts
    -- account_id (PK)  101      102
    -- account_type   checking  savings

  -- Table: transactions
    -- account_id                101         101
    -- transaction_date (PK)  2026-01-10  2020-01-12
    -- amount                    200         -50

-- Key Insight:
  -- Each table has columns fully dependent on its primary key

__________________________________________________________________________
-- 4 2NF and Relationships
-- What it does: Ensures tables are clean and connected properly
-- Why use it: Supports accurate joins and queries
__________________________________________________________________________
-- Example Query:
  SELECT a.account_id, a.account_type, t.transaction_date, t.amount
  FROM accounts a
  JOIN transactions t ON a.account_id = t.account_id;

-- Expected Result:
  -- account_id            101        101
  -- account_type       checking    checking
  -- transaction_date  2026-01-10  2026-01-12
  -- amount                200        -50

-- Key Insight:
  -- Data is no longer repeated unnecessarily

__________________________________________________________________________
-- 5 Common Mistakes in 2NF
-- What it does: Highlights errors when normalizing
-- Why use it: Prevents redundancy and update anomalies
__________________________________________________________________________
-- Mistake Keeping columns that depend on part of a composite key:
  -- Example:
    -- account_type in account_transactions

-- Mistake Not splitting tables
  -- Leads to redundant data

  -- Fix:
    -- Move partially dependent columns to a separate table
    -- Keep each table focused on a single entity

-- Key Insight:
  -- 2NF = fully functional dependency on the PRIMARY KEY
