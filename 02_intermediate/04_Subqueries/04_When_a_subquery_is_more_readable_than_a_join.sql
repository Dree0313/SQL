__________________________________________________________________________
-- Intermediate SQL: When a Subquery is More Readable Than a JOIN
-- Purpose: Learn when subqueries provide clearer, more intuitive logic
  -- compared to JOIN + GROUP BY
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management wants
  -- reports that are easy to understand and maintain. 

  -- Sometimes JOINs can become complex, especially when:
    -- You only need a single calculated value per row
    -- You want to avoid GROUP BY complexity
    -- You want logic that reads like plain English

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
-- 1️ Subquery for Simple Per-Row Calculations
-- What it does: Calculates a value per row without GROUP BY
-- Why use it: Easier to read when logic is "per row"
__________________________________________________________________________
-- Problem:
  -- Management wants each member and their total transactions

-- Solution:
  SELECT m.member_id, m.first_name 
    (SELECT SUM (t.amount)
      FROM accounts a
      INNER JOIN transactions t ON a.account_id = t.account_id
      WHERE a.member_id = m.member_id) AS total_amount
    FROM members m;

-- Expected Result:
  -- member_id      1    2      3
  -- first_name   Alice  Bob  Carol
  -- total_amount  650   75    NULL

-- Why is this readable:
-- Reads like: "For each member, calculatee total transactions"
__________________________________________________________________________
-- 2 JOIN + GROUP BY Version (Less Readable for This Case)
-- What it does: Archieves the same result using joins
-- Why it's harder: Requires grouping or more syntax
__________________________________________________________________________
-- Example:
  SELECT m.member_id, m.first_name, SUM(t.amount) AS total_amount
    FROM members m
    INNER JOIN accounts a ON m.member_id = a.member_id
    INNER JOIN transactions t ON a.account_id = t.account_id
    GROUP BY m.member_id, m.first_name;

-- Why is this less readable:
  -- Requires GROUP BY
  -- Harder to understand at a glance
  -- More moveing parts
__________________________________________________________________________
-- 3 Subqueries for Filtering (Cleaner Logic)
-- What it does: Filters using natural, readable conditions
-- Why use it: Reads like a business rule
__________________________________________________________________________
-- Problem:
-- Managment wants members with total transactions > 500

-- Solution:
  SELECT m.member_id, m.first_name
    FROM members m
    WHERE
      (SELECT SUM(t.amount)
        FROM accounts a
        INNER JOIN transactions t ON a.account_id = t.account_id
        WHERE a.member_id = m.member_id) > 500;

-- Expected Results:
  -- member_id   1
  -- first_name Alice

-- Why this is readable:
  -- "Where total transactions > 500"
  -- Very close to plain English
__________________________________________________________________________
-- 4 When JOIN is Better
-- What it does: Shows when NOT to use subqueries
-- Why use it: Avoid performance and repetition issues
__________________________________________________________________________
-- Problem:
  -- Large dataset, need totals for ALL members

-- Better with JOIN:
  SELECT m.member_id, SUM(t.amount) AS total_amount
    FROM members m
    INNER JOIN accounts a ON m.member_id = a.member_id
    INNER JOIN transactions t ON a.account_id = t.account_id
    GROUP BY m.member_id;o

-- Why JOIN is better here:
  -- More efficient for large data
  -- Avoids repeated subquery execution
  -- Better for reporting

__________________________________________________________________________
-- 5 Readability vs Performance Tradeoff
-- What it does: Helps choose the right approach
-- Why use it: Real-world decision making
__________________________________________________________________________
-- Use Subquery  Per-row calculation  Simple logic  Readability priority
-- Use JOIN  Large datasets  Aggregated reports
