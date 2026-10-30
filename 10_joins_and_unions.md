# SQL JOINs in MySQL

## What is a JOIN?
A JOIN combines rows from two or more tables using related columns. Usually a foreign key in one table references a primary key in another.
In our example:
users.id       → Primary Key
addresses.user_id → Foreign Key
So we can connect users with their addresses.

## 1. INNER JOIN
INNER JOIN returns only rows that have a match in both tables.
SQL Query
```sql
SELECT users.name, addresses.city
FROM users
INNER JOIN addresses
ON users.id = addresses.user_id;
```
Result
name     city
-------  --------
Aarav    Mumbai
Sneha    Kolkata
Raj is excluded because he doesn't have a matching address.
The address with user_id = 4 is also excluded because there is no matching users.id = 4.

🧠 Remember
INNER JOIN
     ↓
Only matching rows

## 2. LEFT JOIN
LEFT JOIN returns all rows from the left table and matching rows from the right table.
If there is no match, MySQL returns NULL for the right-table columns.
SQL Query
```sql
SELECT users.name, addresses.city
FROM users
LEFT JOIN addresses
ON users.id = addresses.user_id;
```
Result
name     city
-------  --------
Aarav    Mumbai
Sneha    Kolkata
Raj      NULL
Raj is included even though he doesn't have an address.

🧠 Remember
LEFT JOIN
     ↓
All LEFT table rows
+
Matching RIGHT rows

## 3. RIGHT JOIN
RIGHT JOIN returns all rows from the right table and matching rows from the left table.
SQL Query
```sql
SELECT users.name, addresses.city
FROM users
RIGHT JOIN addresses
ON users.id = addresses.user_id;
```
Result
name     city
-------  --------
Aarav    Mumbai
Sneha    Kolkata
NULL     Delhi
The Delhi address is included even though its user_id = 4 doesn't exist in users.

🧠 Remember
RIGHT JOIN
     ↓
All RIGHT table rows
+
Matching LEFT rows

⭐ JOIN Comparison

| JOIN | Returns |
|---|---|
| INNER JOIN | Only matching rows from both tables |
| LEFT JOIN | All left rows + matching right rows |
| RIGHT JOIN | All right rows + matching left rows |

Visual Memory
INNER JOIN → Matching only
LEFT JOIN  → ALL LEFT + matching RIGHT
RIGHT JOIN → ALL RIGHT + matching LEFT

Important JOIN Syntax
The most important part is:
ON users.id = addresses.user_id
This tells MySQL how the two tables are related.

General syntax:
```sql
SELECT columns
FROM table1
JOIN table2
ON table1.column = table2.column;
```

⭐ Key Concept
users.id
   ↑
   │ relationship
   ↓
addresses.user_id
So:
JOIN combines data; ON tells MySQL which rows are related.

# SQL UNION and UNION ALL

## What is UNION?
UNION combines the result sets of two or more SELECT queries into one result.
```sql
SELECT name FROM users
UNION
SELECT name FROM admin_users;
```

## UNION vs UNION ALL

| Operator | Behavior |
|---|---|
| UNION | Combines results and removes duplicates |
| UNION ALL | Combines results and keeps duplicates |

Example:
```sql
SELECT name FROM users
UNION ALL
SELECT name FROM admin_users;
```

Rules of UNION ⭐
The SELECT statements must have:
Same number of columns 
Corresponding columns with compatible data types 
Columns in the same logical order 

✅ Valid:
```sql
SELECT name, salary FROM users
UNION
SELECT name, salary FROM admin_users;
```

❌ Invalid:
```sql
SELECT name, salary FROM users
UNION
SELECT name FROM admin_users;
```
because the number of columns doesn't match.

## UNION with Multiple Columns
You can combine multiple columns:
```sql
SELECT name, salary
FROM users
UNION
SELECT name, salary
FROM admin_users;
```
The first SELECT determines the column names of the final result.

## Adding a Fixed Value
You can add a value to identify where each row came from:
```sql
SELECT name, 'User' AS role
FROM users
UNION
SELECT name, 'Admin' AS role
FROM admin_users;
```
Example result:
name        role
----------  ------
Alice       User
Bob         User
Raj         Admin

## ORDER BY with UNION
ORDER BY is normally placed at the end of the complete UNION query:
```sql
SELECT name FROM users
UNION
SELECT name FROM admin_users
ORDER BY name;
```
This sorts the combined result, not each individual SELECT.

## When to Use UNION
Use UNION when you need to combine results from:
Similar tables 
Current and archived data 
Multiple filtered queries 
Different sources with a common result structure 

🧠 Easy Way to Remember
UNION
  ↓
Combine results
  ↓
Remove duplicates

UNION ALL
  ↓
Combine results
  ↓
Keep duplicates

Example
If:
users        → Alice, Bob
admin_users  → Bob, Charlie

UNION gives:
Alice
Bob
Charlie

UNION ALL gives:
Alice
Bob
Bob
Charlie

Key difference: UNION performs duplicate elimination; UNION ALL does not. Because of that, UNION ALL is generally preferable when duplicates are intentionally valid and you don't need duplicate removal.

# Self JOIN in MySQL

## What is a Self JOIN?
A Self JOIN is when a table is joined with itself.
This is useful when rows in the same table are related to each other. For example, when users refer other users, and we store the ID of the person who referred them in the same users table. users
--------------------------------
id   name      referred_by_id
1    Aarav     NULL
2    Sneha     1
3    Raj       1
4    Fatima    2
Here, referred_by_id stores the id of another user.

## 1. Add referred_by_id:  
We’ll extend the existing users table to include a column called referred_by_id , which holds the id of the user who referred them.This column: 
Will be NULL for users who were not referred. 
Will contain the id of another user who referred them.
```sql
ALTER TABLE users
ADD COLUMN referred_by_id INT;
```
NULL → User was not referred by anyone. 
1 → User was referred by the user whose id = 1. 

## 2. Add Referral Data: 
Assuming id = 1 is the first user, and referred others:
```sql
UPDATE users
SET referred_by_id = 1
WHERE id IN (2, 3);
```
```sql
UPDATE users
SET referred_by_id = 2
WHERE id = 4;
```
Meaning:
User 1 → referred Users 2 and 3
User 2 → referred User 4

## 3. Perform a Self JOIN: Getting Referrer Information
```sql
SELECT
    a.id,
    a.name AS user_name,
    b.name AS referred_by
FROM users a
LEFT JOIN users b
ON a.referred_by_id = b.id;
```
Result
id   user_name   referred_by
--   ----------  -----------
1    Aarav       NULL
2    Sneha       Aarav
3    Raj         Aarav
4    Fatima      Sneha

How it works
users a → User being displayed
users b → User who referred them
a.referred_by_id = b.id
The aliases a and b represent two instances of the same users table.

⭐ Important Points
Use Self JOIN when you need to join a table with itself.
In referral-based relationships, store the referrer’s id in the same table.
Use aliases like a and b to differentiate the two instances of the same table.
Self JOIN is commonly used in employee-manager structures, referral systems, and hierarchical data.

🧠 Easy Way to Remember
Normal JOIN: Table A ↔ Table B
Self JOIN: Table A ↔ Table A

users a
   │
   │ referred_by_id = id
   ↓
users b

Key idea: The table is the same, but the two aliases represent different roles.