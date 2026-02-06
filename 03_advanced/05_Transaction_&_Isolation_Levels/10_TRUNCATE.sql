_________________________________________________________________________________________________
-- Intermediate SQL: TRUNCATE
-- Purpose: Learn how to quickly remove all rows from a table safely and intentionally

-- Scenerio:
  -- You are working on a production-like database with large tables. Management needs the data
  -- cleared for testing, reloads, or resets without changing the table structure. You must
  -- understand when TRUNCATE is appropriate vs dangerous.
_________________________________________________________________________________________________

_________________________________________________________________________________________________
-- 1 What TRUNCATE does
-- What it does: Removes ALL rows from a table instantly
-- Why use it: Much faster than DELETE for large tables
-- Key idea: TRUNCATE is a DDL operation, not DML
_________________________________________________________________________________________________
-- Removes all records
  TRUNCATE TABLE employees;

-- Table still exists
-- Columns, constraints, indexes remain

_________________________________________________________________________________________________
-- 2 TRUNCATE vs DELETE (core distinction)
-- What it does: Highlights behavior differences
-- Why use it: Prevents accidental data loss
_________________________________________________________________________________________________
-- DELETE
  DELETE FROM employees;
-- Can be rolled back (if in transaction)
-- Fires triggers
-- Respects WHERE clause
-- Slower on large tables

--TRUNCATE
  TRUNCATE TABLE employees;
-- Cannot be rolled back (most DBs)
-- Does NOT fire triggers
-- No WHERE clause allowed
-- Resets identity counters
-- Extremely fast
_________________________________________________________________________________________________
-- 3 Identity / Auto-increment behavior
-- What it does: Resets primary key counters
-- Why use it: Useful for clean test environment
_________________________________________________________________________________________________
-- Example
-- Before TRUNCATE:
  -- IDs: 101, 102, 103

  TRUNCATE TABLE orders;

-- After TRUNCATE:
  -- First new row ID resets to 1 (or base seed)
_________________________________________________________________________________________________
-- 4 Foreign key restrictions
-- What it does: Prevents truncating referenced tables
-- Why use it: Protects relational integrity
_________________________________________________________________________________________________
 -- This will FAIL if another table references employees
  TRUNCATE TABLE employees;

-- You must:
  -- 1. Truncate child tables first
  -- OR
  -- 2. Drop foreign key constraints
  -- OR
  -- 3. Use DELETE instead

_________________________________________________________________________________________________
-- 5 Transation behavior
-- What it does: Shows why TRUNCATE is dangerous in prod
-- Why use it: Forces intentional, irreversible actions
_________________________________________________________________________________________________
  BEGIN TRANSACTION;
  TRUNCATE TABLE logs;
  ROLLBACK; -- Does NOT undo truncate in most DBs

  -- Data is permanently gone
_________________________________________________________________________________________________
-- 6 When you SHOULD use TRUNCATE
-- What it does: Establishes safe use cases
-- Why use it: Performance + clarity
_________________________________________________________________________________________________
-- Good use cases:
  -- Resetting test date
  -- Clearing staging tables
  -- Reloading batch datasets
  -- Non-production environments

_________________________________________________________________________________________________
-- 7 When you should NOT use TRUNCATE
-- What it does: Prevents catastrophic mistakes
-- Why use it: Protects real data
_________________________________________________________________________________________________
-- Avoid when:
  -- You need a WHERE clause
  -- You need rollback safety
  -- Triggers must fire
  -- Foreign key dependencies exist
  -- You are unsure of table contents

_________________________________________________________________________________________________
-- 8 Practice exercise (DO NOT RUN IN PROD)
-- What it does: Builds muscle memory
-- Why use it: Reinforces intention
_________________________________________________________________________________________________
-- Step 1: Verify row count
  SELECT COUNT(*) FROM audit_logs;

-- Step 2: Confirm environment
  -- (Are you in dev/test?)

-- Step 3: Truncate
  TRUNCATE TABLE audit_logs;

-- Step 4: Confirm empty
  SELECT COUNT(*) FROM audit_logs;
