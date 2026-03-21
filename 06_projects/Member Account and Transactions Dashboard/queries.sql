Tier 1

-- Basic SELECT Usage
  -- 1. List all members
    SELECT * FROM Members;
      1|Alice|Johnson|Active
      2|Bob|Smith|Active
      3|Carol|Davis|Inactive
      4|David|Brown|Active
      5|Eva|Miller|Active
  -- 2. Select specific colums instead of Select *
    SELECT first_name FROM Members;
      Alice
      Bob
      Carol
      David
      Eva
  -- 3. Use column aliases (AS) for readability
    .headers ON
    .mode column
    SELECT first_name AS "First Name" FROM Members;
      First Name
      ----------
      Alice
      Bob
      Carol
      David
      Eva
      
-- Filtering with WHERE
  -- 1. Filter members by active status
    SELECT member_id FROM Members WHERE status IS 'Active';
      member_id
      ---------
      1
      2
      4
      5
  -- 2. Apply comparison operators (=, !=)
    SELECT member_id FROM Members WHERE status = 'Active';
      member_id
      ---------
      1
      2
      4
      5
    SELECT member_id FROM Members WHERE status != 'Active';
      ---------
      3

-- Sorting & Limiting
  -- 1. Order accounts by balance (descending)
    SELECT* FROM Accounts ORDER BY balance DESC;
      account_id  member_id  account_type  balance  open_date
      ----------  ---------  ------------  -------  ----------
      106         4          Savings       7800.0   2024-02-01
      102         1          Savings       5000.0   2022-06-15
      104         2          Savings       3500.0   2021-03-20
      101         1          Checking      2500.0   2023-01-10
      103         2          Checking      1500.0   2021-03-20
      107         5          Checking      1200.0   2023-12-25
      105         3          Checking      0.0      2020-11-11

  -- 2. Limit results to top N = 2 records
    SELECT* FROM Accounts ORDER BY balance DESC LIMIT 2;
      account_id  member_id  account_type  balance  open_date
      ----------  ---------  ------------  -------  ----------
      106         4          Savings       7800.0   2024-02-01
      102         1          Savings       5000.0   2022-06-15

-- INSERT
  -- 1. Insert a new member
    INSERT INTO Members (first_name, last_name, status) VALUES ('Jane', 'Doe', 'Inactive');
    SELECT * FROM Members;
      member_id  first_name  last_name  status
      ---------  ----------  ---------  --------
      1          Alice       Johnson    Active
      2          Bob         Smith      Active
      3          Carol       Davis      Inactive
      4          David       Brown      Active
      5          Eva         Miller     Active
      6          Jane        Doe        Inactive
  -- 2. Insert an associated account
    UPDATE Accounts SET open_date = '2026-02-02' WHERE member_id = 6;
    SELECT * FROM Accounts;
      account_id  member_id  account_type  balance  open_date
      ----------  ---------  ------------  -------  ----------
      101         1          Checking      2500.0   2023-01-10
      102         1          Savings       5000.0   2022-06-15
      103         2          Checking      1500.0   2021-03-20
      104         2          Savings       3500.0   2021-03-20
      105         3          Checking      0.0      2020-11-11
      106         4          Savings       7800.0   2024-02-01
      107         5          Checking      1200.0   2023-12-25
      108         6          Checking      200.0    2026-02-02

-- UPDATE
  -- 1. Update an account balance after a transaction
    INSERT INTO Transactions (transaction_id, account_id, transaction_date, amount, description) 
        VALUES (1011, 108, '2026-02-02', 200, 'Bonus');
    UPDATE Accounts SET balance = 200.00 WHERE member_id = 6;
    SELECT * FROM Accounts;
      account_id  member_id  account_type  balance  open_date
      ----------  ---------  ------------  -------  ----------
      101         1          Checking      2400.0   2023-01-10
      102         1          Savings       5000.0   2022-06-15
      103         2          Checking      1500.0   2021-03-20
      104         2          Savings       3500.0   2021-03-20
      105         3          Checking      0.0      2020-11-11
      106         4          Savings       7800.0   2024-02-01
      107         5          Checking      1200.0   2023-12-25
      108         6          Checking      200.0   2026-02-02
  -- 2. Use WHERE safely to avoid unintended updates
    UPDATE Accounts SET balance = 2400.00 WHERE member_id = 1 AND account_type = 'Checking';
    SELECT * FROM Accounts;
      account_id  member_id  account_type  balance  open_date
      ----------  ---------  ------------  -------  ----------
      101         1          Checking      2400.0   2023-01-10
      102         1          Savings       5000.0   2022-06-15
      103         2          Checking      1500.0   2021-03-20
      104         2          Savings       3500.0   2021-03-20
      105         3          Checking      0.0      2020-11-11
      106         4          Savings       7800.0   2024-02-01
      107         5          Checking      1200.0   2023-12-25
      108         6          Checking      200.0    2026-02-02

-- DELETE
  -- 1. Delete test data only
    BEGIN TRANSACTION;
    DELETE FROM Members WHERE first_name = 'Jane' AND last_name = 'Doe';
      member_id  first_name  last_name  status
      ---------  ----------  ---------  --------
      1          Alice       Johnson    Active
      2          Bob         Smith      Active
      3          Carol       Davis      Inactive
      4          David       Brown      Active
      5          Eva         Miller     Active
  -- 2. Delete records based on date conditions
    BEGIN TRANSACTION;
    DELETE FROM Accounts WHERE open_date = '2026-02-02';
    SELECT * FROM Accounts;
      account_id  member_id  account_type  balance  open_date
      ----------  ---------  ------------  -------  ----------
      101         1          Checking      2400.0   2023-01-10
      102         1          Savings       5000.0   2022-06-15
      103         2          Checking      1500.0   2021-03-20
      104         2          Savings       3500.0   2021-03-20
      105         3          Checking      0.0      2020-11-11
      106         4          Savings       7800.0   2024-02-01
      107         5          Checking      1200.0   2023-12-25

-- Aggregate Functions
  -- 1. Total balance for all member accounts (SUM)
    SELECT SUM(balance) AS Total_Balance FROM Accounts;
      Total_Balance
      -------------
      21400.0
  -- 2. Average transaction amount for all accounts (AVG)
     SELECT AVG(balance) AS Avg_Balance FROM Accounts;
      Avg_Balance
      ----------------
      3057.14
  -- 3. Count of all accounts (Count)
    SELECT COUNT(*) AS Total_Accounts FROM Accounts;
      Total_Accounts
      --------------
      7
  -- 4. Highest and lowest transaction values (Max, Min)
    SELECT MAX(balance) AS Highest_balance FROM Accounts;
      Highest_balance
      ---------------
      7800.0
        
    SELECT MIN(balance) AS Lowest_balance FROM Accounts;
      Lowest_balance
      --------------
      0.0

--Conditional Filters
  -- 1. Transactions above or below thresholds
    SELECT * FROM Transactions WHERE amount > 300.00 OR amount < 100;
      transaction_id  account_id  transaction_date  amount  description
      --------------  ----------  ----------------  ------  ------------
      1001            101         2026-01-10        1000.0  Paycheck  
      1003            102         2026-01-05        500.0   Gift      
      1006            104         2026-01-09        50.0    Coffee    
      1007            106         2026-01-15        1000.0  Bonus     
      1009            101         2026-01-17        50.0    Subscription

  -- 2. Transactions within a date range
    SELECT * FROM Transactions WHERE transaction_date < '2026-01-07' OR transaction_date > '2026-01-15';
      transaction_id  account_id  transaction_date  amount  description
      --------------  ----------  ----------------  ------  -----------------
      1003            102         2026-01-05        500.0   Gift      
      1008            107         2026-01-16        100.0   Restaurant
      1009            101         2026-01-17        50.0    Subscription
      1010            102         2026-01-18        200.0   Freelance Payment
      1011            108         2026-02-02        200.0   Bonus     
  -- 3. Filter records using IS NULL / IS NOT NULL
     SELECT * FROM Transactions WHERE description IS NULL;
      transaction_id  account_id  transaction_date  amount  description
      --------------  ----------  ----------------  ------  -----------
      1012            108         2026-02-09        100.0             
    SELECT * FROM Transactions WHERE description IS NOT NULL;
      transaction_id  account_id  transaction_date  amount  description
      --------------  ----------  ----------------  ------  -----------------
      1001            101         2026-01-10        1000.0  Paycheck  
      1002            101         2026-01-12        200.0   Groceries 
      1003            102         2026-01-05        500.0   Gift      
      1004            103         2026-01-07        150.0   Gas       
      1005            104         2026-01-08        300.0   Refund    
      1006            104         2026-01-09        50.0    Coffee    
      1007            106         2026-01-15        1000.0  Bonus     
      1008            107         2026-01-16        100.0   Restaurant
      1009            101         2026-01-17        50.0    Subscription
      1010            102         2026-01-18        200.0   Freelance Payment
      1011            108         2026-02-02        200.0   Bonus  

Tier 2

-- JOIN Operations
  -- 1. Join members to accounts for all active members in order by member_id
    SELECT * FROM Members AS m INNER JOIN Accounts AS a ON m.member_id = a.member_id WHERE status = 'Active' ORDER BY member_id;
      member_id  first_name  last_name  status  account_id  member_id  account_type  balance  open_date
      ---------  ----------  ---------  ------  ----------  ---------  ------------  -------  ----------
      1          Alice       Johnson    Active  101         1          Checking      2400.0   2023-01-10
      1          Alice       Johnson    Active  102         1          Savings       5000.0   2022-06-15
      2          Bob         Smith      Active  103         2          Checking      1500.0   2021-03-20
      2          Bob         Smith      Active  104         2          Savings       3500.0   2021-03-20
      4          David       Brown      Active  106         4          Savings       7800.0   2024-02-01
      5          Eva         Miller     Active  107         5          Checking      1200.0   2023-12-25
  -- 2. Join accounts to transactions
    SELECT * FROM Accounts AS a INNER JOIN Transactions AS t ON a.account_id = t.account_id WHERE amount > 600 ORDER BY m.member_id;
      account_id  member_id  account_type  balance  open_date   transaction_id  account_id  transaction_date  amount  description
      ----------  ---------  ------------  -------  ----------  --------------  ----------  ----------------  ------  -----------
      101         1          Checking      2400.0   2023-01-10  1001            101         2026-01-10        1000.0  Paycheck
      106         4          Savings       7800.0   2024-02-01  1007            106         2026-01-15        1000.0  Bonus 
  -- 3. Retrieve full member transaction history for Alice ordered by dates
    SELECT m.member_id, m.first_name, m.last_name, m.status, t.transaction_id, t.account_id, t.transaction_date, t.amount, t.description 
        FROM Members m INNER JOIN Accounts a ON a.member_id = m.member_id INNER JOIN Transactions t ON t.account_id = a.account_id WHERE first_name = 'Alice' ORDER BY t.transaction_date;
      member_id  first_name  last_name  status  transaction_id  account_id  transaction_date  amount  description
      ---------  ----------  ---------  ------  --------------  ----------  ----------------  ------  -----------------
      1          Alice       Johnson    Active  1003            102         2026-01-05        500.0   Gift
      1          Alice       Johnson    Active  1001            101         2026-01-10        1000.0  Paycheck
      1          Alice       Johnson    Active  1002            101         2026-01-12        200.0   Groceries
      1          Alice       Johnson    Active  1009            101         2026-01-17        50.0    Subscription
      1          Alice       Johnson    Active  1010            102         2026-01-18        200.0   Freelance Payment
        
-- LEFT JOIN Logic
  -- 1. Identify members with no associated accounts
    SELECT m.first_name, m.last_name, m.member_id FROM Members AS m LEFT JOIN Accounts AS a ON m.member_id = a.member_id WHERE a.member_id IS NULL;
      first_name  last_name  member_id
      ----------  ---------  ---------
      Stanley     Pines      7
  -- 2. Understand join cardinality and missing relationships
    SELECT m.member_id, m.first_name, a.account_id FROM Members m INNER JOIN Accounts a ON m.member_id = a.member_id;
      member_id  first_name  account_id
      ---------  ----------  ----------
      1          Alice       101
      1          Alice       102
      2          Bob         103
      2          Bob         104
      3          Carol       105
      4          David       106
      5          Eva         107
      6          Jane        108
    SELECT m.member_id, m.first_name, a.account_id FROM Members m LEFT JOIN Accounts a ON m.member_id = a.member_id;
      member_id  first_name  account_id
      ---------  ----------  ----------
      1          Alice       101
      1          Alice       102
      2          Bob         103
      2          Bob         104
      3          Carol       105
      4          David       106
      5          Eva         107
      6          Jane        108
      7          Stanley

-- Non-Correlated Subqueries
  -- 1. Identify members exceeding a transaction total threshold
    SELECT m.member_id, m.first_name, total.total_amount 
        FROM members m 
        INNER JOIN 
          (SELECT a.member_id, SUM(t.amount) AS total_amount 
            FROM accounts a INNER JOIN transactions t ON a.account_id = t.account_id GROUP BY a.member_id) AS total ON m.member_id = total.member_id WHERE total.total_amount > 1000;
      member_id  first_name  total_amount
      ---------  ----------  ------------
      1          Alice       1950.0
-- Correlated Subqueries
  -- 1. Retrieve the most recent transaction per account
    SELECT a.account_id, (SELECT MAX(t.transaction_date) FROM transactions t WHERE t.account_id = a.account_id) AS most_recent_transaction FROM accounts a;
      account_id  most_recent_transaction
      ----------  -----------------------
      101         2026-01-17
      102         2026-01-18
      103         2026-01-07
      104         2026-01-09
      105
      106         2026-01-15
      107         2026-01-16
      108         2026-02-09
-- WITH Clauses
  -- 1. Calculate running balances per account
    WITH running_balances AS (
      SELECT t.account_id, t.transaction_id, t.transaction_date, t.amount, SUM(t.amount) OVER (
        PARTITION BY t.account_id
        ORDER BY t.transaction_date, t.transaction_id
      ) AS running_balance
      FROM transactions t
    )
    SELECT *
    FROM running_balances
    ORDER BY account_id, transaction_date;
      account_id  transaction_id  transaction_date  amount  running_balance
      ----------  --------------  ----------------  ------  ---------------
      101         1001            2026-01-10        1000.0  1000.0
      101         1002            2026-01-12        200.0   1200.0
      101         1009            2026-01-17        50.0    1250.0
      102         1003            2026-01-05        500.0   500.0
      102         1010            2026-01-18        200.0   700.0
      103         1004            2026-01-07        150.0   150.0
      104         1005            2026-01-08        300.0   300.0
      104         1006            2026-01-09        50.0    350.0
      106         1007            2026-01-15        1000.0  1000.0
      107         1008            2026-01-16        100.0   100.0
      108         1011            2026-02-02        200.0   200.0
      108         1012            2026-02-09        100.0   300.0
      
  -- 2. Generate summarized member-level data

-- Primary Keys
  -- 1. Unique identifiers for all tables

-- Foreign Keys
  -- 1. Enforce valid relationships between tables

-- CHECK Constraints
  -- 1. Restrict valid statuses
  -- 2. Restrict valid account types

-- Reporting Views
  -- 1. Member summary view (status, totals)
  -- 2. Recent transactions view (time-based filtering)

Tier 3

-- Indexing
  -- 1. Index frequently joined foreign keys
  -- 2. Index frequently filtered columns

