Tier 1 - Core Querying

-- Basic SELECT Usage
  -- 1. List all members
    SELECT * FROM Members;
  -- 2. Select specific colums instead of Select *
    SELECT first_name FROM Members;
  -- 3. Use column aliases (AS) for readability
    SELECT first_name AS "First Name" FROM Members;

-- Filtering with WHERE
  -- 1. Filter members by active status
     SELECT member_id FROM Members WHERE status IS 'Active';
  -- 2. Apply comparison operators (=, !=)
    SELECT member_id FROM Members WHERE status = 'Active';
    SELECT member_id FROM Members WHERE status != 'Active';

-- Sorting & Limiting
