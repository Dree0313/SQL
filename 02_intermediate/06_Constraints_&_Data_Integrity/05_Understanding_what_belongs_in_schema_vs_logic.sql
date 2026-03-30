__________________________________________________________________________
-- Intermediate SQL: Schema vs Logic (Where Rules Belong)
-- Purpose: Learn what rules should be enforced in the database schema vs
  -- what should be handled in application/business logic
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management notices
  -- inconsistent behavior across systems:

  -- Problems:
    -- Some rules are enforced in the database, others only in the app
    -- Different apps allow different data (inconsistent results)
    -- Complex logic inside the database becomes hard to maintain

  -- Solution:
    -- Clearly separate:
      -- Schema-level rules (data integrity)
      -- Application logic (business behavior)

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
-- 1 What Belongs in the Schema
-- What it does: Enforces data integrity at the database level
-- Why it's harder: Protects data no matter how it's inserted
__________________________________________________________________________
-- Schema Rules Should Be:
  -- Simple
  -- Universal (always true)
  -- Non-negotiable

-- Examples:
  CREATE TABLE members (
    member_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    status VARCHAR(10) CHECK (status IN ('Active', 'Inactive'))
  );

  CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    member_id INT REFERENCES members(member_id),
    balance INT CHECK (balance >= 0)
  );

-- Key Insight:
  -- If a rule should NEVER be broken → it belongs in the schema

__________________________________________________________________________
-- 2 What Belongs in Application Logic
-- What it does: Handles complex, conditional, or changing rules
-- Why use it: Keeps database simple and flexible
__________________________________________________________________________
-- Logic Rules Are:
  -- Conditional
  -- Business-specific
  -- Likely to change

-- Example Business Rule:
  -- "Premium members can overdraft up to -500"
  -- "Standard members cannot overdraft"

-- NOT ideal for schema:
  -- Too complex
  -- Depends on multiple tables
  -- Changes over time

-- instead (pseudo logic):
  IF member_type = 'Premium' THEN
    allow balance >= -500
  ELSE
    allow balance <= 0

-- Key Insight:
  -- If a rule depends on context or changes → it belongs in logic

__________________________________________________________________________
-- 3 Schema vs Logic (Side-by-Side)
-- What it does: Clarifies decision-making
-- Why use it: Prevents overloading the database
__________________________________________________________________________
-- Schema (Database):
  -- PRIMARY KEY (unique IDs)
  -- FOREIGN KEY (relationships)
  -- CHECK (simple validation)
  -- UNIQUE (no duplicates)

-- Logic (Application):
    -- Conditional permissions
    -- Role-based rules
    -- Time-based behavior
    -- Multi-step workflows

-- Example Schema:
  CHECK (amount <> 0)

-- Logic:
  -- "Block withdrawls on weekends"

-- Key Insight:
  -- Schema = Truth
  -- Logic = Behavior

__________________________________________________________________________
-- 4 When NOT to Use Schema Constraints
-- What it does: Prevents overengineering
-- Why use it: Keeps database maintainable
__________________________________________________________________________
-- Bad Example (Too Complex):
  CHECK (
    amount <= (
      SELECT balance
      FROM accounts
      WHERE accounts.account_id = transactions.account_id
    )
  );

-- Problems:
  -- Hard to read
  -- Not supported in many DBMS
  -- Difficult to maintain

-- Better:
-- Enforce in application logic before INSERT

-- Key Insight:
  -- Don't force complex business rules into schema

__________________________________________________________________________
-- 5 Hybrid Approach (Best Practice)
-- What it does: Combines schema + logic effectively
-- Why use it: Maximizes data integrity and flexibility
__________________________________________________________________________
-- Schema Handles:
  -- Required fields
  -- Valid formats
  -- Basic limits

-- Logic Handles:
  -- Advanced rules
  -- Exceptions
  -- User-specific behavior

-- Example Schema:
  CHECK (amount <> 0)

-- Logic:
  -- "Prevent withdrawals if balance would go below allowed limit"

-- Key Insight:
  -- Using schema as a safety net, logic as a decision engine
__________________________________________________________________________
-- 6 Common Mistakes
-- What it does: Highlights improper separation
-- Why use it: Avoids broken or messy systems
__________________________________________________________________________
-- Mistake Putting everying in the chema:
  -- Leads to complex, unreadable SQL

-- Mistake Putting everything in logic:
  -- Allows bad data into the database

-- Mistake Duplicating rules in both:
  -- Hardcoded rules become outdated

-- Key Insight:
  -- Balance is key:
    -- Schemma protects data
    -- Logic constrols behavior
