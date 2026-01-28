_________________________________________________________________________________________________
-- Intermediate SQL: Designing Tables Around Entities, Not Convenience
-- Purpose: Learn how to structure tables to represent real-world objects
_________________________________________________________________________________________________

_________________________________________________________________________________________________
-- 1 What it means to design around entities
-- What it does: Defines tables that represent real-world "things" (entities)
-- Why use it: Prevents redundancy, improves query clarity, and enforces relationships
-- Exampes of entities: Users, Products, Orders, Categories
-- Key point: Each table has a PRIMARY KEY and relevant attributes
_________________________________________________________________________________________________
-- (SQlite)
CREATE TABLE Users (
  user_id INTEGER PRIMARY KEY,  -- Unique identifier for each user
  first_name TEXT NOT NULL,     -- First name of the user
  last_name TEXT NOT NULL,      -- Last name of the user
  signup_date TEXT NOT NULL     -- Date the user signed up
);

-- (SQL)
CREATE TABLE Users (
  user_id INT PRIMARY KEY,          --Unique identifier for each user
  first_name VARCHAR(50) NOT NULL,  -- First name of the user
  last_name VARCHAR(50) NOT NULL,   -- Last name of the user
  signup_date DATE NOT NULL         -- Date the user signed up
);

_________________________________________________________________________________________________
-- 2 Relationships between entities
-- What it does: Links entities using keys (PRIMARY and FOREIGN)
-- Why use it: Allows multiple tables to be joined and queried efficiently
-- Syntax: FOREIGN KEY (column) REFERENCES other_table(column)
_________________________________________________________________________________________________
ALTER TABLE Products
ADD COLUMN user_id INTEGER;

ALTER TABLE Products
ADD FOREIGN KEY (user_id) REFERENCES Users(user_id);

_________________________________________________________________________________________________
-- 3 Atomic columns (1NF)
-- What it does: Ensures each column contains a single, indivisible piece of data
-- Why use it: Prevents storing multiple values in one field
-- Syntax: Define one column per attribute
_________________________________________________________________________________________________
CREATE TABLE ProductCategories (
  product_id INTEGER,
  category_id INTEGER,
  PRIMARY KEY(product_id, category_id)
);

_________________________________________________________________________________________________
-- 4 Thinking beyond convenience
-- What it does: Avoids shortcut designs that are easier to write but harder to maintain
-- Why use it: Helps enforce data integrity, reduce update anomalies, and support future queries
_________________________________________________________________________________________________
-- Example

-- Example of a convenience / shortcut design:
-- Storing user info and orders in a single table
-- Problem: Redundant data and update headaches
/*
CREATE TABLE user_orders (
    user_id INTEGER,
    first_name TEXT,
    last_name TEXT,
    order_id INTEGER,
    product_name TEXT,
    quantity INTEGER,
    order_date TEXT
);
*/

-- Issues:
-- 1. If the same user places multiple orders, first_name/last_name repeats in every row
-- 2. Updating a user's name requires changing multiple rows
-- 3. Queries for just users or just orders are messy

__________________________________________________________________________
-- Better entity-focused design:
-- Split Users and Orders into separate tables
-- Each table focuses on a single entity
__________________________________________________________________________

-- Users table
CREATE TABLE Users (
    user_id INTEGER PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL
);

-- Orders table
CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    order_date TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Now:
-- - User data is stored once
-- - Orders reference the user via user_id
-- - Updates to user info happen in one place
-- - Queries for Users, Orders, or combined data are simpler

__________________________________________________________________________
-- Exercise:
-- 1. Identify a shortcut design in your own examples (maybe Products + Categories in one table)
-- 2. Rewrite it to separate tables using proper entities and foreign keys

-- Example: Don’t mix Users info and Orders in one table
-- Instead, separate:
-- Users, Orders, Order_Items
-- Join them when needed

-- Exercise: Draw an ER diagram for Users, Products, Categories, Orders, Order_Items

__________________________________________________________________________
-- 6 Your turn: Create a table
-- Instructions: Write a CREATE TABLE statement for one entity (choose Users, Products, or Orders)
-- Remember:
-- - Choose a primary key
-- - Use appropriate data types (INTEGER, TEXT, REAL)
-- - Mark required fields as NOT NULL
-- - Keep each column atomic
__________________________________________________________________________
-- Example starter:
CREATE TABLE YourEntityHere (
    entity_id INTEGER PRIMARY KEY,
    column1 TEXT NOT NULL,
    column2 REAL
);
