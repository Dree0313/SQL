# Tier 1: Beginner — SQL Syntax Literacy

## Purpose
This section focuses on **SQL language fluency**.  
The goal is to become comfortable reading and writing basic SQL statements with correct syntax and predictable results.

At this stage, the emphasis is on:
- Knowing what common SQL statements look like
- Understanding how queries are structured
- Building confidence interacting with a database

---

## Concepts Covered

### Core Querying
- [`SELECT`](01_Core_Query/01_select.sql)
- [`WHERE`](01_Core_Query/02_where.sql)
- [Column selection vs `SELECT *`](01_Core_Query/03_Column_selection_vs_SELECT*.sql)
- [Aliases (`AS`)](01_Core_Query/04_Aliases_(AS).sql)

### Sorting & Limiting
- [`ORDER BY`](02_Sorting_&_Limiting/01_ORDER_BY.sql)
- [`ASC` / `DESC`](02_Sorting_&_Limiting/02_ASC_DESC.sql)
- [`TOP`](02_Sorting_&_Limiting/03_TOP.sql) (SQL Server)
- [`LIMIT` / `OFFSET`](02_Sorting_&_Limiting/04_LIMIT_OFFSET.sql) (MySQL / PostgreSQL)

### Basic Data Modification
- [`INSERT`](03_Basic_Data_Modification/01_INSERT.sql)
- [`UPDATE`](03_Basic_Data_Modification/02_UPDATE.sql)
- [`DELETE`](03_Basic_Data_Modification/03_DELETE.sql)
- [Using `WHERE` safely with write operations](03_Basic_Data_Modification/04_Using_WHERE_safely_with_write_operations.sql)

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



