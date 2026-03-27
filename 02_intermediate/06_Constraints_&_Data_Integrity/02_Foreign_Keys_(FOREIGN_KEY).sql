__________________________________________________________________________
-- Intermediate SQL: Foreign Keys (FOREIGN KEY)
-- Purpose: Learn how to create relationships between tables and eenforce
  -- referential integrity using FOREIGN KEY constraints
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management wants to
  -- ensure that data across tables stays consistent and linked correctly

  -- Problems without Foreign Keys:
    -- Orphan records (e.g., accounts without a valid member)
    -- Broken relationships between tables
    -- Hard to enforce data integrity

  -- Solution:
    -- Use FOREIGH KEY to link tables and enforce relationships

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
-- 1 What a FOREIGN KEY is
-- What it does: Links a column in one table to the PRIMARY KEY of another 
  -- table
-- Why it's harder: Ensures related data exists and maintains integrity
__________________________________________________________________________
-- Key Concept:
  -- A FOREIGN KEY must be:
    -- Reference a valid PRIMARY KEY in another table
    -- Ensure that not invalid value can be inserted

-- Example Table Definition:
  CREATE TABLE accounts (
    account_id INT PRIMARY KEY
    member_id INT,
    account_type VARCHAR(50),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
  );

-- Key Insight:
  -- member_id in accounts must exist in members

__________________________________________________________________________
-- 2 Why FOREIGN KEYs Matter
-- What it does: Prevents orphaned or invalid data
-- Why use it: Keeps tables consistent and trustworthy
__________________________________________________________________________
-- Problem (No FOREIGN KEY):
  -- An account couled reference a member_id that doesn't exist

-- Bad Example:
  -- member_id    1      1
  -- first_name Alice  Alice

-- With PRIMARY KEY:
  -- Database will reject duplicate values

-- Key Insight:
  -- PRIMARY KEY = data protection

__________________________________________________________________________
-- 3 PRIMARY KEY in Queries
-- What it does: Allows precise filtering and joins
-- Why use it: Guarantees accurate results
__________________________________________________________________________
-- Example Find a specific member:
  SELECT *
  FROM members
  WHERE member_id = 1

-- Expected Result:
  -- member_id     1
  -- first_name  Alice
  -- status      Active

-- Key Insight:
  -- PRIMARY KEY ensures only ONE row is returned

__________________________________________________________________________
-- 4 PRIMARY KEY and Relationships (CRITICAL)
-- What it does: Connects tables together
-- Why use it: Enables JOIN operations
__________________________________________________________________________
-- Example members → accounts relationship:
  -- members.member_id (PRIMARY KEY)
  -- accounts.member_id (FOREIGN KEY)

-- Query:
  SELECT m.first_name, a.account_id
  FROM member m
  JOIN accounts a ON m.member_id = a.member_id;

-- Expected Result:
  -- first_name Alice  Alice  Bob  Carol
  -- account_id  101    102   103   104

-- Key Insight:
  -- PRIMARY KEY is referenced by FOREIGN KEY to link tables

__________________________________________________________________________
-- 5 Composite PRIMARY KEY (Advanced)
-- What it does: Uses multiple columns as a unique identifier
-- Why use it: When one column along is not unique
__________________________________________________________________________
-- Example:
  CREATE TABLE account_transactions (
    account_id INT,
    transaction_date DATE,
    amount INT,
    PRIMARY KEY (account_id, transaction_date)
  );

-- Key Insight:
  -- Combination of columns must be unique

__________________________________________________________________________
-- 6 Common Mistakes
-- What it does: Highlights errors when using PRIMARY KEYS
-- Why use it: Prevents data integrity issues
__________________________________________________________________________
-- Mistake Allowing NULL values:
  -- PRIMARY KEY cannot be NULL

-- Mistake Using non_unique values:
  -- Causes errors when inserting data

-- Mistake Not defining a PRIMARY KEY:
  -- Leads to duplicate and unreliable data

-- Mistake Choosing a bad key:
  -- Example:
    -- Using name instead of ID

  -- Fix:
    -- Use stable, unique identifiers (like IDs)

-- Key Insight:
  -- A good PRIMARY KEY is simple, unique, and never changes
