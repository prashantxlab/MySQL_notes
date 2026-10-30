# MySQL

## What is SQL?
Structured Query Language is a programming language for storing and processing information in a relational database.
A relational database stores information in tabular form, with rows and columns representing different data attributes and the various relationship between the data values.
We can use SQL statements to store, update, remove, search and retrieve information from the database.
We can also use SQL to maintain and optimize database performance.
Data retrieval: SQL allows for quick and powerful data retrieval and manipulation.
Data Analysis: It is widely used in data analysis and reporting.
Database Management: SQL is essential for managing and maintaining databases.
Cross-Industry Usage: It is used across multiple industries.

## What is a Database?
A database is an organized collection of data, stored so it can be easily accessed and managed.
CRUD: CRUD stands for the four basic operations performed on data in a database: CREATE, READ, UPDATE, DELETE. This is a primary operation performed in a DB.

## What is a DBMS?
DBMS (Database Management System) is software used to create, store, manage, retrieve, and modify data in a database. Eg: MySQL, PostgreSQL, Oracle Database.
A company stores employee information in a database. A DBMS allows applications/users to perform CRUD operations.
DBMS = Software that manages databases and provides a way for users/applications to interact with stored data.

## What is difference between Relational DB and Non-Relational DB?
A Relational Database stores data in tables consisting of rows and columns. Tables can be related to each other using keys such as primary keys and foreign keys. Eg: MySQL, PostgreSQL, Oracle.

Users
+---+-------+-----------------+
| ID | Name | Email |
+---+-------+-----------------+
| 1 | Rahul | rahul@gmail.com |
+---+-------+-----------------+

A Non-Relational Database does not require data to be stored in traditional tables. It can store data as documents, key-value pairs, graphs, or columns, depending on the database. Eg: MongoDB, Redis, Cassandra, Neo4j

JSON
```json
{
"id": 1,
"name": "Rahul",
"email": "rahul@gmail.com"
}
```

## Key Concepts of SQL:
Database: A collection of data organized in a structured way.
Table: A set of rows and columns where the data is stored. Each column in a table represents a specific attribute, and each row represents a record.
SQL Queries: SQL statements are used to interact with the data in the database. A SQL query is like command to the database that end user gives. Common types of SQL queries include:
SELECT: Retrieves data from a database.
INSERT: Adds a new data into a database.
UPDATE: Modifies existing data.
DELETE: Removes data from the database.

SQL Clauses: 
WHERE: Used to filter records based on specific conditions.
ORDER BY: Sorts the results set in ascending or descending order.
GROUP BY: Groups rows that have the same values into summary rows.
HAVING: Filters the results after GROUP BY clause.

SQL Constrains: Constraints are used to define rules for the data in a table:
PRIMARY KEY: Uniquely identifies each record in a table.
FOREIGN KEY: A field that links to the primary key of another table.
NOT NULL: Ensures that a column cannot have a NULL value.
UNIQUE: Ensures that all values in a column are different.

Data Types: In DB it defines what kind of value a column can store. Data type tells MySQL what kind of data a column is allowed to store.

| Category | Data Type | What it stores | Example |
|---|---|---|---|
| Numeric | INT | Whole numbers | 10, 250, -5 |
| Numeric | BIGINT | Very large whole numbers | 9223372036854775807 |
| Numeric | DECIMAL(p,s) | Exact decimal numbers | 12500.50 |
| Numeric | FLOAT | Approximate decimal numbers | 12.5 |
| Numeric | DOUBLE | Larger-range approximate decimal numbers | 12345.6789 |
| String | CHAR(n) | Fixed-length text | 'IN' |
| String | VARCHAR(n) | Variable-length text | 'Prashant' |
| String | TEXT | Large amounts of text | 'Long description...' |
| Date & Time | DATE | Date only | '2026-09-20' |
| Date & Time | TIME | Time only | '14:30:00' |
| Date & Time | DATETIME | Date + time | '2026-09-20 14:30:00' |
| Date & Time | TIMESTAMP | Date + time, commonly used for timestamps | '2026-09-20 14:30:00' |
| Boolean | BOOLEAN | True/false value | TRUE, FALSE |
| Enumeration | ENUM | One value from a predefined list | 'Male' |
| JSON | JSON | JSON-formatted data | '{"id":1}' |
| Binary | BLOB | Binary/large binary data | Images/files |

Example: 
```sql
create database startersql;
use startersql;
create table users (id int auto_increment primary key, 
name varchar(100) not null, 
email varchar(100) unique not null, 
gender enum('Male', 'Female', 'Others'), 
date_of_birth Date, 
created_at timestamp default current_timestamp);
select * from users;
```
we can save the queries that we have used by file > save script > give the name. If we want to save another script with another name file > save script as > give another name.