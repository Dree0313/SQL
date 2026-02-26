__________________________________________________________________________
-- Intermediate SQL: Subqueries in WHERE
-- Purpose: Learn how to filter rows using subqueries in the WHERE clause
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a bank. Management wants
  -- to filter data based on related tables

    -- Members with total transactions over $500
    -- Accounts with more than 2 transactions
    -- Active members who made deposits greater than $1000

  -- Instead of grouping the entire result, you will calculate summary
  -- values using subqueries directly inside SELECT.

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
-- 1️ What is a Subquery in WHERE?
-- What it does: Runs a query inside the WHERE clause to filter rows
-- Why use it: Allows filtering based on related table data
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

-- Subquery calculates total transadctions per member
-- Outer query returns members where the total exceeds 500

__________________________________________________________________________
-- 2 Using COUNT() in WHERE
-- What it does: Filters rows based on related row counts
-- Why use it: Identify high-activity members or accounts
__________________________________________________________________________
-- Problem:
  -- Management wants accounts with more than 2 transactions

-- Example:
  SELECT a.account_id, a.account_type
    FROM accounts a
    WHERE
      (SELECT COUNT(*)
        FROM transactions t
        WHERE t.account_id = a.account_id) > 2;

-- Expected Result:
  -- account_id      101
  -- account_type  Checking

-- Account 101 has 3 transactions → returned
-- Accounts 102, 103, 104 have ≤ 2 → excluded

__________________________________________________________________________
-- 3 Subquery with Multiple Conditions
-- What it does: Combines filters on related tables
-- Why use it: Apply precise business rules
__________________________________________________________________________
-- Problem: 
  -- Management wants active members whose total deposits exceed 1000

-- Solution: 
  SELECT m.member_id, m.first_name
    FROM members m
    WHERE m.status = 'Active' AND
      (SELECT SUM(t.amount)
        FROM accounts a
        INNER JOIN transactions t ON a.account_id = t.account_id
        WHERE a.member_id = m.member_id AND t.amount > 0) > 1000;

-- Expected Result:
  -- member_id     1
  -- first_name  Alice

-- Filters Active members first (WHERE)
-- Subquery sums only positive transactions
-- Alice's total deposits = 1000 + 200 + 500 + 200 = 1900 → included

__________________________________________________________________________
-- 4 Handling NULLs
-- What it does: Prevents missing data from excluding rows
-- Why use it: Avoid unexpected results from members with no transactions
__________________________________________________________________________
-- Problem: Include members with no transactions as zero in condition

-- Solution:
    SELECT m.member_id, m.first_name,
      FROM members m
      WHERE
        COALESCE((SELECT SUM(t.amount)
          FROM accounts a
          INNER JOIN transactions t ON a.account_id = t.account_id
          WHERE a.member_id = m.member_id), 0) > 0;

-- Expected Result:
  -- member_id     1     2     3
  -- first_name  Alice  Bob  Carol

-- Carol has no transactions → SUM() returns NULL → COALESCE converts to 0
-- Condition "> 0" filters only members with transactions
__________________________________________________________________________
-- 5 Subquery vs JOIN + GROUP BY (Key Difference)
-- What it does: Shows two approaches to filter by aggregates
-- Why use it: Understand row-level vs group-level logic
__________________________________________________________________________
-- JOIN + GROUP BY version:
  Select m.member_id, SUM(t.amount) AS total_amount
    FROM members m
    INNER JOIN accounts a ON m.member_id = a.member_id
    INNER JOIN transactions t ON a.account_id = t.account_id
    GROUP BY m.member_id
    HAVING SUM(t.amount) > 500;

  -- member_id       1
  -- SUM(t.amount)  650

-- Subquery in WHERE verion:
  SELECT m.member_id, m.first_name
    FROM members m
    WHERE
      (SELECT SUM(t.amount)
        FROM accounts a
        INNER JOIN transactions t ON a.account_id = t.account_id
        WHERE a.member_id = m.member_id) ? 500;

  -- member_id     1
  -- first_name  Alice
  

-- Key Insight:
  -- GROUP BY + HAVING → returns only grouped members
  -- Subquery → keeps original table rows, can filter per row
  -- Subqueries are correlated and executed once per row

__________________________________________________________________________
-- 6 Exectuion Order Insight
-- What it does: Explains SQL processing for correlated subqueries
-- Why use it: Avoid performance surprises
__________________________________________________________________________
-- Processing Order:
  -- 1. Outer FROM (members)
  -- 2. For EACH member row:
    -- Run the subquery
    -- Return calculated value
  -- 3. Apply WHERE condition
  -- 4. Return final result set
  
  -- Subqueries in WHERE can be slower on large datasets
  -- JOIN + GROUP BY is often more efficient for bulk aggregation
