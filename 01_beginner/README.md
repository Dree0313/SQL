# Tier 1: Beginner — SQL Syntax Literacy

## Purpose
This section focuses on **SQL language fluency**.  
The goal is to become comfortable reading and writing basic SQL statements with correct syntax and predictable results.

At this stage, the emphasis is on:
- Knowing what common SQL statements look like
- Understanding how queries are structured
- Building confidence interacting with a database

This tier intentionally avoids complex joins, schema design, and optimization topics.

---

## Concepts Covered

### Core Querying
- [`SELECT`](01_select.sql)
- `WHERE`
- Column selection vs `SELECT *`
- Aliases (`AS`)

### Sorting & Limiting
- `ORDER BY`
- `ASC` / `DESC`
- `LIMIT`

### Basic Data Modification
- `INSERT`
- `UPDATE`
- `DELETE`
- Using `WHERE` safely with write operations

### Simple Aggregations
- `COUNT`
- `SUM`
- `MIN`
- `MAX`
- `AVG`

### Basic Filtering Logic
- Comparison operators (`=`, `!=`, `<`, `>`, `<=`, `>=`)
- Logical operators (`AND`, `OR`)
- `IN`
- `BETWEEN`
- `LIKE`

### NULL Handling
- `IS NULL`
- `IS NOT NULL`
- Understanding how NULL behaves in queries

---

## Expected Outcome
After completing this tier, I should be able to:
- Read basic SQL queries and understand what they do
- Write simple queries to retrieve, sort, and filter data
- Safely modify data using basic DML statements
- Feel comfortable navigating a SQL environment (SQLite shell)


Tier 2: Intermediate (Relational Thinking)

👉 Your BCBS project lands you HERE solidly

Subjects

Multi-table JOINs (INNER, LEFT)

GROUP BY / HAVING

Subqueries

CTEs

Constraints (PK, FK, CHECK)

Data normalization (1NF–3NF)

Views

Basic indexing

Translating business rules → SQL

🧠 This is understanding how data relates and why.

Tier 3: Advanced (Professional Engineer Level)

Most senior devs live here.

Subjects

Window functions (LAG, LEAD, RANK)

Query optimization

Execution plans

Index strategies

Transactions & isolation levels

Locks & concurrency

Stored procedures & triggers

Partitioning

Denormalization tradeoffs

🧠 This is making SQL fast, safe, and scalable.

⚠️ Most people think this is the top.

It is not.

Tier 4: Expert (Database Engineering)

Now SQL becomes part of a system, not the star.

Subjects

Database internals

Query planners & optimizers

Cost-based optimization

MVCC (Multi-Version Concurrency Control)

Write-ahead logging (WAL)

Replication strategies

Sharding

Fault tolerance

Distributed SQL systems (Spanner, CockroachDB)

Schema evolution at scale

Backups & disaster recovery

🧠 This is knowing what the database engine is doing behind the scenes.

Tier 5: Research / PhD-Level (Database Science)

🔥 This is where “PhD level” actually lives.

SQL becomes secondary.

Core Subjects (ALL of these matter)
📐 Theory

Relational algebra

Relational calculus

Query equivalence

Normal form proofs

Functional dependencies

Constraint satisfaction

Formal query languages

⚙️ Systems

Query optimizer design

Index structure research (B-trees, LSM trees)

Storage engines

Distributed consensus (Paxos, Raft)

CAP theorem tradeoffs

Transaction correctness proofs

Snapshot isolation models

📊 Data Science + Databases

Columnar storage

Vectorized execution

Analytical vs OLTP engines

Approximate query processing

Streaming SQL

Temporal databases

Graph databases & extensions

🧪 Research & Innovation

Designing new SQL dialects

Query language evolution

Database benchmarking research

New data models (beyond relational)

Performance modeling

*SQL (Structured Query Language) is a language used to communicate with databases

*SQL is a language that speaks only to Relational Databases

*Foreign Key (FK) is a column that links one table to another or an ID that points to another tables PK

*Primary Key (PK) is a unique ID insided a table

    A column or set of columns that 
    1. Must have a value -> cannot be NULL
    2. Must be unique -> no duplicates
    3. Uniquely identifies each row in a table
    Most of the times, it's auto-generated
    Ex:
        member_id INT PRIMARY KEY AUTO_INCREMENT
      or
        member_id SERIAL PRIMARY KEY



## Examples

**SELECT name FROM lego_people**
  
    name        = column
  
    lego_people = table

**SELECT name FROM lego_height WHERE cm > 3;**
  
    name        = column
  
    lego_height = table
  
    cm > 3      = condition

**SELECT name, age FROM people LEFT JOIN lego_height USING (name);**
  
    name        = column
 
    age         = column
  
    people      = table
  
    lego_height = table
  
    (name)      = join criteria

**INSERT INTO lego_people(name, age) VALUES ('Joe', 12);**
  
    lego_people = table
  
    name        = column
  
    age         = column
  
    ('Joe', 12) = inputs / column

**UPDATE lego_people SET age = 13 WHERE name = 'Joe';**
  
    lego_people  = table
  
    age = 13     = column input
  
    name = 'Joe' = column criteria

**DELETE FROM lego_people WHERE name = 'Joe';**
  
    lego_people  = table
  
    name = 'Joe' = column criteria

# SQL Project: Health Insurance Claims Management System

Project Goal:

Design and query a relational database that simulates how an insurance company
might store, process, and analyze member insurance claims.

The goal is to show:

* Strong understanding of relational design

* Ability to write real-world queries

* Comfort with updates, joins, aggregates, and constraints

* Business awareness (costs, approvals, providerrs)

## Database Requirements

Must create at least 6 tables with proper primary keys and foreign keys

**Required Tables**

1. Members
2. Providers
3. Plans
4. Claims
5. Claim_items
6. Payments

## Table Criteria

Each table must include

**Members**

* Unique member ID
* First name, last name
* Date of birth
* Gender
* Enrollment date
* Plan ID (FK)
* Status (Active / Inactive)

**Plans**

* Plan ID
* Plan name (HMO, PPO, etc.)
* Monthly premium
* Annual deductible
* Out-of-pocket maximum

**Providers**

* Provider ID
* Provider name
* Specialty
* In-network (Yes / No)
* City and state

**Claims**

* Claim ID
* Member ID (FK)
* Provider ID (FK)
* Date of service
* Date claim submitted
* Claim status (Pending, Approved, Denied)
* Total billed amount

**Claim_Items**

Each claim must have 1+ items

* Claim item ID
* Claim ID (FK)
* Procedure code
* Description
* Billed amount
* Covered amount

**Payments**

* Payment ID
* Claim ID (FK)
* Payment date
* Amount paid by insurance
* Amount paind by member
* Payment method

**Data Rules & Constraints**

* A claim cannot exist without a valid member and provider
* A claim cannot be approved unless it hhas at least one claim item
* Covered amount cannot exceed billed amount
* Members on inactive status cccannot submit new claims
* Out-of-network providers should result in lower covered amounts

## Required SQL Tasks

Must write queries that accomplish ALL of the following:

**Basic Queries**

* List all active members with their plan details
* Show all claims for a given member
* Retrieve all claims submitted in the last 90 days

**JOIN Queries**

* Show claims with member name and provider name
* List claim items with their claim status
* Display payments alongside claim totals

**Aggregations**

* Total claims cost per member
* Average claim amount per plan
* Total amount paid by insurance vs members
* Top 5 providers by total billed amount

**Conditional Logic**

* Identify claims that exceed the member's deductible
* Flag claims that are out-of-network
* Show denied claims and the total denied amount

**UPDATE / DELETE**

* Update claim status from Pending -> Approved
* Automatically adjust payment amounts when a claim is denied
* Delete claims submitted by inactive members (with caution)

**Advanced (Optional)**

* Use a CTE to calculate running totals of member out-of-pocket costs
* Create a VIEW for approved claims with payment summaries
* Write a stored procedure to submit a new claim
* Add indexes and explain why
Inside each project README, you describe:

Difficulty

Concepts used

Business context
