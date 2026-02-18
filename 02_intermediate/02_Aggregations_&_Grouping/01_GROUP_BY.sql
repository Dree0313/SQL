__________________________________________________________________________
-- Intermediate SQL: GROUP BY
-- Purpose: Learn how relationships between tables affect the number of
  -- rows returned in JOIN queries
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management notices
  -- that some JOIN queries return more rows than expected. You must
  -- understand JOIN cardinality, how many rows related between tables.

  -- Cardinality describes the relationship between tables:
    -- One-to-One (1:1)
    -- One-to-Many (1:N)
    -- Many-to-Many (M:N)

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
-- 1️ One-to-One Relationship (1:1)
-- What it does: One row in Table A matches ONE row in Table B
-- Why use it: Splits data for organization or security
__________________________________________________________________________
-- Explanation:
  -- If each member had exactly ONE profile record

-- Result:
  -- 1 member → 1 profile
  -- No row multiplication happens in the JOIN

__________________________________________________________________________
-- 2 One-to-Many Relationship (1:N)
-- What it does: One row in Table A matches MULTIPLE rows in Table B
-- Why use it: Most common database relationship
__________________________________________________________________________
-- Problem:
  -- Management wants members and their accounts
  -- One member can have many accounts

-- Solution:
  SELECT m.member_id, m.first_name, a.account_id
    FROM members m
    INNER JOIN accounts a ON m.member_id = a.member_id;

-- Expected Result:
  -- member_id        1         1        2         3
  -- first_name     Alice     Alice     Bob      Carol
  -- account_id      101       102      103       104

__________________________________________________________________________
-- 3 Multiplication Effect (1:N:N)
-- What it does: Shows how joins can multiply rows
-- Why use it: Prevents confusion when row counts increase
__________________________________________________________________________
-- Problem: 
  -- Management wants members and transactions
  -- One member → many accounts
  -- One member → many transactions

-- Solution: 
  SELECT m.first_name, a.account_id, t.transaction_id
    FROM members m
    INNER JOIN accounts a ON m.members_id = a.members_id
    INNER JOIN transactions t ON a.account_id = t.account_id;

-- Expected Result:
  -- first_name      Alice  Alice  Alice  Bob
  -- account_id      101    102    103    104
  -- transaction_id  1001   1002   1003   1004

__________________________________________________________________________
-- 4 Many-to-Many Relationship (M:N)
-- What it does: Both tables can have multiple matches
-- Why use it: Requires a junction (bridge) table
__________________________________________________________________________
-- Example:
  -- If members could share accounts

  -- You would need a bridge table like:
    -- memberr_accounts
    -- member_id
    -- account_id

  -- This prevents duplicate or inconsistent data

__________________________________________________________________________
-- 5 Why Join Cardinality Matters
-- What it does: Explains unexpected row counts
-- Why use it: Helps debug JOIN queries
__________________________________________________________________________
-- Example: 
  -- If a JOIN returns "too many rows," ask:
    -- Is this a 1:N relationship?
    -- Are rows multiplying across multiple joins?
    -- Am I missing a grouping condition?

  SELECT m.first_name, COUNT(t.transaction_id) AS transactions_count)
    FROM members m
    INNER JOIN accounts a ON m.members_id = a.members_id
    INNER JOIN transactions t ON a.account_id = t.account_id
    GROUP BY m.first_name;

-- Expected Result:
  -- first_name        Alice  Bob
  -- transactions_count  3     1
