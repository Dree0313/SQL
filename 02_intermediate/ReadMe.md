# Tier 2: Intermediate — Relational Thinking

## Purpose
This section focuses on how data relates across tables and how real-world business rules are expressed through SQL.

The goal is to move beyond single-table queries and begin thinking in terms of:
- Relationships between entities
- Aggregations across datasets
- Enforcing correctness through constraints

---

## Concepts Covered

### Multiple-Table Querying
- [`INNER JOIN`](01_Multiple-Table_Querying/01_INNER_JOIN.sql)
- [`LEFT JOIN`](01_Multiple-Table_Querying/02_LEFT_JOIN.sql)
- [Joining tables using primary and foreign keys](01_Multiple-Table_Querying/03_Joining_tables_using_primary_and_foreign_keys.sql)
- [Understanding join cardinality](01_Multiple-Table_Querying/04_Understanding_join_cardinality.sql)

### Aggregations & Grouping
- [`GROUP BY`](02_Aggregations_&_Grouping/01_GROUP_BY.sql)
- [`HAVING`](02_Aggregations_&_Grouping/02_HAVING.sql)
- [Aggregating across related tables](02_Aggregations_&_Grouping/03_Aggregating_across_related_tables.sql)

### Subqueries
- Subqueries in `SELECT`
- Subqueries in `WHERE`
- Correlated vs non-correlated subqueries
- When a subquery is more readable than a join

### Common Table Expressions (CTEs)
- `WITH` clauses
- Breaking complex queries into logical steps
- Improving readability and maintainability
- Using CTEs for intermediate calculations

### Constraints & Data Integrity
- Primary Keys (`PRIMARY KEY`)
- Foreign Keys (`FOREIGN KEY`)
- `CHECK` constraints
- Preventing invalid or contradictory data
- Understanding what belongs in schema vs logic

### Data Normalization
- First Normal Form (1NF)
- Second Normal Form (2NF)
- Third Normal Form (3NF)
- Eliminating redundancy
- [Designing tables around entities, not convenience](06_Data_Normalization/05_Designing_tables_around_entities_not_convenience.sql)

### Views
- Creating `VIEW`s
- Abstracting complex queries
- Presenting simplified, business-friendly datasets
- Using views for reporting and consistency

### Basic Indexing
- What indexes are
- When indexing helps
- Tradeoffs between read speed and write cost
- Indexing foreign keys and frequently filtering columns

### Translating Business Rules → SQL
- Converting written requirements into contraints
- Expressing rules like:
  - Eligibility
  - Status-based restrictions
  - [Financial limits](09_Translating_Business_Rules_→_SQL/04_Financial_limits.sql)
- Understanding the difference between data correctness and application logic

---

## Expected Outcome
After completing this tier, I should be able to:
- Write queries that span multiple related tables
- Aggregate and summarize data in meaningful ways
- Design schemas that reflect real-world entities
- Enforce business rules using constraints and SQL logic
- Read and reason about non-trivial SQL queries with confidence


