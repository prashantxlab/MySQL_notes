# Understanding PRIMARY KEY in MySQL
Primary Keys and Unique Constraints

## What is a Primary Key?
A Primary Key is a constraint that uniquely identifies each row in a table.

Key Properties
Unique → No duplicate values. 
NOT NULL → Cannot contain NULL. 
One per table → A table can have only one primary key constraint. 
Single or multiple columns → Can be a single-column or composite primary key. 
Identifies rows → Commonly used with an id column. 
Referenced by Foreign Keys → Used to establish relationships between tables. 

Example
```sql
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);
```
Here:
id → PRIMARY KEY → uniquely identifies each user

Composite Primary Key: A composite primary key uses more than one column to uniquely identify a row.
For example, consider an enrollments table:
```sql
CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id)
);
```
Here, the combination of:
student_id + course_id
must be unique.
For example:
student_id    course_id
-----------   ---------
101           10
101           20
102           10
This is valid because each combination is unique.

Add to Existing Table
```sql
ALTER TABLE users
ADD PRIMARY KEY (id);
```
Existing id values must be unique and NOT NULL.

PRIMARY KEY vs UNIQUE

| | PRIMARY KEY | UNIQUE |
|---|---|---|
| Duplicates | ❌ | ❌ |
| NULL | ❌ | ✅ Allowed |
| Per table | 1 | Multiple |
| Purpose | Identify row | Prevent duplicates |

## AUTO_INCREMENT
id INT AUTO_INCREMENT PRIMARY KEY
AUTO_INCREMENT → Automatically generates the ID. 
PRIMARY KEY → Ensures the ID uniquely identifies the row. 

Remember:
PRIMARY KEY = Unique + NOT NULL + Row Identifier.
AUTO_INCREMENT automatically generates a new numeric value when you insert a row without specifying the id.

## PRIMARY KEY vs UNIQUE
Comparing PRIMARY KEY and UNIQUE
Both PRIMARY KEY and UNIQUE prevent duplicate values, but they serve different purposes.

| Feature | PRIMARY KEY | UNIQUE |
|---|---|---|
| Duplicate values | ❌ Not allowed | ❌ Not allowed |
| NULL values | ❌ Not allowed | ✅ Allowed |
| Per table | Only one | Multiple allowed |
| Main purpose | Identify each row | Prevent duplicate values |
| Required | Usually used as row identifier | Optional |

Example
```sql
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) UNIQUE,
    name VARCHAR(100)
);
```
Here:
id    → PRIMARY KEY → Uniquely identifies each user
email → UNIQUE      → Prevents duplicate emails
name  → Normal column

🧠 Remember
PRIMARY KEY = Who is this row?
UNIQUE = Is this value already used?

Important MySQL Point
A UNIQUE constraint can allow NULL values, whereas a PRIMARY KEY cannot.
Also, a table can have only one primary key constraint but multiple UNIQUE constraints.

# Dropping Keys in MySQL
Managing Constraints in MySQL

## Drop a PRIMARY KEY
You can remove the primary key from a table using:
```sql
ALTER TABLE users
DROP PRIMARY KEY;
```
This removes the primary key constraint from the table.
⚠️ If other database objects depend on the primary key, such as a FOREIGN KEY, you may need to handle those dependencies first.

## Drop a UNIQUE Constraint
In MySQL, a UNIQUE constraint is implemented using a unique index. You can remove it using:
```sql
ALTER TABLE users
DROP INDEX email;
```
Here, email is the name of the unique index.

🧠 Important
If the unique constraint was created with a specific name:
```sql
ALTER TABLE users
ADD CONSTRAINT unique_email
UNIQUE (email);
```
you may need to drop the corresponding index name rather than assuming it is email.
You can check the actual index name with:
```sql
SHOW INDEX FROM users;
```

Quick Summary
DROP PRIMARY KEY → Removes the table's primary key
DROP INDEX      → Removes a UNIQUE index/constraint
Remember: A table can have only one PRIMARY KEY, but it can have multiple UNIQUE constraints.

# Auto Increment in MySQL

## AUTO_INCREMENT
AUTO_INCREMENT automatically generates a new numeric value for a column when a new row is inserted.
It is commonly used with a PRIMARY KEY to generate unique IDs.

Example
```sql
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);
```
When inserting:
```sql
INSERT INTO users (name)
VALUES ('Alice'), ('Bob'), ('Charlie');
```
MySQL automatically generates IDs:
id    name
--    -------
1     Alice
2     Bob
3     Charlie

Change the Next Auto-Increment Value
```sql
ALTER TABLE users
AUTO_INCREMENT = 1000;
```
The next generated ID will start from 1000 if that value is greater than the current maximum ID.

⭐ Key Takeaways
PRIMARY KEY → Main identifier of a row. 
UNIQUE → Prevents duplicate values in other columns such as email/phone. 
One table can have only one PRIMARY KEY. 
A table can have multiple UNIQUE constraints. 
AUTO_INCREMENT → Automatically generates numeric IDs. 
Common combination: 
id INT AUTO_INCREMENT PRIMARY KEY

Remember: AUTO_INCREMENT generates the value; PRIMARY KEY ensures that the value uniquely identifies the row.

# Foreign Keys in MySQL
Understanding Relationships Between Tables

## What is a Foreign Key?
A Foreign Key (FK) is a column that creates a link between two tables.
It ensures that a value in one table must match a value in another table.

## Why Use Foreign Keys?
You have a users table. Now you want to store each user’s address. Instead of putting address columns inside the users table, you create a separate addresses table, and link it to users using a foreign key.
Foreign keys help maintain referential integrity — meaning related data stays valid and consistent.

Example
Suppose we have:
users
+----+-------+
| id | name  |
+----+-------+
| 1  | Alice |
| 2  | Bob   |
+----+-------+

We store users' addresses in a separate addresses table:
addresses
+----+---------+---------+
| id | user_id | city    |
+----+---------+---------+
| 1  | 1       | Delhi   |
| 2  | 2       | Mumbai  |
+----+---------+---------+

Here:
users.id       → PRIMARY KEY
addresses.user_id → FOREIGN KEY
addresses.user_id references users.id.

Creating a Foreign Key
```sql
CREATE TABLE addresses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    street VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    pincode VARCHAR(10),
    FOREIGN KEY (user_id)
    REFERENCES users(id)
);
```

How it works
users
  id
  ↓
  ↑
  user_id
addresses

If users.id = 1 exists, this is valid:
```sql
INSERT INTO addresses (user_id, city)
VALUES (1, 'Delhi');
```
But this would normally fail:
```sql
INSERT INTO addresses (user_id, city)
VALUES (999, 'Delhi');
```
because there is no corresponding users.id = 999.

⭐ Important Points
Primary Key → Identifies a row in the parent table. 
Foreign Key → References a key in another table. 
Helps maintain referential integrity. 
A foreign key can contain duplicate values. 
Multiple rows can reference the same parent row. 
The referenced column is typically a PRIMARY KEY or UNIQUE key. 
The FK and referenced column should have compatible data types. 

🧠 Easy Way to Remember
PRIMARY KEY = Parent's identity
FOREIGN KEY = Child's reference to the parent

In this example:
users.id → Parent
addresses.user_id → Child/reference
This is the foundation of relationships between tables in a relational database.

# Managing Foreign Keys in MySQL

## 1. Add a Foreign Key Later
If the FK wasn't created when the table was created:
```sql
ALTER TABLE addresses
ADD CONSTRAINT fk_user
FOREIGN KEY (user_id)
REFERENCES users(id);
```

## 2. Drop a Foreign Key
You must know the foreign key constraint name.
```sql
ALTER TABLE addresses
DROP FOREIGN KEY fk_user;
```
DROP FOREIGN KEY removes the FK constraint; it does not delete the user_id column.

## 3. ON DELETE
ON DELETE defines what happens to child rows when the referenced parent row is deleted.

CASCADE
Automatically deletes related child rows.
```sql
CREATE TABLE addresses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    CONSTRAINT fk_user
    FOREIGN KEY (user_id)
    REFERENCES users(id)
    ON DELETE CASCADE
);
```
Example:
Delete user 1
      ↓
User's addresses are automatically deleted

Other ON DELETE Options

| Option | What happens when parent is deleted? |
|---|---|
| CASCADE | Deletes related child rows |
| SET NULL | Sets FK to NULL |
| RESTRICT | Prevents parent deletion if child rows exist |

SET NULL
```sql
FOREIGN KEY (user_id)
REFERENCES users(id)
ON DELETE SET NULL
```
⚠️ user_id must allow NULL.

RESTRICT
```sql
FOREIGN KEY (user_id)
REFERENCES users(id)
ON DELETE RESTRICT
```
This prevents deleting the parent while related child records exist.
In MySQL/InnoDB, RESTRICT is effectively the default behavior when no ON DELETE action is specified.

⭐ Important Points
Foreign Key → Connects two tables. 
Parent column is usually a PRIMARY KEY or UNIQUE key. 
Child FK values can be duplicated. 
FK values must reference valid parent values, unless the FK is NULL and permitted. 
Use CONSTRAINT fk_name to give the FK a meaningful name. 
ALTER TABLE can add or remove a foreign key. 
ON DELETE controls what happens to child records when a parent is deleted. 

🧠 Easy to Remember
PRIMARY KEY → Identifies the parent row
FOREIGN KEY → References the parent row
ON DELETE   → Defines what happens to the child

Example relationship:
users
  id (PK)
   ↑
   │
user_id (FK)
addresses

This is the core mechanism for maintaining relationships and referential integrity in a relational MySQL database.