__________________________________________________________________________
-- Intermediate SQL: First Normal Form (1NF)
-- Purpose: Learn how to structure tables so data is stored in a clean,
  -- consistent, and non-repeating way
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management notices
  -- inconsistent data and difficulty querying customer information.

  -- Problems:
    -- Multiple values stored in one column
    -- Repeating groups of data
    -- Difficult queries and updates

  -- Solution:
    -- Apply First Normal Form (1NF)

  -- Table: members
    -- member_id     1
    -- first_name  Alice
    -- accounts   101, 102 ❌ multiple values in one column

__________________________________________________________________________
-- 1 What First Normal Form (1NF) Is
-- What it does: Ensures each column contains atomic (single) values
-- Why it's harder: Makes data easier to query and maintain
__________________________________________________________________________
-- Key Rules of 1NF:
  -- No repeating groups
  -- No multiple values in one column
  -- Each field contains only ONE value
  -- Each row can be uniquely identified (PRIMARY KEY)

-- Good Example (1NF Compliant):
  -- member_id     1
  -- first_name  Alice

  -- acount_id  101  102
  -- member_id  1     1

-- Key Insight:
  -- One column = one value only

__________________________________________________________________________
-- 2 Why 1NF Matters
-- What it does: Improves data consistency and query simplicity
-- Why use it: Prevents messy and hard-to-maintain data
__________________________________________________________________________
-- Problem (Not in 1NF):
  -- Hard to search for specific values

-- Example:
  SELECT *
  FROM members
  WHERE accounts LIKE '%101%' -- ❌ inefficient and unreliable

-- With 1NF:
  SELECT *
  FROM accounts
  WHERE account_id = 101;

-- Key Insight:
  -- Clean structure = simple queries

__________________________________________________________________________
-- 3 Eliminating Repeating Groups
-- What it does: Splits repeated data into separate rows
-- Why use it: Prevents duplication and improves flexibility
__________________________________________________________________________
-- Bad Example (Repeating Columns):
  -- member_id  1
  -- account1  101
  -- account2  102

-- Problem:
  -- Limited number of accounts
  -- Hard to scale

-- Good Example (1NF):
  -- account_id  101  102
  -- member_id    1    1

-- Key Insight:
  -- Rows grow, columns stay consistent

__________________________________________________________________________
-- 4 1NF and PRIMARY KEYS
-- What it does: Ensures each row is uniquely identifiable
-- Why use it: Prevents duplicates and confusion
__________________________________________________________________________
-- Example:
  CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    member_id INT,
    account_type VARCHAR(50)
  );

-- Key Insight:
  -- 1NF + PRIMARY KEY = clean, reliable data

__________________________________________________________________________
-- 5 Converting a Table to 1NF
-- What it does: Transforms bad design into proper structure
-- Why use it: Fixes real-world messy data
__________________________________________________________________________
-- Original Table (Not 1 NF):
  -- member_id     1
  -- first_name  Alice
  -- accounts   101, 102

-- Step 1: Remove multiple values
-- Step 2: Create separate table

-- New Tables (1NF):

  -- member_id     1
  -- first_name  Alice

  -- acount_id  101  102
  -- member_id  1     1

-- Key Insight:
  -- Break complex columns into separate rows/tables

__________________________________________________________________________
-- 6 Common Mistakes
-- What it does: Highlights errors when applying 1NF
-- Why use it: Prevents bad database design
__________________________________________________________________________
-- Mistake Storing lists in a column:
  -- Example:
    -- "101, 102, 103"

-- Mistake Using repeating columns:
  -- account1, account2, account3

  -- Fix:
    -- Use separate rows and tables
    -- Ensure atomic values
    -- Always define a PRIMARY KEY

-- Key Insight:
  -- 1NF = atomic data + no repetition
