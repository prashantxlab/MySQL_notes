# UPDATE — Modifying Existing Data
Changing Values in Existing Rows

The UPDATE statement is used to modify existing data in a table.

## Basic Syntax
SQL SYNTAX
```sql
UPDATE table_name SET column1 = value1, column2 = value2 WHERE condition;
```

## Update One Column
To change the name of the user whose id is 1:
SQL COMMAND
```sql
UPDATE users SET name = 'Alicia' WHERE id = 1;
```
This changes the name of the user with id = 1 to Alicia.

## Update Multiple Columns
You can update multiple columns of a row using a single UPDATE statement.
SQL COMMAND
```sql
UPDATE users SET name = 'Robert', email = 'robert@example.com' WHERE id = 2;
```
This changes both the name and email of the user whose id = 2.

## Update Multiple Rows
The UPDATE statement can modify multiple rows when the WHERE condition matches multiple records.
SQL COMMAND
```sql
UPDATE users SET gender = 'Other' WHERE salary > 70000;
```
This changes the gender to Other for all users whose salary is greater than 70,000.

## Without WHERE Clause ⚠️
If you don't specify a WHERE clause, all rows in the table will be updated.
SQL COMMAND
```sql
UPDATE users SET gender = 'Other';
```
This changes the gender of every user in the users table to Other.
⚠️ Always be careful when using UPDATE without a WHERE clause, as it can modify the entire table.

🧠 Quick Summary
UPDATE → Modify existing data
SET    → Specify the new value
WHERE  → Specify which rows to modify

Example:
```sql
UPDATE users SET salary = 80000 WHERE id = 5;
```
This changes the salary of the user with id = 5 to 80,000.

Increase salary by 10000 for all the users whose salary is less than 60000
SQL COMMAND
```sql
UPDATE users SET salary = salary + 10000 WHERE salary < 60000;
```
Upon running this query MySQL troughed an error:
`23:37:38	update users set salary = salary+10000 where salary<60000	Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.	0.000 sec`
MySQL Workbench's Safe Updates mode prevents UPDATE or DELETE statements when the WHERE clause does not use a key column.
Workbench blocks the query to protect you from accidentally modifying a large number of rows.
To disable Safe Update Mode for the current session: `SET SQL_SAFE_UPDATES = 0;`
Similarly, to enable the Safe Update Mode for the current session: `SET SQL_SAFE_UPDATES = 1;`

# DELETE — Removing Data from a Table
Deleting Rows from Tables

The DELETE statement is used to remove existing rows from a table.

## Basic Syntax
SQL SYNTAX
```sql
DELETE FROM table_name
WHERE condition;
```
DELETE FROM → Specifies the table from which rows should be removed. 
WHERE → Specifies which rows should be deleted. 

## Delete One Row
To delete the user whose id is 3:
SQL COMMAND
```sql
DELETE FROM users WHERE id = 3;
```
This deletes only the row where id = 3.

To delete the users whose salary is less than 6000
SQL COMMAND
```sql
DELETE FROM users WHERE salary < '60000';
```

To fetch the data from users table based on there salary and arrange them in ascending order
SQL COMMAND
```sql
SELECT * FROM users ORDER BY salary ASC;
```

## Delete Multiple Rows
The WHERE condition can match multiple rows.
SQL COMMAND
```sql
DELETE FROM users WHERE gender = 'Other';
```
This deletes all users whose gender is Other.

## Delete Using Multiple Conditions
You can combine conditions using AND or OR.
SQL COMMAND
```sql
DELETE FROM users WHERE gender = 'Female' AND salary < 50000;
```
This deletes users who are Female AND have a salary below 50,000.

## Delete All Rows ⚠️
If you omit the WHERE clause, all rows in the table will be deleted.
SQL COMMAND
```sql
DELETE FROM users;
```
⚠️ The table itself remains, but all records are removed.
You can verify the result using:
```sql
SELECT * FROM users;
```

## DELETE vs DROP vs TRUNCATE
These commands are different:

| Command | What it does |
|---|---|
| DELETE | Removes rows from a table |
| TRUNCATE | Removes all rows from a table |
| DROP TABLE | Removes the entire table, including its structure |

DELETE
```sql
DELETE FROM users
WHERE id = 3;
```
Removes selected rows.

TRUNCATE
```sql
TRUNCATE TABLE users;
```
Removes all rows but keeps the table structure.

DROP
```sql
DROP TABLE users;
```
Removes the entire users table.

⚠️ Important Safety Point
Always check your WHERE condition before executing a DELETE.
For example:
```sql
DELETE FROM users
WHERE gender = 'Other';
```
could delete many rows, not just one.

A good practice is to first run the equivalent SELECT:
```sql
SELECT * FROM users WHERE gender = 'Other';
```
Check which rows will be affected, and then execute the DELETE.

🧠 Quick Summary
DELETE FROM users WHERE ... → Delete specific rows
DELETE FROM users           → Delete all rows
TRUNCATE TABLE users        → Remove all rows, keep table
DROP TABLE users            → Remove the entire table

Key point: DELETE removes data/rows, while DROP removes the table itself.