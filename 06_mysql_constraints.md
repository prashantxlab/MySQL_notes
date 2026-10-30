# MySQL Constraints
Ensuring Data Accuracy, Validity, and Integrity

## What are Constraints?
Constraints are rules applied to columns in a MySQL table to control what data can be stored.
They help maintain:
Accuracy → Prevent incorrect data. 
Validity → Ensure data follows defined rules. 
Integrity → Keep data consistent and reliable. 

## Why are Constraints Used?
For example, suppose we have:
users
+----+-------+------------------+
| id | name  | email            |
+----+-------+------------------+
| 1  | Alice | alice@example.com|
+----+-------+------------------+
We don't want:
Two users having the same id. 
Two users having the same email if email must be unique. 
A user having no name if a name is required. 
An invalid date being inserted. 
A column to be empty when it is required. 
Constraints allow MySQL to automatically enforce these rules.

## 1. UNIQUE Constraint
The UNIQUE constraint ensures that all non-NULL values in a column are different.
During Table Creation
```sql
CREATE TABLE users (
    id INT PRIMARY KEY,
    email VARCHAR(100) UNIQUE
);
```
Here, two users cannot have the same email.

Add UNIQUE Using ALTER TABLE
```sql
ALTER TABLE users
ADD CONSTRAINT unique_email
UNIQUE (email);
```
unique_email is the name of the constraint.

🧠 Important
UNIQUE prevents duplicate values, but it does not by itself prevent NULL values.
If the column must also have a value, use:
email VARCHAR(100) UNIQUE NOT NULL

## 2. NOT NULL Constraint
NOT NULL ensures that a column cannot contain NULL.
During Table Creation
```sql
CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);
```
A user must have a value for name.

Change an Existing Column to NOT NULL
```sql
ALTER TABLE users
MODIFY COLUMN name VARCHAR(100) NOT NULL;
```

Make a Column Nullable Again
```sql
ALTER TABLE users
MODIFY COLUMN name VARCHAR(100) NULL;
```

🧠 Important
NULL means missing/unknown value. It is not the same as:
0
''
'NULL'

## 3. CHECK Constraint
CHECK ensures that values satisfy a specific condition.
Example
Suppose users must have a date of birth after January 1, 2000:
```sql
ALTER TABLE users
ADD CONSTRAINT chk_dob
CHECK (date_of_birth > '2000-01-01');
```
MySQL will reject a value that violates this condition.
`02:42:18	alter table users add constraint chk_dob check (date_of_birth > '2000-01-01')	Error Code: 3819. Check constraint 'chk_dob' is violated.	0.031 sec`
This error means your existing data violates the CHECK condition. Your query syntax is correct.

Why Name the Constraint?
Here:
chk_dob
is the constraint name.
Naming constraints makes it easier to identify or remove the constraint later.
For example:
```sql
ALTER TABLE users
DROP CHECK chk_dob;
```

## 4. DEFAULT Constraint
DEFAULT provides a default value when no value is supplied during INSERT.
During Table Creation
```sql
CREATE TABLE users (
    id INT PRIMARY KEY,
    is_active BOOLEAN DEFAULT TRUE
);
```
If you insert a user without specifying is_active, MySQL uses:
TRUE

Add/Change a Default Using ALTER TABLE
```sql
ALTER TABLE users
ALTER COLUMN is_active
SET DEFAULT TRUE;
```

🧠 Example
```sql
INSERT INTO users (id)
VALUES (1);
```
Because is_active wasn't provided, MySQL uses its default:
is_active = TRUE

Important: DEFAULT does not mean the column must have a value. It only provides a value when one isn't supplied.

## 5. PRIMARY KEY Constraint
A PRIMARY KEY uniquely identifies each row in a table.
```sql
CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);
```
Here, id identifies each user.

Primary Key Rules
A primary key:
Must contain unique values. 
Cannot contain NULL. 
A table can have only one primary key constraint. 
The primary key can consist of one or multiple columns. 

Add Primary Key Later
```sql
ALTER TABLE users
ADD PRIMARY KEY (id);
```

🧠 Example
id    name
---   ------
1     Alice
2     Bob
3     Charlie
Each id uniquely identifies a user.
You cannot have:
1    Alice
1    Bob
because the primary key would be duplicated.

⭐ PRIMARY KEY vs UNIQUE
These are easy to confuse.

| Feature | PRIMARY KEY | UNIQUE |
|---|---|---|
| Duplicate values | ❌ Not allowed | ❌ Not allowed |
| NULL | ❌ Not allowed | ✅ Allowed |
| Number per table | One | Multiple |
| Main purpose | Identify each row | Prevent duplicate values |

Example
```sql
CREATE TABLE users (
    id INT PRIMARY KEY,
    email VARCHAR(100) UNIQUE
);
```
Here:
id     → Identifies the user
email  → Prevents duplicate emails

## 🔥 Combining Constraints
You can apply multiple constraints to the same column.
For example:
```sql
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    salary DECIMAL(10,2) CHECK (salary >= 0),
    is_active BOOLEAN DEFAULT TRUE
);
```
Here:

| Column | Constraints | Purpose |
|---|---|---|
| id | PRIMARY KEY, AUTO_INCREMENT | Unique user ID |
| name | NOT NULL | Name is required |
| email | NOT NULL, UNIQUE | Email is required and cannot duplicate |
| salary | CHECK | Salary cannot be negative |
| is_active | DEFAULT | Defaults to TRUE |

🧠 MySQL Constraints — Quick Summary

| Constraint | Purpose |
|---|---|
| PRIMARY KEY | Uniquely identifies each row |
| UNIQUE | Prevents duplicate values |
| NOT NULL | Prevents NULL values |
| CHECK | Ensures a condition is satisfied |
| DEFAULT | Provides a default value |
| FOREIGN KEY | Maintains a relationship between tables |

One important addition: FOREIGN KEY
You haven't covered this in the screenshots, but it is a major MySQL constraint and you should learn it next.
A FOREIGN KEY is used to connect one table to another and maintain referential integrity.
For example:
```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
```
Here:
users.id       → Primary Key
orders.user_id → Foreign Key
This means an orders.user_id should reference an existing users.id.

🎯 The easiest way to remember constraints
PRIMARY KEY → Who is this row?
UNIQUE      → No duplicates
NOT NULL    → Value is required
CHECK       → Value must follow a rule
DEFAULT     → Use this value if none is provided
FOREIGN KEY → Connect this table to another table

These constraints are important because the database itself enforces the rules, rather than relying entirely on the application to validate every piece of data.