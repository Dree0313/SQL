Tier 1 - Core Querying

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

  -- 2. Insert an associated account
