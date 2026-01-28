Project: Member Account and Transactions Dashboard
Project Goal

Simulate a credit union database for a small set of members, accounts, and transactions.
Use SQL to retrieve meaningful insights like balances, transaction counts, and overdue transactions.

This project demonstrates:

Core querying (SELECT, WHERE, aliases, sorting, limiting)

Basic data modification (INSERT, UPDATE, DELETE)

Aggregations and grouping (SUM, COUNT, AVG, GROUP BY, HAVING)

Joins between tables (members ↔ accounts ↔ transactions)

Constraints & data integrity (primary keys, foreign keys)

Views for reporting (like a “Member Summary” table)

Step 1: Define Tables
1. Members
Column	Type	Notes
member_id	INTEGER	PRIMARY KEY
first_name	TEXT	NOT NULL
last_name	TEXT	NOT NULL
email	TEXT	NULL allowed
status	TEXT	'Active' / 'Inactive' (CHECK)
2. Accounts
Column	Type	Notes
account_id	INTEGER	PRIMARY KEY
member_id	INTEGER	FOREIGN KEY → Members(member_id)
account_type	TEXT	'Checking' / 'Savings' (CHECK)
balance	REAL	Default 0
open_date	TEXT	YYYY-MM-DD format
3. Transactions
Column	Type	Notes
transaction_id	INTEGER	PRIMARY KEY
account_id	INTEGER	FOREIGN KEY → Accounts(account_id)
transaction_date	TEXT	YYYY-MM-DD
amount	REAL	Can be positive or negative
description	TEXT	Optional
Step 2: Sample SQL Tasks (What to Include)

Core Querying

List all members and their account types

Show only active members

Use aliases (AS) for column clarity

Order accounts by balance descending

Limit results to top 5

Basic Data Modification

Insert a new member and account

Update an account balance after a transaction

Delete a transaction older than a year for testing purposes

Aggregations

Total balance per member (SUM)

Average transaction amount per account (AVG)

Count of transactions per account (COUNT)

Max/min transaction amount (MAX, MIN)

Filtering Logic

Transactions > $500 or < -$500

Transactions between two dates

Accounts with balance IS NOT NULL

Multiple-Table Querying

Join members to accounts and transactions to see full history

LEFT JOIN to find members with no accounts

Subqueries

Find members whose total transactions exceed $1000

Correlated subquery: latest transaction for each account

CTEs

Calculate running balance per account

Generate a summary table of active members with total balance

Constraints & Data Integrity

Primary keys for each table

Foreign keys for relationships

CHECK constraints on status, account_type

Views

Create member_summary view: name, status, total accounts, total balance

Create recent_transactions view: transactions from last 30 days

Indexing (Optional)

Index member_id in Accounts

Index account_id in Transactions

Step 3: Deliverables

schema.sql → tables, primary keys, foreign keys, constraints

seed_data.sql → 5–10 members, accounts, and transactions each

queries.sql → all the example queries listed above

README.md → explains project, tables, example queries, and what concepts are demonstrated
