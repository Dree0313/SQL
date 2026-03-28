__________________________________________________________________________
-- Intermediate SQL: CHECK Constraints (CHECK)
-- Purpose: Learn how to enforce rules on column values using CHECK
  -- constraints
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management wants to
  -- ensure that values entered into the database follow strict business
  -- rules

  -- Problems without CHECK Constraints:
    -- Invalid data (e.g., negative balances where not allowed)
    -- Incorrect status values (e.g., "Active" instead of "Active")
    -- Hard to maintain data accuracy

  -- Solution:
    -- Use CHECK constraints to enforce rules directly in the database

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
-- 1 What a CHECK Constraint is
-- What it does: Restricts values in a column based on a condition
-- Why it's harder: Prevents invalid or unwanted data
__________________________________________________________________________
-- Key Concept:
  -- A CHECK constraint must evaluate to TRUE for data to be inserted

-- Example Table Definition:
  CREATE TABLE accounts (
    account_id INT PRIMARY KEY
    member_id INT,
    balance INT CHECK (balance >= 0)
  );

-- Key Insight:
  -- balance cannot be negative

__________________________________________________________________________
-- 2 Why CHECK Constraints Matter
-- What it does: Enforces business rules automatically
-- Why use it: Keeps data clean and consistent
__________________________________________________________________________
-- Problem (No CHECK):
  INSERT INTO accounts (account_id, memeber_id, balance)
  VALUES (105, 1, -500); -- ❌ Invalid but allowed without CHECK

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
