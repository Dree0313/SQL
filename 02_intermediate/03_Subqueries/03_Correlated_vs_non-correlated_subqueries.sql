__________________________________________________________________________
-- Intermediate SQL: Correlated vs Non-Correlated Subqueries
-- Purpose: Learn the difference between subqueries that depend on the
  -- outer query vs those that don't, and how to use each filtering or 
  -- calculations
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management wants to
  -- filter or compare data:

    -- Members with total transactions over $500
    -- Accounts with more than 2 transactions
    -- Members whose total transactions exceed the **average transaction
      -- of all members**

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
-- 1️ What is a Correlated Subquery?
-- What it does: References a column from the outer query
-- Why use it: Calculates values per row of the outer query
__________________________________________________________________________
-- Problem:
  -- Management wants members with total transactions over 500

-- Solution:
  SELECT m.member_id, m.first_name 
    FROM members m
    WHERE
      (SELECT SUM (t.amount)
        FROM accounts a
        INNER JOIN transactions t ON a.account_id = t.account_id
        WHERE a.member_id = m.member_id) > 500;

-- Expected Result:
  -- member_id      1
  -- first_name   Alice

-- Subquery depends on m.member_id → runs once per member
-- This is a correlated subquery
__________________________________________________________________________
-- 2 What is a Non-Correlated Subquery?
-- What it does: Runs independently of the outer query
-- Why use it: Provides a static value for comparison or filter
__________________________________________________________________________
-- Problem:
  -- Management wants members whose total transactions exceed average of
  -- all

-- Solution:
  SELECT m.member_id, m.first_name
    FROM members m
    WHERE
      (SELECT AVG (total_amount)
        FROM 
          (SELECT SUM(t.amount) AS total_amount
            FROM accounts a
            INNER JOIN transactions t ON a.account_id = t.account_id
            GROUP BY a.member_id) AS member_totals) < 1000;

-- Expected Result:
  -- member_id     1     2     3
  -- first_name  Alice  Bob  Carol

-- Subquery calculates a single average value
-- Outer query compares each member's total against this single value
-- Subquery does not reference outer table columns → non-correlated

__________________________________________________________________________
-- 3 Compare Correlated vs Non-Correlated
__________________________________________________________________________
-- Type                  Correlated      Non-Correlated
-- Depends on Outer Query?  Yes                No
-- Runs per row?            Yes               Once
-- Use Case          Filter or calulate  Compare against a
--                   per row (e.g.,      constant or aggregate
--                   total per member    (e.g., average of
--                                        all members)

__________________________________________________________________________
-- 4 Performance Considerations
-- What it does: Helps prevent slow queries
-- Why use it: Correlated subqueries can be slower in large datasets
__________________________________________________________________________
-- Correlates subqueries run once per outer row → can be expensive
-- Non-correlated subqueries run once → usually faster
-- For large reports, consider JOIN + GROUP BY instead

__________________________________________________________________________
-- 5 Correlated vs Non-Correlated in Action
__________________________________________________________________________
-- Correlated:
  -- Members with total deposits > 500
    Select m.first_name
      (SELECT SUM(t.amount)
        FROM accounts a
        INNER JOIN transactions t ON a.account_id = t.account_id\
        WHERE a.member_id = m.member_id) AS total_transactions
      FROM members m
      WHERE
        (SELECT SUM(t.amount)
          FROM accounts a
          INNER JOIN transactions t ON a.account_id = t.account_id
          WHERE a.member_id = m.member_id) > 500;

  -- first_name         Alice
  -- total_transactions  650

-- Non-Correlated:
  -- Members above average transactions
    SELECT m.first_name, SUM(t.amount) AS total_transactions
      FROM members m
      INNER JOIN accounts a ON m.member_id = a.member_id
      INNER JOIN transactions t ON a.account_id = t.account_id
      GROUP BY m.member_id, m.first_name
      HAVING SUM(t.amount) >
        (SELECT AVG(total_amount)
          FROM
            (SELECT SUM(t.amount) AS total_amount
              FROM accounts a
              INNER JOIN transactions t ON a.account_id = t.account_id
              GROUP BY a.member_id) AS member_totals

  -- first_name         Alice
  -- total_transactions  650
  

-- Key Insight:
  -- Correlated → row-level comparison
  -- Non-Correlated  → table-level comparison

