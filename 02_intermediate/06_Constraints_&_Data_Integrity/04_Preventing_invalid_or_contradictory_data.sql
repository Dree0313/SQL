__________________________________________________________________________
-- Intermediate SQL: Preventing Invalid or Contradictory Data
-- Purpose: Learn how to enforce rules and maintain logical consistency in
  -- your database
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management notices:

  -- Problems:
    -- Accounts with negative balances where not allowed
    -- Members with conflicting statuses (e.g., "Active" and "Inactive")
    -- Transactions that contradict account rules (e.g., overdraft beyond
    -- limit

  -- Solution:
    -- Use a combination of CHECK constraints, UNIQUE constraints, and
    -- logical table design to prevent invalid or contradictory data

  -- Table: members
    -- member_id (PK)  1       2        3
    -- first_name    Alice    Bob     Carol
    -- status        Active  Active  Inactive

  -- Table: accounts
    -- account_id (PK)  101        102      103      104
    -- member_id (FK)    1          1        2        3
    -- balance          500        1000     200      300

  -- Table: transactions
    -- transaction_id (PK) 1001  1002  1003  1004
    -- account_id (FK)     101   101   102   103
    -- amount              200   -50   500   75

__________________________________________________________________________
-- 1 Why Preventing Contradictory Data Matters
-- What it does: Ensures database values make sense logically
-- Why it's harder: Protects data integrity, prevents business rule
  -- violations
__________________________________________________________________________
-- Problem Without Rules:
  UPDATE members
  SET status = 'Active'
  WHERE member_id = 3; -- ❌ Conflicts with prior "Inactive" assumptions

  INSERT INTO accounts (account_id, member_id, balance)
  VALUES (105, 1, -1000); -- ❌ Negative balance breaks business rules

-- Key Insight:
  -- Data shoulld not contradict business rules; the database should
  -- enforce consistency automatically

__________________________________________________________________________
-- 2 Using CHECK to Enforce Logical Rules
-- What it does: Prevents invalid values in column
-- Why use it: Stops impossible or contradictory data
__________________________________________________________________________
-- Examples Restrict blances to non-negative:
  CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    member_id INT,
    balance INT CHECK (balance >= 0)
  );

-- With CHECK:
  INSERT INTO accounts (account_id, member_id, balance)
  VALUES(105, 1, 500); -- ❌ Rejected by database

-- Key Insight:
  -- CHECK constraints stop bad data before it enters the table

__________________________________________________________________________
-- 3 CHECK with Specific Values
-- What it does: Limits values to a defined set
-- Why use it: Prevents typos and invalid categories
__________________________________________________________________________
-- Example Restrict member status:
  CREATE TABLE members (
    member_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    status VARCHAR(10) CHECk (status IN ('Active', 'Inactive'))
  );

-- Key Insight:
  -- Only "Active" or "Inactive" is allowed

__________________________________________________________________________
-- 4 CHECK in Queries (Understanding Impact)
-- What it does: Ensures all returned data follows rules
-- Why use it: Guarentees reliable query results
__________________________________________________________________________
-- Example Query:
  SELECT account_id, balance
  FROM accounts;

-- Expected Result:
  -- All balances will always be >= 0

-- Key Insight:
  -- You don't need to filter invalid data, it can't exist

__________________________________________________________________________
-- 5 Multiple Conditions in CHECK
-- What it does: Combines multiple rules
-- Why use it: Enforces more complex business logic
__________________________________________________________________________
-- Example:
  CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    amount INT,
    CHECK (amount <> 0 AND amount >= -1000)
  );

-- Key Insight:
  -- amount cannot be 0
  -- amount cannot be less than -10000

__________________________________________________________________________
-- 6 Column-Level vs Table-Level CHECK
-- What it does: Defines where the constraint applies
-- Why use it: Needed for multi-column validation
__________________________________________________________________________
-- Column-Level:
  balance INT CHECK (balance >= 0)

-- Table-Level:
  CHECK (withdrawal_amount <= balance)

-- Key Insight:
  -- Use table-level CHECK when comparing multiple columns

__________________________________________________________________________
-- 7 Common Mistakes
-- What it does: Highlights errors when using CHECK
-- Why use it: Prevents logic and validation issues
__________________________________________________________________________
-- Mistake Using CHECK for relationships:
  -- CHECK cannot replace FOREIGN KEY

-- Mistake Forgetting NULL behavior:
  -- CHECK ignores NULL unless specified

CHECK (amount > 0) -- NULL values still allowed

--Mistake Overcomlicating logic
  -- Keep conditions simple and readable

-- Key Insight:
  -- CHECK is for validation, not relationships

-- Key Insight:
  -- Use table-level CHECK when comparing multiple columns
