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

3. Sorting & Limiting

3.1 Order accounts by balance (descending)
3.2 Limit results to top N records

🟢 Tier 1 — Basic Data Modification (Beginner: Write Operations)

Goal: Show ability to safely modify data.

4. INSERT

4.1 Insert a new member
4.2 Insert an associated account

5. UPDATE

5.1 Update an account balance after a transaction
5.2 Use WHERE safely to avoid unintended updates

6. DELETE

6.1 Delete test data only
6.2 Delete records based on date conditions

🟢 Tier 1 — Aggregations (Beginner: Analytical Basics)

Goal: Summarize numeric data meaningfully.

7. Aggregate Functions

7.1 Total balance per member (SUM)
7.2 Average transaction amount per account (AVG)
7.3 Count of transactions per account (COUNT)
7.4 Highest and lowest transaction values (MAX, MIN)

🟢 Tier 1 — Filtering Logic (Beginner: Conditional Thinking)

Goal: Apply business-style filters.

8. Conditional Filters

8.1 Transactions above or below thresholds
8.2 Transactions within a date range
8.3 Filter records using IS NULL / IS NOT NULL

🟡 Tier 2 — Multiple-Table Querying (Intermediate: Relational Thinking)

Goal: Understand relationships between tables.

9. JOIN Operations

9.1 Join members to accounts
9.2 Join accounts to transactions
9.3 Retrieve full member transaction history

10. LEFT JOIN Logic

10.1 Identify members with no associated accounts
10.2 Understand join cardinality and missing relationships

🟡 Tier 2 — Subqueries (Intermediate: Nested Reasoning)

Goal: Use queries inside queries for complex conditions.

11. Non-Correlated Subqueries

11.1 Identify members exceeding a transaction total threshold

12. Correlated Subqueries

12.1 Retrieve the most recent transaction per account

🟡 Tier 2 — Common Table Expressions (CTEs)

Goal: Improve readability and structure of complex logic.

13. WITH Clauses

13.1 Calculate running balances per account
13.2 Generate summarized member-level data

🟡 Tier 2 — Constraints & Data Integrity (Schema Awareness)

Goal: Enforce correctness at the database level.

14. Primary Keys

14.1 Unique identifiers for all tables

15. Foreign Keys

15.1 Enforce valid relationships between tables

16. CHECK Constraints

16.1 Restrict valid statuses
16.2 Restrict valid account types

🟡 Tier 2 — Views (Business Abstraction)

Goal: Present simplified, business-friendly datasets.

17. Reporting Views

17.1 Member summary view (status, totals)
17.2 Recent transactions view (time-based filtering)

🔵 Tier 3 — Performance Awareness (Optional / Nice-to-Have)

Goal: Demonstrate awareness of scalability and optimization.

18. Indexing

18.1 Index frequently joined foreign keys
18.2 Index frequently filtered columns
