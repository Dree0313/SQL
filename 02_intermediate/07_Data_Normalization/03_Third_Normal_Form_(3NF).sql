__________________________________________________________________________
-- Intermediate SQL: Third Normal Form (3NF)
-- Purpose: Learn how to structure tables so that non-key columns are not
  -- transitively dependent on the primary key, reducing redundancy
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. After applying 2NF,
  -- tables are free from partial dependencies, but some non-key columns
  -- still depend on other non-key columns, causing indirect dependencies.

  -- Problems:
    -- Transitive dependencies (non-key columns depending on other non-key
      -- columns)
    -- Redundant data across multiple rows
    -- Difficult updates and inconsistencies

  -- Solution:
    -- Apply Third Normal Form (3NF) to remove transitive dependencies

  -- Table: transactions (Not 3NF)
    -- transaction_id     1001         1002
    -- account_id          101         101
    -- account_type     checking     checking
    -- branch_address  123 Main St  123 Main St
    -- amount              200         -50

__________________________________________________________________________
-- 1 What Third Normal Form (3NF) Is
-- What it does: Ensures that all non-key columns depend only on the 
  -- PRIMARY KEY
-- Why it's harder: Eliminates transitive dependencies and redundancy
__________________________________________________________________________
-- Key Rules of 3NF:
  -- Must already be in 2NF
  -- No non-key column should depend on another non-key column
  -- Every non-key column depends directly on the primary key

-- Bad Example (Violates 3NF):
  -- transactions_id (PK)
  -- account_type depends on account_id ❌
  -- branch_address depends on account_id ❌

-- Good Example (2NF Compliant):
  -- Table: accounts
    -- account_id (PK)  101
    -- account_type   checking
    -- branch_id         1

  -- Table: branches
    -- branch_id (PK)       1
    -- branch_address  123 Main St

  -- Table: transactions
    -- transaction_id  1001  1002
    -- account_id       101   101
    -- amount           200   -50

-- Key Insight:
  -- Non-key columns now depend only on the primary key of their table

__________________________________________________________________________
-- 2 Why 3NF Matters
-- What it does: Reduces redundancy and simplifies updates
-- Why use it: Prevents anomalies caused by indirect dependencies
__________________________________________________________________________
-- Problem (Not in 3NF):
  -- Updating branch address requires changing multiple rows in 
  -- transactions

-- Example:
  UPDATE transactions
  SET branch_address = '456 Elm St'
  WHERE account_id = 101; -- ❌ must update multiple rows in the orginal

-- With 3NF:
  UPDATE branches
  SET branch_address = '456 Elm St'
  WHERE branch_id = 1; -- only one row changes

-- Key Insight:
  -- 3NF ensures updates are simple consistent, and less error-prone

__________________________________________________________________________
-- 3 Splitting Tables to Achieve 3NF
-- What it does: Separates data into logical entities
-- Why use it: Removes transitive dependencies and redundancy
__________________________________________________________________________
-- Original Table (Not 3NF):
  -- transaction_id      1001        1002
  -- account_id           101         101
  -- account_type       checking    checking
  -- branch_address  123 Maint St  123 Main St
  -- amount               200         -50

-- Step 1: Move account_type and branch_address to accounts/branches
-- Step 2: Keep only transaction-specific data in transactions

-- New Tables (3NF):
  -- Table: accounts
    -- account_id (PK)  101
    -- account_type   checking
    -- branch_id         1

  -- Table: branches
    -- branch_id (PK)       1
    -- branch_address  123 Main St

  -- Table: transactions
    -- transaction_id  1001  1002
    -- account_id       101   101
    -- amount           200   -50

-- Key Insight:
  -- Each table now contains only data that depends directly on its key

__________________________________________________________________________
-- 4 3NF and Relationships
-- What it does: Creates clean, logical connections between tables
-- Why use it: Supports accurate joins and reporting
__________________________________________________________________________
-- Example Query:
  SELECT t.transaction_id, a.account_type, b.branch_address, t.amount
  FROM transactions t
  JOIN accounts a ON t.account_id = a.account_id
  JOIN branches b ON a.branch_id = b.branch_id;

-- Expected Result:
  -- transaction_id     1001         1002
  -- account_type     checking     checking
  -- branch_address  123 Main St  123 Main St
  -- amount             200          -50

-- Key Insight:
  -- No repeated data; all joins are based on primary keys

__________________________________________________________________________
-- 5 Common Mistakes in 3NF
-- What it does: Highlights errors when normalizing
-- Why use it: Prevents redundancy and update anomalies
__________________________________________________________________________
-- Mistake Keeping columns that depend on other non-key columns:
  -- Example:
    -- branch_address in transactions

-- Mistake Not splitting tables properly
  -- Leads to repeated and inconsistent data

  -- Fix:
    -- Move transitively dependent columns to separate tables
    -- Keep each table focused on a single entity

-- Key Insight:
  -- 3NF = each non-key column depends only on the primary key
