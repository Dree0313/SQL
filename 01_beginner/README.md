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
- [`DISTINCT`](01_Core_Query/04_DISTINCT.sql)
- [Aliases (`AS`)](01_Core_Query/05_Aliases_(AS).sql)

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
- [`COUNT`](04_Simple_Aggregations/01_COUNT.sql)
- [`SUM`](04_Simple_Aggregations/02_SUM.sql)
- [`MIN`](04_Simple_Aggregations/03_MIN.sql)
- [`MAX`](04_Simple_Aggregations/04_MAX.sql)
- [`AVG`](04_Simple_Aggregations/05_AVG.sql)

### Basic Filtering Logic
- [Comparison operators (`=`, `!=`, `<`, `>`, `<=`, `>=`)](05_Basic_Filtering_Logic/01_Comparison_operators_(=,_!=,_<,_>,_<=,_>=).sql)
- [Logical operators (`AND`, `OR`)](05_Basic_Filtering_Logic/02_Logical_operators_(AND,_OR).sql)
- [`IN`](05_Basic_Filtering_Logic/03_IN.sql)
- [`BETWEEN`](05_Basic_Filtering_Logic/04_BETWEEN.sql)
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



