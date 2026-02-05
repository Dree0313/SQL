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
    UPDATE Accounts SET balance = 2000.00 WHERE member_id = 6;
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
      108         6          Checking      2000.0   2026-02-02
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
  -- 2. Average transaction amount per account (AVG)
  -- 3. Count of transactions per account (Count)
  -- 4. Highest and lowest transaction values (Max, Min)
