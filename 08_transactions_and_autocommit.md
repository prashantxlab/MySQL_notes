# MySQL Transactions & AutoCommit
Managing Database Changes Safely

## What is a Transaction?
A transaction is a group of one or more SQL statements that MySQL treats as a single unit of work.
The main purpose of transactions is to make sure database changes are either:
Saved permanently using COMMIT, or 
Undone using ROLLBACK. 

## Why are Transactions Used?
Transactions are especially useful when multiple changes must be treated as one operation.
For example, transferring ₹10,000 from one account to another involves:
Account A → -₹10,000
Account B → +₹10,000
If the first operation succeeds but the second fails, the database could become inconsistent. A transaction allows both operations to be committed together or rolled back.

## 1. AutoCommit
By default, MySQL operates with AutoCommit enabled.
When AutoCommit is enabled, each statement that successfully completes is automatically committed.
For example:
```sql
UPDATE users
SET salary = salary + 5000
WHERE id = 5;
```
With AutoCommit enabled, the change is automatically committed.

Check AutoCommit
```sql
SELECT @@autocommit;
```
Typically:
1 → AutoCommit ON
0 → AutoCommit OFF

## 2. Disable AutoCommit
To manually control when changes are saved:
SQL COMMAND
```sql
SET autocommit = 0;
```
Now MySQL will not automatically commit each statement.
You can decide whether to save or undo the changes.
⚠️ With AutoCommit disabled, changes remain part of the current transaction until you execute COMMIT or ROLLBACK.

## 3. COMMIT — Save Changes
COMMIT permanently saves the changes made in the current transaction.
SQL COMMAND
```sql
COMMIT;
```
After COMMIT, the changes cannot normally be undone using ROLLBACK.
Example
```sql
SET autocommit = 0;
UPDATE users
SET salary = 80000
WHERE id = 5;
COMMIT;
```
What happens?
UPDATE
  ↓
Change exists in current transaction
  ↓
COMMIT
  ↓
Change is permanently saved

## 4. ROLLBACK — Undo Changes
ROLLBACK cancels changes made since the transaction began or since the relevant transaction boundary.
SQL COMMAND
```sql
ROLLBACK;
```
Example
```sql
SET autocommit = 0;
UPDATE users
SET salary = 80000
WHERE id = 5;
ROLLBACK;
```
The salary change is undone, assuming it has not already been committed.

Simple Flow
UPDATE
  ↓
Change made
  ↓
ROLLBACK
  ↓
Change undone

## 5. Complete Transaction Example
Suppose user id = 5 currently has a salary of 60000.
We want to increase it to 80000, but first want to verify the change.

Step 1 — Disable AutoCommit
```sql
SET autocommit = 0;
```

Step 2 — Make the Change
```sql
UPDATE users
SET salary = 80000
WHERE id = 5;
```

Step 3 — Check the Result
```sql
SELECT *
FROM users
WHERE id = 5;
```
If everything is correct:
Step 4 — Save
```sql
COMMIT;
```

If something is wrong:
Instead, Undo
```sql
ROLLBACK;
```

## 6. Enabling AutoCommit Again
After manually managing transactions, you can turn AutoCommit back on:
```sql
SET autocommit = 1;
```
Then each statement will again be automatically committed.

## 7. START TRANSACTION — Recommended for Explicit Transactions ⭐
Instead of globally disabling AutoCommit, you can explicitly start a transaction:
```sql
START TRANSACTION;
```
Then perform your operations:
```sql
UPDATE users
SET salary = salary + 10000
WHERE id = 5;
```
Check the result:
```sql
SELECT *
FROM users
WHERE id = 5;
```
If correct:
```sql
COMMIT;
```
If incorrect:
```sql
ROLLBACK;
```

Complete Example
```sql
START TRANSACTION;
UPDATE users
SET salary = salary + 10000
WHERE id = 5;
SELECT *
FROM users
WHERE id = 5;
COMMIT;
```
Or, if you want to undo it:
```sql
START TRANSACTION;
UPDATE users
SET salary = salary + 10000
WHERE id = 5;
ROLLBACK;
```
🧠 Why use START TRANSACTION?
It gives you an explicit transaction boundary without needing to keep AutoCommit disabled for your entire session.

## 8. Multiple Operations in One Transaction
This is where transactions become especially useful.
Suppose we want to update two users together:
```sql
START TRANSACTION;
UPDATE users
SET salary = salary + 5000
WHERE id = 5;
UPDATE users
SET salary = salary + 5000
WHERE id = 6;
COMMIT;
```
Both changes are committed together.
If something goes wrong before the COMMIT:
```sql
ROLLBACK;
```
Both changes are undone.

## 9. Important: ROLLBACK Has Limits ⚠️
ROLLBACK does not undo every type of SQL operation.
Transactions primarily protect transactional DML operations, such as:
INSERT
UPDATE
DELETE
For normal MySQL transactional tables using the InnoDB storage engine, these changes can be rolled back before commit.
Some DDL operations, such as certain CREATE, ALTER, and DROP statements, have different transactional behavior and may cause implicit commits.
So don't assume:
```sql
ROLLBACK;
```
can undo every SQL statement.

## 10. Important: Transaction Support Depends on Storage Engine
MySQL transactions are primarily associated with the InnoDB storage engine.
You can check the storage engine of a table:
```sql
SHOW TABLE STATUS LIKE 'users';
```
Or:
```sql
SHOW CREATE TABLE users;
```
Look for:
ENGINE=InnoDB
For your MySQL learning, InnoDB is the important engine to understand for transactions.

## 11. COMMIT vs ROLLBACK

| Command | Purpose |
|---|---|
| COMMIT | Permanently save transaction changes |
| ROLLBACK | Undo uncommitted transaction changes |
| START TRANSACTION | Explicitly begin a transaction |
| SET autocommit = 0 | Disable automatic commits |
| SET autocommit = 1 | Enable automatic commits |

Easy way to remember
COMMIT   → "I am happy with the changes. SAVE them."
ROLLBACK → "Something is wrong. UNDO them."

## 12. Best Practices ⭐
1. Test before modifying data
Before:
```sql
UPDATE users
SET salary = salary + 10000
WHERE salary < 60000;
```
first check:
```sql
SELECT *
FROM users
WHERE salary < 60000;
```
This lets you see which rows will be affected.

2. Use transactions for important changes
```sql
START TRANSACTION;
UPDATE users
SET salary = salary + 10000
WHERE salary < 60000;
-- Verify the result
COMMIT;
```
Or:
```sql
ROLLBACK;
```
if the result isn't what you expected.

3. Be careful with production databases
Test transaction logic carefully before executing large UPDATE or DELETE operations against production data.

🧠 Quick Summary
Transaction
↓
Group of SQL operations treated as one unit
↓
┌───────────────┐
↓               ↓
COMMIT          ROLLBACK
↓               ↓
Save changes     Undo changes

Most important commands
```sql
-- Start a transaction
START TRANSACTION;
-- Make changes
UPDATE users
SET salary = salary + 10000
WHERE id = 5;
-- Save
COMMIT;
```
Or:
```sql
START TRANSACTION;
UPDATE users
SET salary = salary + 10000
WHERE id = 5;
-- Undo
ROLLBACK;
```
Key concept: A transaction gives you control over a group of database changes—COMMIT saves them, while ROLLBACK discards uncommitted changes.