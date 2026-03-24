__________________________________________________________________________
-- Intermediate SQL: Primary Keys (PRIMARY KEY)
-- Purpose: Learn how to uniquely identify each row in a table and enforce
  -- data integrity using PRIMARY KEY constraints
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management needs
  -- accurate and reliable data across all systems:

  -- Problems without Primary Keys:
    -- Duplicate records
    -- Difficulty identifying specific rows
    -- Broken relationships between tables

  -- Solution:
    -- Use PRIMARY KEY to uniquely identify each record

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
-- 1 What a PRIMARY KEY is
-- What it does: Uniquely identifies each row in a table
-- Why it's harder: Prevents duplicates and ensures data integrity
__________________________________________________________________________
-- Key Concept:
  -- A PRIMARY KEY must be:
    -- UNIQUE (no duplicates)
    -- NOT NULL (must always have a value)

-- Example Table Definition:
  CREATE TABLE members (
    member_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    status VARCHAR(20)
  );

-- Key Insight:
  -- Each member_id must be unique (no two rows can share it)

__________________________________________________________________________
-- 2 WHY PRIMARY KEYs Matter
-- What it does: Ensures each row can be reliably identified
-- Why use it: Prevents data issues and enables relationships
__________________________________________________________________________
-- Problem No Primary Key:
  -- Duplicate rows can exist

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
-- What it does: Highlights erros when using PRIMARY KEYS
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
