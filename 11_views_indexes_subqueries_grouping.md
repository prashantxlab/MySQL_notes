# MySQL Views

## What is a View?
A View is like a virtual table created from a SELECT query.
It does not store a separate copy of the data. It shows the current data from the original table.
Views are useful when:
You want to simplify complex queries 
You want to reuse logic 
You want to hide certain columns from users 
You want a “live snapshot” of filtered data 

## 1. Creating a View
Suppose we want a view containing users whose salary is more than 70000.
```sql
CREATE VIEW high_salary_users AS
SELECT id, name, salary
FROM users
WHERE salary > 70000;
```
Now we can use the view like a table:
```sql
SELECT *
FROM high_salary_users;
```
This will return all users from the users table where salary is above ₹70,000.

## 2. How Does a View Stay Updated?
A view always uses the current data from the original table.
For example, if we run:
```sql
UPDATE users
SET salary = 72000
WHERE name = 'Raj';
```
Raj now satisfies:
salary > 70000
So when we run:
```sql
SELECT *
FROM high_salary_users;
```
Raj will automatically appear in the result.
You don't need to update the view separately. That’s because view always reflects live data from the original table.

## 3. Dropping a View
To remove a view:
```sql
DROP VIEW high_salary_users;
```
This removes the view, not the original users table or its data.

⭐ Summary
Views act like saved SELECT queries 
Views are not duplicated data 
Changes to the original table are reflected automatically 
Views can make complex queries easier to use 
Views can show only the columns/data you want 
DROP VIEW removes the view 

🧠 Easy Way to Remember
Table = Stores the actual data
View = Shows data using a saved query

# MySQL Indexes

## What is an Index?
An Index helps MySQL find data faster, similar to the index of a book.
Indexes are especially useful for columns frequently used in:
WHERE 
JOIN 
ORDER BY 
An index improves search speed, but it also uses extra storage and can make INSERT, UPDATE, and DELETE slightly slower.

## 1. View Indexes
To see indexes on a table:
```sql
SHOW INDEXES FROM users;
```
This shows all the indexes currently defined on the users table, including the automatically created primary key index

## 2. Create a Single-Column Index
Suppose you're frequently searching users by their email . You can speed this up by indexing the email column. 
```sql
CREATE INDEX idx_email
ON users(email);
```
Now queries such as this can benefit from the index:
```sql
SELECT *
FROM users
WHERE email = 'example@example.com';
```
What this does:
Creates an index named idx_email. 
Helps MySQL find users by email faster. 

## 3. Create a Multi-Column Index
If you frequently search using both gender and salary:
```sql
CREATE INDEX idx_gender_salary
ON users(gender, salary);
```
Example:
```sql
SELECT *
FROM users
WHERE gender = 'Female'
AND salary > 70000;
```
The index contains the columns in this order:
gender → salary

## 4. Index Order Matters ⭐
For this index:
```sql
CREATE INDEX idx_gender_salary
ON users(gender, salary);
```
This can efficiently support:
```sql
WHERE gender = 'Female'
AND salary > 70000;
```
But this may not use the index effectively:
```sql
WHERE salary > 70000;
```
because gender, the first column in the index, is missing from the filter.

🧠 Remember
In a multi-column index, column order matters.

## 5. Important Points
Indexes speed up data retrieval. 
They use extra disk space. 
They can slightly slow down INSERT, UPDATE, and DELETE. 
Use indexes for columns frequently used in WHERE, JOIN, and ORDER BY. 
Don't create indexes unnecessarily. 
A PRIMARY KEY automatically has an index. 
A UNIQUE constraint also creates a unique index. 

## 6. Drop an Index
To remove an index:
```sql
DROP INDEX idx_email
ON users;
```
This removes the index, not the column or its data.

⭐ Quick Summary

| Command | Purpose |
|---|---|
| SHOW INDEXES | View indexes |
| CREATE INDEX | Create an index |
| DROP INDEX | Remove an index |
| Single-column index | Index one column |
| Multi-column index | Index multiple columns |

🧠 Easy Way to Remember
Index = Faster searching, but uses extra space and adds some write overhead.

# Subqueries in MySQL

## What is a Subquery?
A Subquery is a query written inside another query.
It is useful when the result of one query is needed by another query.
Subqueries can be used in:
SELECT statements 
WHERE clauses 
FROM clauses 

## 1. Scalar Subquery
A Scalar Subquery returns one value.
Example: Find users earning more than the average salary.
SQL COMMAND
```sql
SELECT id, name, salary
FROM users
WHERE salary > (
    SELECT AVG(salary)
    FROM users
);
```
Explanation:
The inner query:
```sql
SELECT AVG(salary)
FROM users;
```
calculates the average salary of all users.
The outer query then finds users whose salary is greater than that average.
Inner query → Finds average salary
       ↓
Outer query → Finds users earning more than average

## 2. Subquery with IN
IN is used when the subquery returns multiple values.
Example: Find users who were referred by someone earning more than ₹75,000.
SQL COMMAND
```sql
SELECT id, name, referred_by_id
FROM users
WHERE referred_by_id IN (
    SELECT id
    FROM users
    WHERE salary > 75000
);
```
Explanation:
The inner query:
```sql
SELECT id
FROM users
WHERE salary > 75000;
```
returns the IDs of users earning more than ₹75,000.
The outer query then finds users whose referred_by_id matches any of those IDs.

## 3. Subquery in SELECT
A subquery can also be used inside SELECT to display a calculated value.
Example: Show each user's salary and the average salary.
SQL COMMAND
```sql
SELECT
    name,
    salary,
    (SELECT AVG(salary) FROM users) AS average_salary
FROM users;
```
Explanation:
The subquery calculates the overall average salary.
That average is then shown beside every user's salary.
Example:
name     salary    average_salary
-------  --------  --------------
Aarav    60000     65000
Sneha    75000     65000
Raj      50000     65000

## 4. Subquery in FROM
A subquery inside FROM works like a temporary table for that query.
Example:
```sql
SELECT *
FROM (
    SELECT name, salary
    FROM users
    WHERE salary > 70000
) AS high_salary_users;
```
Explanation:
The inner query first finds users earning more than ₹70,000.
The outer query then uses that result as a temporary table named:
high_salary_users
In MySQL, a subquery used in FROM needs an alias such as AS high_salary_users.

⭐ Important Points
Subquery = Query inside another query 
Subqueries are written inside (). 
Scalar subquery → Returns one value. 
IN subquery → Can return multiple values. 
Subquery in SELECT → Shows a calculated value. 
Subquery in FROM → Acts like a temporary table. 
The inner query is generally used to provide information to the outer query. 

🧠 Easy Way to Remember
SUBQUERY
   ↓
Inner Query → Gets information
   ↓
Outer Query → Uses that information
   ↓
Final Result
Simple example:“Find users earning more than the average salary.”First find the average salary, then find users earning more than it.

# GROUP BY and HAVING in MySQL
Grouping and Filtering Aggregated Data

## What is GROUP BY?
GROUP BY is used to put rows with the same value into groups in specified columns.
It is usually used with functions like:
COUNT() → Counts rows 
SUM() → Adds values 
AVG() → Finds average 
MIN() → Finds smallest value 
MAX() → Finds largest value 

Example: Average Salary by Gender
SQL COMMAND
```sql
SELECT gender, AVG(salary) AS average_salary
FROM users
GROUP BY gender;
```
Explanation:
GROUP BY gender creates separate groups for each gender.
Then AVG(salary) calculates the average salary for each group.
Male   → Average salary
Female → Average salary
Other  → Average salary

## 1. GROUP BY with COUNT()
We can use COUNT() to count how many users belong to each group.
Example: Count users referred by each user
SQL COMMAND
```sql
SELECT referred_by_id, COUNT(*) AS total_referred
FROM users
WHERE referred_by_id IS NOT NULL
GROUP BY referred_by_id;
```
Explanation:
WHERE removes users who were not referred by anyone. 
GROUP BY referred_by_id creates a group for each referrer. 
COUNT(*) counts users in each group. 
Example result:
referred_by_id    total_referred
---------------   --------------
1                 2
2                 1
This means user 1 referred 2 users, while user 2 referred 1 user.

## 2. What is HAVING?
HAVING is used to filter groups after GROUP BY.
Example: Genders with average salary above ₹75,000
SQL COMMAND
```sql
SELECT gender, AVG(salary) AS avg_salary
FROM users
GROUP BY gender
HAVING AVG(salary) > 75000;
```
Explanation:
First:
GROUP BY → Creates gender groups
Then:
AVG() → Calculates average salary for each group
Finally:
HAVING → Keeps only groups where average salary > 75000

WHERE vs HAVING ⭐
This is one of the most important differences.

| Clause | Used for |
|---|---|
| WHERE | Filters individual rows before grouping |
| GROUP BY | Creates groups |
| HAVING | Filters groups after grouping |

Why not WHERE ?
WHERE is used before grouping.
HAVING is used after groups are formed. It is the only way to filter aggregated values.
Example
```sql
SELECT referred_by_id, COUNT(*) AS total_referred
FROM users
WHERE referred_by_id IS NOT NULL
GROUP BY referred_by_id
HAVING COUNT(*) > 1;
```
Here:
WHERE  → Removes NULL referrers
GROUP BY → Groups users by referrer
COUNT() → Counts users in each group
HAVING → Keeps referrers with more than 1 referral

## 3. ROLLUP
ROLLUP is used to get subtotals and a grand total.
Example
```sql
SELECT gender, COUNT(*) AS total_users
FROM users
GROUP BY gender WITH ROLLUP;
```
This gives:
gender    total_users
--------  -----------
Female    3
Male      2
NULL      5
The NULL row represents the grand total.
ROLLUP is useful when you want both individual group totals and an overall total.

⭐ Important Points
GROUP BY → Creates groups. 
Aggregate functions like COUNT(), SUM(), and AVG() are commonly used with GROUP BY. 
WHERE filters rows before grouping. 
HAVING filters groups after grouping. 
HAVING is especially useful when filtering based on aggregate results such as COUNT() or AVG(). 
ROLLUP provides subtotals and a grand total. 

🧠 Easy Way to Remember
WHERE
  ↓
Filter rows
  ↓
GROUP BY
  ↓
Create groups
  ↓
COUNT / SUM / AVG
  ↓
HAVING
  ↓
Filter groups

One-line memory trick:
WHERE = filter rows | GROUP BY = make groups | HAVING = filter groups