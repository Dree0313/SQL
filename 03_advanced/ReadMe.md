# Tier 3: Advanced — Professional Engineer Level

## Purpose
This section focuses on performance, correctness under load, and real-world operational behavior of SQL systems.

The goal is to move beyond "does this query work" and begin thinking in terms of:
- How queries behave at scale
- How concurrent users affect data correctness
- How database design choices impact performance and reliability
- How SQL fits into larger production systems

---

## Concepts Covered

### Window Functions & Analytical Queries
- Window functions vs aggregate functions
- `LAG`, `LEAD`
- Ranking functions (`RANK`, `DENSE_RANK`, `ROW_NUMBER`)
- Partitioning result sets with `OVER (PARTITION BY ...)`
- Running totals, moving averages, and time-based analysis
- When window functions replace subqueries or self-joins

### Query Optimization & Performance
- Understanding why two "correct" queries can have very different performance
- Avoiding unnecessary scans and computations
- Reducting data movement and intermediate result sizes
- Recognizing anti-patterns (overuse of subqueries, SELECT *)
- Writing SQL with the optimizer in mind

### Execution Plans
- Reading and interpreting execution plans
- Sequential scans vs index scans
- Join algorithms (nested loop, hash join, merge join)
- Cost estimates vs actual execution behavior
- Identifying bottlenecks in real queries
- Knowing when the optimizer is wrong and why

### Index Strategies
- Single-column vs composite indexes
- Index selectivity and cardinality
- Covering indexes
- When indexes help vs hurt
- Index maintenance costs on write-heavy systems
- Indexing for joins, filterrs, and sorting
- Understanding how indexes affect execution plans

### Transaction & Isolation Levels
- What a transaction actually guarantees
- ACID properties in practice
- Autocommit vs explicit transactions
- Isolation levels:
  - Read Uncommitted
  - Read Committed
  - Repeatable Read
  - Serializable
- Tradeoffs between consistency and concurrency
- Preventing partial updates and data corruption
- `TRUNCATE`

### Locks & Concurrency
- How databases prevent conflicting writes
- Shared vs exclusive locks
- Row-level vs table-level locking
- Deadlocks: why they happen and how to avoid them
- Blocking vs non-blocking reads
- Writing queries that behave correctly under concurrent access

### Stored Procedures & Triggers
- Encapsulating logic inside the database
- Stored procedures vs application-layered logic
- Triggeres for enforcing business rules
- Risks of hidden logic and side effects
- When database logic improves safety
- When it becomes a maintenance liability

### Patitioning & Large Datasets
- Horizontal partitioning strategies
- Partitioning by date, range, or key
- How partitioning affects query planning
- Pruning partitions for performance
- Tradeoffs between complexity and scalability
- Managing historical vs active data

### Denormalization Tradeoffs
- When normalization becomes a performance problem
- Strategic duplication for read-heavy workloads
- Balancing write complexity vs read speed
- Preventing data drift and inconsistency
- Documenting denormalization assumptions
- Understanding why a system breaks normalizaiton rules

---

## Expected Outcome
After completing this tier, I should be able to:
- Write SQL that is correct and performant at scale
- Diagnose slow queries using execution plans
- Design indexing strategies aligned with access patterns
- Reason about concurrency, locking, and isolation issues
- Use advanced SQL features for analytics and reporting
- Make informed tradeoffs between correctness, speed, and complexity
- Think like a database-aware software engineer, not just a query writer



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

