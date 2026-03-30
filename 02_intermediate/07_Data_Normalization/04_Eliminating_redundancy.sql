__________________________________________________________________________
-- Intermediate SQL: Eliminating Redundancy (Normalization Basics)
-- Purpose: Learn how to remove duplicate and repeated data by structuring
  -- tables efficently and separating data into logical entities
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Over time, the 
  -- database has grown messy with repeated and duplicated data across
  -- tables

  -- Problems:
    -- Same data stored in multiple places
    -- Updates require changing multiple rows
    -- High risk of inconsistencies
    -- Wasted storage space

  -- Solution:
    -- Eliminate redundancy by organizing data into separate, related 
    -- tables

  -- Table: accounts (Redundant Design ❌)
    -- account_id    101      102     103
    -- member_id      1        1       2
    -- member_name  Alice    Alice    Bob
    -- branch_name Downtown Downtown Uptown

__________________________________________________________________________
-- 1 What Redundancy Is
-- What it does: Repeats the same data across multiple rows or tables
-- Why it's harder: Wastes space and causes inconsistencies
__________________________________________________________________________
-- Example Redundant Data:
  -- member_name repeated for each amount
  -- branch_name repeated for each amount

-- Problem:
  UPDATE accounts
  SET branch_name = 'Central'
  WHERE account_id = 101; -- ❌ only updates one row 

-- Now data is inconsistent:
  -- account_id 101 → Central
  -- account_id 102 → Downtown ❌

-- Key Insight:
  -- Redundant data leads to update anomalies and inconsistencies

__________________________________________________________________________
-- 2 Why Eliminating Redundancy Matters
-- What it does: Keeps data consistent and easier to maintain
-- Why use it: Prevents update, insert, and delete anomalies
__________________________________________________________________________
-- Types of Problems:
  -- Update Anomaly:
    -- Must update the same data in multiple places

  -- Insert Anomally:
    -- Cannot add a branch unless an account exists

  -- Delete Anomally:
    -- Deleting last account removes branch info entirely

-- Key Insight:
  -- Redundancy makes databases fragile and error-prone

__________________________________________________________________________
-- 3 Splitting Tables to Remove Redundancy
-- What it does: Separates repeated data into its own table
-- Why use it: Stores each piece of data only once
__________________________________________________________________________
-- Step 1 Identify repeated data:
  -- member_name → belongs to members table
  -- branch_name → belongs to branches table

-- Step 2 Create separate tables:
  CREATE TABLE members (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(50)
  );

  CREATE TABLE branches (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(50)
  );

  CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    member_id INT,
    branch_id INT
  );

-- Key Insight:
  -- Each fact is stored only once, reducing duplication

__________________________________________________________________________
-- 4 Using Relationships Instead of Repetition
-- What it does: Links tables using keys instead of duplicating data
-- Why use it: Maintains consistency across the database
__________________________________________________________________________
-- Example Relationships:
  -- accounts.member_id → member.member_id
  -- accounts.branch_id → branches.branch_id

-- Query:
  SELECT a.account_id, m.member_name, b.branch_name
  FROM accounts a
  JOIN members m ON a.member_id = m.member_id
  JOIN branches b ON a.branch_id = b.branch_id;

-- Expected Result:
  -- accout_id      101       102      103
  -- member_name   Alice     Alice     Bob
  -- branch_name  Downtown  Downtown  Uptown

-- Key Insight:
  -- Relationships replace redundancy with clean connections

__________________________________________________________________________
-- 5 Before vs After (Clear Comparison)
-- What it does: Shows impact of eliminating redundancy
-- Why use it: Reinforces understanding
__________________________________________________________________________
-- BEFORE (Redundant ❌):
  -- account_id     101       102
  -- member_name   Alice     Alice
  -- branch_name  Downtown  Downtown

-- AFTER (Normalized ✅):
  -- memeber:
    -- member_id      1
    -- member_name  Alice

  -- branches:
    -- brance_id        1
    -- branche_name  Downtown

  -- accounts:
    -- account_id  101  102
    -- member_id    1    1
    -- branche_id   1    1

-- Key Insight:
  -- Data is stored oncce and referenced everywhere else

__________________________________________________________________________
-- 5 Common Mistakes
-- What it does: Highlights errors when removing redundancy
-- Why use it: Avoids poor database design
__________________________________________________________________________
-- Mistake Over-normalizing:
  -- Splitting data too much, making queries overly complex

-- Mistake Under normalizing:
  -- Leaving repeated data in tables

-- Mistake Not using FOREIGN KEY relationships:
  -- Leads to disconnected or inconsistent data

-- Mistake Storing derived data:
  -- storing account_total when it can be calculated

-- Fix:
  -- Compute values instead of storing duplicates

-- Key Insight:
  -- Good design balances simplicity and efficiency while maximizing
  -- redundancy
