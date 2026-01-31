_________________________________________________________________________________________________
-- Intermediate SQL: Financial Limits
-- Purpose: Learn how to enforce monetary rules using constraints, data types, and business logic
_________________________________________________________________________________________________

_________________________________________________________________________________________________
-- 1 Define REAL or DECIMAL columns
-- What it does: Sets up columns to store monetary values
-- Why use it: Ensures correct precision for financial data
-- Syntax: column_name REAL; --SQLite floating-point
  -- column_name DECIMAL(10,2); -- Fixed-point (other DBs)
_________________________________________________________________________________________________
-- (SQLite)
  amount1 REAL;
  amount2 REAL; 

-- (SQL)
  amount1 DECIMAL(10,2);
  amount2 DECIMAL(10,2);

_________________________________________________________________________________________________
-- 2 Enforce non-negative values
-- What it does: Prevents negative numbers
-- Why use it: Ensures values follow business logic
-- Syntax: CHECK (column_name >= 0)
_________________________________________________________________________________________________
  CHECK(amount1 >= 0);
  CHECK(amount2 >= 0);

_________________________________________________________________________________________________
-- 3 Enforce logical relationships between columns
-- What it does: Ensures onve value does not exceed another
-- Why use it: Maintains logical consistency
-- Syntax: CHECK (column1 <= column2)
_________________________________________________________________________________________________
  CHECK(amount3 >= amount2);

_________________________________________________________________________________________________
-- 4 Test inserting values
-- What it does: Validates constraints
-- Why use it: Practice seeing rules enforced
-- Syntax: Use numeric values only
_________________________________________________________________________________________________
  INSERT INTO amounts (amount1, amount2, amount 3)
  VALUES (100, 200, 500);
