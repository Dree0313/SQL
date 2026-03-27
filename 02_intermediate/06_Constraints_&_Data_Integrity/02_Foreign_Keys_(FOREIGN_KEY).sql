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
  -- An account could reference a member_id that doesn't exist

-- Example:
  INSERT INTO accounts (account_id, member_id, account_type)
  VALUES(105, 999, 'Checking'); -- ❌ 999 does not exist in members

-- With FOREIGN KEY:
  INSERT INTO accounts (account_id, member_id, account_type)
  VALUES(105, 999, 'Checking'); -- ❌ Database rejects it

-- With PRIMARY KEY:
  -- Database will reject duplicate values

-- Key Insight:
  -- FOREIGN KEY enforces valid relationships automatically

__________________________________________________________________________
-- 3 FOREIGN KEY in Queries
-- What it does: Enables JOINs between related tables
-- Why use it: Guarantees accurate queries using relationships
__________________________________________________________________________
-- Example Query Find accounts with member names:
  SELECT a.account_id, a.account_type, m.first_name
  FROM account a
  JOIN members m ON a.member_id = m.member_id;

-- Expected Result:
  -- account_id      101       102       103      104
  -- account_type  Checking  Savings  Checking  Savings
  -- first_name     Alice     Alice      Bob     Carol

-- Key Insight:
  -- FOREIGN KEY ensures JOINs are reliable and consistent

__________________________________________________________________________
-- 4 Cascading Actions (Optional)
-- What it does: Automatically updates or deletes related records
-- Why use it: Prevents broken relationships and maintains integrity
__________________________________________________________________________
-- Example:
  CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    member_id INT,
    account_type VARCHAR(50),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
  );

-- Key Insight:
  -- Deleting a member automatically deletes their accounts
  -- Updating a member_id updates all linked accounts

__________________________________________________________________________
-- 5 Composite FOREIGN KEY (Advanced)
-- What it does: Links multiple columns to a PRIMARY KEY in another table
-- Why use it: When a single column is not sufficient to enforce the 
  -- relationship
__________________________________________________________________________
-- Example:
  CREATE TABLE account_transactions (
    account_id INT,
    transaction_date DATE,
    amount INT,
    PRIMARY KEY (account_id, transaction_date),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
  );

-- Key Insight:
  -- The account_id in transactions must exist in accounts

__________________________________________________________________________
-- 6 Common Mistakes
-- What it does: Highlights errors when using FOREIGN KEYS
-- Why use it: Prevents integrity and relational issues
__________________________________________________________________________
-- Mistake Referencing a non existing column or table:
  -- FOREIGN KEY must reference an existing PRIMARY KEY

-- Mistake Not defining a FOREIGN KEY:
  -- Leads to orphan records and broken relationships

-- Mistake Using cascading actions without caution:
  -- May unintentionally delete or update data

-- Key Insight:
  -- A good FOREIGN KEY ensures correct, consistent relationships between 
  -- tables
