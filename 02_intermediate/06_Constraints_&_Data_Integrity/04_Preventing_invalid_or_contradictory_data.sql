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

-- Restrict member status to valid values:
  CREATE TABLE members (
    member_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    status VARCHAR(10) CHECK (status IN ('Active', 'Inactive'))
  );

-- Prevent invalid transactions:
  CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    amount INT,
    CHECK (amount <> 0 AND amount >= -1000)
  );

-- Key Insight:
  -- CHECK constraints enforce logical consistency directly in the 
  -- database
__________________________________________________________________________
-- 3 Using UNIQUE to Prevent Contradictions
-- What it does: Stops duplicate or conflicting records
-- Why use it: Ensures unique data where duplicates would create 
  -- contradictions
__________________________________________________________________________
-- Example Prevent duplicate member emails:
  ALTER TABLE members
  ADD CONSTRAINT unique_email UNIQUE (email);

-- Key Insight:
  -- UNIQUE prevents two members from having the same identifier that
  -- could cause contradictions

__________________________________________________________________________
-- 4 Combining CHECK and FOREIGN KEY
-- What it does: Prevents invalid references and contradictory logic 
  -- across tables
-- Why use it: Keeps multi-table data consistent
__________________________________________________________________________
-- Example Transactions cannot exceed balance:
  CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT REFERENCES accounts(account_id),
    amount INT,
    CHECK (amount <= (SELECT balance FROM accounts WHERE accounts.account_id = account_id))
  );

-- Key Insight:
  -- Complex rules can be enforced with CHECK + FOREIGN KEY together
  -- (depending on DBMS support)

__________________________________________________________________________
-- 5 Table-Level Constraints for Cross-Column Logic
-- What it does: Prevents contradictory data involving multiple columms
-- Why use it: Enforces relational rules within a single row
__________________________________________________________________________
-- Example:
  CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    balance INT,
    withdrawal_amount INT,
    CHECK (withdrawal_amount <= balance)
  );

-- Key Insight:
  -- Table-level constraints allow multi-column validation that 
  -- column-level CHECK cannot enforce alone

__________________________________________________________________________
-- 6 Common Mistakes
-- What it does: Highlights pitfalls when preventing invalid data
-- Why use it: Avoids inconsistent, unreliable databases
__________________________________________________________________________
-- Mistake Ignoring NULL values:
  -- CHECK ignores NULL unless explicitly handled

-- Mistake Overcomplicating logic:
  -- Keep constraints readable and maintainable

-- Mistake Relying only on application logic:
  -- Data may still be inserted incorrectly without DE constraints

-- Mistake Using constraints for things better handled for FOREIGN KEY:
  -- CHECK cannot enforce relationships between tables

-- Key Insight:
  -- Combine PRIMARY KEY, FOREIGN KEY, UNIQUE, and CHECK to prevent
  -- invalid or contradictory data

