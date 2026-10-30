# MySQL Notes

Self-taught MySQL notes, written while learning SQL for data engineering. Every file is one block of the learning path, from SQL basics to triggers. Examples use a `users` table in a database called `startersql`.

## Index

| # | File | What's inside |
|---|---|---|
| 01 | [01_mysql_basics.md](01_mysql_basics.md) | SQL, database, DBMS, key concepts, data types |
| 02 | [02_data_types_and_table_operations.md](02_data_types_and_table_operations.md) | More data types, SELECT basics, rename table, ALTER TABLE |
| 03 | [03_inserting_and_querying_data.md](03_inserting_and_querying_data.md) | INSERT, SELECT, WHERE, custom ORDER BY |
| 04 | [04_filtering_and_pattern_matching.md](04_filtering_and_pattern_matching.md) | NULL, BETWEEN, AND / OR, IN, LIKE, LIMIT |
| 05 | [05_updating_and_deleting_data.md](05_updating_and_deleting_data.md) | UPDATE, DELETE, DELETE vs TRUNCATE vs DROP |
| 06 | [06_mysql_constraints.md](06_mysql_constraints.md) | UNIQUE, NOT NULL, CHECK, DEFAULT, PRIMARY KEY |
| 07 | [07_sql_functions.md](07_sql_functions.md) | Aggregate, string, date, math and conditional functions |
| 08 | [08_transactions_and_autocommit.md](08_transactions_and_autocommit.md) | AutoCommit, COMMIT, ROLLBACK, START TRANSACTION |
| 09 | [09_primary_keys_and_auto_increment.md](09_primary_keys_and_auto_increment.md) | Primary key, AUTO_INCREMENT, foreign keys, ON DELETE |
| 10 | [10_joins_and_unions.md](10_joins_and_unions.md) | INNER / LEFT / RIGHT JOIN, UNION, self join |
| 11 | [11_views_indexes_subqueries_grouping.md](11_views_indexes_subqueries_grouping.md) | Views, indexes, subqueries, GROUP BY, HAVING |
| 12 | [12_procedures_triggers_and_misc.md](12_procedures_triggers_and_misc.md) | Stored procedures, triggers, extra operators and commands |

---

## Topics inside each file

### 01. MySQL Basics
- What is SQL?
- What is a Database? (CRUD)
- What is a DBMS?
- Relational vs Non-Relational databases
- Key concepts: tables, queries (SELECT / INSERT / UPDATE / DELETE), clauses (WHERE / ORDER BY / GROUP BY / HAVING), constraints
- Data types table (numeric, string, date & time, boolean, enum, JSON, binary)
- Example: create database and `users` table
- Saving scripts in Workbench

### 02. Data Types & Table Operations
- More data types (TIMESTAMP, BOOLEAN, DECIMAL)
- Constraints explained (AUTO_INCREMENT, PRIMARY KEY, NOT NULL, UNIQUE, DEFAULT)
- Selecting all / specific columns
- Renaming a table
- ALTER TABLE: add, drop (single and multiple), modify, move column (FIRST / AFTER), add multiple, rename column

### 03. Inserting & Querying Data
- INSERT: without column names, with column names (recommended), multiple rows
- Practice scripts (`01_createusertable.sql`, `02_insertdata.sql`)
- SELECT basics and `SELECT *`
- WHERE with `=`, `!=`/`<>`, `>`, `<`, `>=`, `<=`
- Custom ORDER BY with CASE
- Operator summary table

### 04. Filtering & Pattern Matching
- Working with NULL (IS NULL / IS NOT NULL)
- BETWEEN
- AND, OR
- ORDER BY + LIMIT
- IN
- LIKE and wildcards (`%`, `_`)
- AND / OR / IN summary

### 05. Updating & Deleting Data
- UPDATE: one column, multiple columns, multiple rows, without WHERE
- Safe Update Mode (error 1175)
- DELETE: one row, multiple rows, multiple conditions, all rows
- DELETE vs DROP vs TRUNCATE
- Safety tip: SELECT before DELETE

### 06. MySQL Constraints
- Why constraints are used
- UNIQUE
- NOT NULL
- CHECK
- DEFAULT
- PRIMARY KEY and PRIMARY KEY vs UNIQUE
- Combining constraints
- Quick summary and FOREIGN KEY preview

### 07. SQL Functions
- Aggregate: COUNT, MIN / MAX, SUM, AVG, GROUP BY
- String: LENGTH, LOWER / UPPER, CONCAT
- Date: NOW, YEAR / MONTH / DAY, DATEDIFF, TIMESTAMPDIFF
- Math: ROUND, FLOOR, CEIL, MOD
- Conditional: IF()
- AS (column alias)
- Aggregate vs scalar functions, function summary table

### 08. Transactions & AutoCommit
- What is a transaction?
- AutoCommit: check, disable, enable
- COMMIT and ROLLBACK
- START TRANSACTION
- Multiple operations in one transaction
- Limits of ROLLBACK, InnoDB dependency
- Best practices

### 09. Primary Keys, Auto Increment & Foreign Keys
- Primary key, composite primary key
- PRIMARY KEY vs UNIQUE
- Dropping keys (PRIMARY KEY, UNIQUE)
- AUTO_INCREMENT (and changing the next value)
- Foreign keys: what, why, create
- Managing foreign keys: add later, drop
- ON DELETE: CASCADE, SET NULL, RESTRICT

### 10. Joins & Unions
- What is a JOIN?
- INNER JOIN, LEFT JOIN, RIGHT JOIN, comparison
- UNION vs UNION ALL, UNION rules, fixed values, ORDER BY with UNION
- Self JOIN (referral example with `referred_by_id`)

### 11. Views, Indexes, Subqueries & Grouping
- Views: create, live updates, drop
- Indexes: view, single-column, multi-column, column order, drop
- Subqueries: scalar, IN, in SELECT, in FROM
- GROUP BY with COUNT
- HAVING, WHERE vs HAVING
- ROLLUP

### 12. Procedures, Triggers & Misc
- Stored procedures: DELIMITER, IN parameters, CALL, view, drop
- Triggers: structure, log-table example, NEW and OLD, BEFORE vs AFTER, drop
- More on MySQL: logical operators (AND / OR / NOT), add a column, wildcards, LIMIT with OFFSET, DISTINCT, TRUNCATE, CHANGE vs MODIFY

---

## Suggested learning path

```
Basics (01-02) → Insert & Query (03-04) → Modify data (05) → Rules (06, 09)
      → Analysis (07, 11) → Multi-table (10) → Safety (08) → Automation (12)
```

## Quick setup

1. Install MySQL and MySQL Workbench.
2. Run `01_createusertable.sql` to create the database and tables.
3. Run `02_insertdata.sql` to load dummy users.
4. Check with `SELECT * FROM users;`
