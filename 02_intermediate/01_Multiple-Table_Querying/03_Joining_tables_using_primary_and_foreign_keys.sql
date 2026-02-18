__________________________________________________________________________
-- Intermediate SQL: Joining Tables Using Primary and Foreign Keys
-- Purpose: Learn how tables are connected using primary keys (PK) and 
  -- foreign keys (FK) to maintain relational integrity
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management needs
  -- reports that connect members to their accounts and transactions. The
  -- data is stored in separate tables, but they are related using primary
  -- and foreign keys.

  -- Primary Key (PK): A unique identifier in a table
  -- Foreign Key (FK): A column that references a primary key in another
    -- table

  -- Table: members
    -- member_id (PK)  1       2        3
    -- first_name    Alice    Bob     Carol
    -- status        Active  Active  Inactive

  -- Table: accounts
    -- account_id (PK)  101      102       103      104
    -- member_id (FK)    1        1         2        3
    -- account_type   Checking  Savings  Checking  Savings

  -- Table: transactions
    -- transaction_id (PK) 1001  1002  1003  1004
    -- account_id (FK)     101   101   102   103
    -- amount              200   -50   500   75
__________________________________________________________________________
-- 1️ Understanding Primary and Foreign Keys
-- What it does: Defines relationships between tables
-- Why use it: Prevents orphaned data and enforces integrity
__________________________________________________________________________
-- Explanation:
  -- members.member_id is a PRIMARY KEY
  -- accounts.member_id is a FOREIGN KEY referencing members.member_id
  -- accounts.account_id is the PRIMARY KEY
  -- transactions.account_id is the FOREIGN KEY referencing 
    -- accounts.account_id

  -- This creates a relationship chain:
    -- members → accounts → transactions

__________________________________________________________________________
-- 2 Joining Using a Primary and Foreign Key
-- What it does: Connects related data across tables
-- Why use it: Produces meaningful business reports
__________________________________________________________________________
-- Problem:
  -- Management wants a list of members and their accounts

-- Solution:
  SELECT m.member_id, m.first_name, a.account_id, a.account_type
    FROM members m
    INNER JOIN accounts a ON m.member_id = a.member_id;

-- Expected Result:
  -- member_id        1         1        2         3
  -- first_name     Alice     Alice     Bob      Carol
  -- account_id      101       102      103       104
  -- account_type  Checking  Savings  Checking  Savings

  -- The JOIN works because the FK matches the PK

__________________________________________________________________________
-- 3 Joining Through Mulitple Foreign Keys
-- What it does: Connects three related tables
-- Why use it: Tracks data across full relationship chains
__________________________________________________________________________
-- Problem: 
  -- Management wants members and their transactions

-- Solution: 
  SELECT m.first_name, a.account_id, t.transaction_id, t.amount
    FROM members m
    INNER JOIN accounts a ON m.members_id = a.members_id
    INNER JOIN transactions t ON a.account_id = t.account_id;

-- Expected Result:
  -- first_name      Alice  Alice  Alice  Bob
  -- account_id      101    102    103    104
  -- transaction_id  1001   1002   1003   1004
  -- amount          200    -50    500    75

__________________________________________________________________________
-- 4 Why Primary and Foreign Keys Matter
-- What it does: Enforces valid relationships
-- Why use it: Prevents invalid or unmatched data
__________________________________________________________________________
-- Example:
  -- You cannot insert into accounts with member_id = 99 if 99 does not 
  -- exist in members

  -- The database enforces relational rules automatically


      AND d.department_name = 'IT';
