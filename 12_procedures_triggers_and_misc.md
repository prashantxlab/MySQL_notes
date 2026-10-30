# Stored Procedures in MySQL
Reusable SQL Blocks and Procedures

## What is a Stored Procedure?
A Stored Procedure is a group of SQL commands saved in the database that you can run whenever you need it.
Instead of writing the same SQL commands again and again, you can save them as a procedure and simply call it.

## Why use Stored Procedures?
Reuse the same SQL logic. 
Reduce repeated SQL code. 
Perform multiple operations together. 
Procedures are stored in the database. 

## 1. DELIMITER
By default, MySQL uses ; to end SQL statements. But when defining stored procedures, we use ; inside the procedure as well. This can confuse MySQL. To avoid this, we temporarily change the delimiter (e.g. to $$ or // ) while creating the procedure.
SQL COMMAND
```sql
DELIMITER $$
CREATE PROCEDURE procedure_name()
BEGIN
    -- SQL statements go here
END$$
DELIMITER ;
```
Explanation:
DELIMITER $$  → Temporarily changes the ending symbol
CREATE PROCEDURE → Creates the procedure
BEGIN          → Starts the SQL commands
END$$          → Ends the procedure
DELIMITER ;    → Changes it back to normal
⭐ DELIMITER does not change the database. It only tells MySQL Workbench what symbol marks the end of the complete procedure.

## 2. Create a Procedure with Input Parameters
A procedure can accept information from you using input parameters.
Let’s say you want to create a stored procedure that inserts a new user into the users table.
Example: Add a New User
SQL COMMAND
```sql
DELIMITER $$
CREATE PROCEDURE AddUser(
    IN p_name VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_gender ENUM('Male', 'Female', 'Other'),
    IN p_dob DATE,
    IN p_salary INT
)
BEGIN
    INSERT INTO users
        (name, email, gender, date_of_birth, salary)
    VALUES
        (p_name, p_email, p_gender, p_dob, p_salary);
END$$
DELIMITER ;
```
Explanation:
Here, the procedure is named:
AddUser
It accepts 5 values:
p_name
p_email
p_gender
p_dob
p_salary
These values are then inserted into the users table.

## 3. Calling a Stored Procedure
After creating a procedure, use CALL to run it.
SQL COMMAND
```sql
CALL AddUser(
    'Kiran Sharma',
    'kiran@example.com',
    'Female',
    '1994-06-15',
    72000
);
```
Explanation:
This runs the AddUser procedure and inserts the given information into the users table.

Easy Flow
Create Procedure
       ↓
Give Input Values
       ↓
CALL Procedure
       ↓
SQL commands execute
       ↓
Data is inserted/updated/etc.

## 4. View Stored Procedures
To see the procedures in a database:
SQL COMMAND
```sql
SHOW PROCEDURE STATUS
WHERE Db = 'startersql';
```
This shows the stored procedures belonging to the startersql database.

## 5. Delete a Stored Procedure
If you no longer need a procedure:
SQL COMMAND
```sql
DROP PROCEDURE IF EXISTS AddUser;
```
Explanation:
This removes the AddUser procedure from the database.
IF EXISTS prevents an error if the procedure does not exist.

⭐ Important Points
Stored Procedure = Saved SQL commands that can be reused. 
CREATE PROCEDURE → Creates a new procedure. 
CALL → Runs a procedure. 
DROP PROCEDURE → Removes a procedure. 
IN → Used to receive input values. 
BEGIN ... END → Contains the SQL commands of the procedure. 
DELIMITER → Temporarily changes how MySQL recognizes the end of the procedure. 
Stored procedures are saved inside the database. 

🧠 Easy Way to Remember
CREATE PROCEDURE → Make it
CALL              → Run it
DROP PROCEDURE    → Delete it

Real-world example
Imagine you frequently need to add a new employee:
Without a procedure:
Write INSERT query
↓
Change values
↓
Run it
↓
Repeat again

With a procedure:
Create AddUser once
       ↓
CALL AddUser(...)
       ↓
New user added
Think of a stored procedure as a saved SQL function that you can call whenever you need it.

# Triggers in MySQL
Automatically Executed Database Events

## What is a Trigger?
A trigger is a special type of stored program that is automatically executed when a specific event occurs in a table, such as INSERT , UPDATE , or DELETE . 
It can run when you:
INSERT → Add data 
UPDATE → Change data 
DELETE → Delete data 

## Why use Triggers?
Triggers are commonly used for:
Logging changes 
Automatically updating related data 
Enforcing additional rules 

🧠 Easy way to remember:
Procedure → You run it manually using CALL.
Trigger → MySQL runs it automatically when an event happens.

## 1. Basic Trigger Structure
SQL COMMAND
```sql
CREATE TRIGGER trigger_name
AFTER INSERT ON table_name
FOR EACH ROW
BEGIN
    -- SQL statements to execute
END;
```
A trigger can run:
BEFORE / AFTER
       ↓
INSERT / UPDATE / DELETE

Triggers can be fired: 
BEFORE or AFTER an event 
On INSERT , UPDATE , or DELETE

## 2. Example: Log Every New User
Suppose we want to automatically record every new user added to the users table.
First, create a separate table to store the log.
Step 1: Create the Log Table
SQL COMMAND
```sql
CREATE TABLE user_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    name VARCHAR(100),
    created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```
This table will store information about newly added users.

## 3. Create the Trigger
SQL COMMAND
```sql
DELIMITER $$
CREATE TRIGGER after_user_insert
AFTER INSERT ON users
FOR EACH ROW
BEGIN
    INSERT INTO user_log (user_id, name)
    VALUES (NEW.id, NEW.name);
END$$
DELIMITER ;
```
Explanation:
AFTER INSERT means the trigger fires after the user is inserted. 
NEW refers to the new row being added to the users table. 
We insert the new user’s ID and name into the user_log table. 

What is NEW?
NEW refers to the new row that was just inserted.
For example, if:
id = 10
name = 'Ritika'
was inserted into users, then:
NEW.id
NEW.name
will contain:
10
Ritika

## 4. Test the Trigger
You can test it by adding a user through your stored procedure:
SQL COMMAND
```sql
CALL AddUser(
    'Ritika Jain',
    'ritika@example.com',
    'Female',
    '1996-03-12',
    74000
);
```
Then check the log:
SQL COMMAND
```sql
SELECT * FROM user_log;
```
You should see the newly inserted user's information automatically.

## 5. NEW and OLD
These are very important when working with triggers.

| Keyword | Meaning |
|---|---|
| NEW | New value/row |
| OLD | Previous value/row |

Where can they be used?

| Event | NEW | OLD |
|---|---|---|
| INSERT | ✅ | ❌ |
| UPDATE | ✅ | ✅ |
| DELETE | ❌ | ✅ |

Easy example
If a user's salary changes:
OLD.salary → salary before change
NEW.salary → salary after change
For a DELETE:
OLD → data that is being deleted
For an INSERT:
NEW → data that is being inserted

## 6. BEFORE vs AFTER
A trigger can run either before or after an event.
BEFORE INSERT
→ Runs before the row is inserted.
AFTER INSERT
→ Runs after the row is inserted.
Similarly:
BEFORE UPDATE
AFTER UPDATE
BEFORE DELETE
AFTER DELETE

## 7. Drop a Trigger
If you no longer need a trigger:
SQL COMMAND
```sql
DROP TRIGGER IF EXISTS after_user_insert;
```
This removes the trigger.

⭐ Important Points
A Trigger runs automatically when a specified event happens. 
Triggers work with INSERT, UPDATE, and DELETE. 
BEFORE → Trigger runs before the event. 
AFTER → Trigger runs after the event. 
FOR EACH ROW → Trigger runs for each affected row. 
NEW → Refers to the new data. 
OLD → Refers to the previous data. 
DROP TRIGGER → Removes a trigger. 
Unlike a stored procedure, you do not use CALL to run a trigger. 

🧠 Easy Way to Remember
Stored Procedure
       ↓
You call it
       ↓
CALL procedure_name();

Trigger
       ↓
An event happens
       ↓
MySQL runs it automatically

Simple Example
INSERT new user
      ↓
Trigger detects INSERT
      ↓
Trigger automatically runs
      ↓
User information saved in user_log

Think of a trigger as an automatic reaction to a database event.

# More on MySQL
Additional Useful MySQL Features

## 1. Logical Operators
Logical operators are used to combine or reverse conditions, usually inside a WHERE clause.

| Operator | Meaning |
|---|---|
| AND | All conditions must be true |
| OR | At least one condition must be true |
| NOT | Reverses a condition |

AND
Both conditions must be true.
SQL COMMAND
```sql
SELECT *
FROM users
WHERE salary > 50000
AND gender = 'Male';
```
Explanation: Finds users whose salary is above 50000 and whose gender is Male.

OR
At least one condition must be true.
SQL COMMAND
```sql
SELECT *
FROM users
WHERE gender = 'Male'
OR gender = 'Other';
```
Explanation: Finds users who are either Male or Other.

NOT
Reverses a condition.
SQL COMMAND
```sql
SELECT *
FROM users
WHERE NOT gender = 'Female';
```
Explanation: Finds users whose gender is not Female.

## 2. Add a Column to an Existing Table
Use ALTER TABLE when you want to add a new column to an existing table.
SQL COMMAND
```sql
ALTER TABLE users
ADD COLUMN city VARCHAR(100);
```
Explanation: Adds a new city column to the users table.

## 3. Wildcard Operators
Wildcards are used with LIKE when you want to search for a pattern in text.

| Wildcard | Meaning | Example |
|---|---|---|
| % | Matches any number of characters | LIKE 'A%' |
| _ | Matches exactly one character | LIKE '_a%' |

% — Any number of characters
SQL COMMAND
```sql
SELECT *
FROM users
WHERE name LIKE 'A%';
```
Explanation: Finds names that start with A.
Examples:
Aarav
Amit
Ankit

_ — One character
SQL COMMAND
```sql
SELECT *
FROM users
WHERE name LIKE '_a%';
```
Explanation: The second character must be a.
Examples:
Raj
Ram

## 4. LIMIT with OFFSET
LIMIT controls how many rows you want to see.
OFFSET tells MySQL how many rows to skip first.
Example
SQL COMMAND
```sql
SELECT *
FROM users
ORDER BY id
LIMIT 5 OFFSET 10;
```
Explanation:
OFFSET 10 → Skip the first 10 rows
LIMIT 5   → Show the next 5 rows
So MySQL skips 10 rows and returns the next 5 rows.

Alternative Syntax
```sql
SELECT *
FROM users
ORDER BY id
LIMIT 10, 5;
```
Here:
10 → OFFSET
5  → Number of rows
⭐ LIMIT offset, count

## 5. DISTINCT
DISTINCT is used to show only unique values and remove duplicates from the result.
Example
SQL COMMAND
```sql
SELECT DISTINCT gender
FROM users;
```
Explanation: If the table contains:
Male
Female
Male
Female
Other
The result will be:
Male
Female
Other

## 6. TRUNCATE
TRUNCATE removes all rows from a table, but keeps the table itself.
SQL COMMAND
```sql
TRUNCATE TABLE users;
```
What happens?
Data ❌ removed
Table ✅ remains
Columns ✅ remain
Structure ✅ remains

DELETE vs TRUNCATE

| DELETE | TRUNCATE |
|---|---|
| Can delete selected rows using WHERE | Removes all rows |
| Generally slower for clearing a whole table | Generally faster |
| Can be rolled back in a transaction under appropriate conditions | Rollback behavior differs; don't assume it can be rolled back |
| Table remains | Table remains |

⚠️ Important: TRUNCATE TABLE users; is a dangerous command because it removes all data from the table.

## 7. CHANGE vs MODIFY
Both are used with ALTER TABLE to change an existing column.

CHANGE COLUMN
Use CHANGE when you want to rename a column and/or change its datatype.
SQL COMMAND
```sql
ALTER TABLE users
CHANGE COLUMN city location VARCHAR(150);
```
Explanation:
city → location
VARCHAR(100) → VARCHAR(150)
So the column is renamed to location and its datatype is changed.

MODIFY COLUMN
Use MODIFY when you want to change the datatype or properties of a column without renaming it.
SQL COMMAND
```sql
ALTER TABLE users
MODIFY COLUMN salary BIGINT;
```
Explanation: Changes the datatype of salary to BIGINT. The column name remains salary.

⭐ Important Points
AND → Both conditions must be true. 
OR → At least one condition must be true. 
NOT → Reverses a condition. 
% → Matches any number of characters. 
_ → Matches exactly one character. 
LIMIT → Controls the number of rows returned. 
OFFSET → Skips rows before returning results. 
DISTINCT → Removes duplicate values from the result. 
TRUNCATE → Removes all rows but keeps the table. 
CHANGE → Can rename + modify a column. 
MODIFY → Modify only

🧠 Easy Way to Remember
AND       → Both
OR        → Any one
NOT       → Opposite
%         → Many characters
_         → One character
LIMIT     → How many?
OFFSET    → Skip how many?
DISTINCT  → Remove duplicates
TRUNCATE  → Empty the table
CHANGE    → Rename + modify
MODIFY    → Modify only