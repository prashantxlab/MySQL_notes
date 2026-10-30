# NULL & BETWEEN
Handling Missing Values and Ranges

## Working with NULL
NULL represents a missing or unknown value in MySQL.
⚠️ NULL is different from 0, an empty string '', or a blank value. It means that a value is not present/unknown.

### IS NULL
Use IS NULL to find rows where a column contains NULL.
SQL COMMAND
```sql
SELECT * FROM users WHERE date_of_birth IS NULL;
```
This returns all users whose date_of_birth has no value.

### IS NOT NULL
Use IS NOT NULL to find rows where a column contains a value.
SQL COMMAND
```sql
SELECT * FROM users WHERE date_of_birth IS NOT NULL;
```
This returns all users whose date_of_birth is available.

❌ Do not use = NULL or != NULL.
✅ Use IS NULL or IS NOT NULL.

## BETWEEN
BETWEEN is used to filter values within a specified range, including both the starting and ending values.
SQL COMMAND
```sql
SELECT * FROM users WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';
```
This returns users whose date of birth is from 1990-01-01 through 2000-12-31, including both dates.

🧠 Remember
IS NULL       → Find missing values
IS NOT NULL   → Find available values
BETWEEN       → Find values within a range

Example:
```sql
WHERE id BETWEEN 10 AND 20;
```
This includes 10 and 20.

## AND — Combining Multiple Conditions
The AND operator is used when all specified conditions must be true.
SQL COMMAND
```sql
SELECT * FROM users WHERE gender = 'Female' AND salary > 70000;
```
This query finds female users whose salary is more than 70,000.
Note: salary is a numeric value, so 70000 is written without quotes. Female is a text value, so it is written inside quotes.

## OR — Matching Either Condition
The OR operator is used when at least one of the specified conditions must be true.
SQL COMMAND
```sql
SELECT *
FROM users
WHERE gender = 'Male'
OR salary > 70000;
```
This query finds users who are either Male or have a salary greater than 70,000
Note: Because OR requires only one condition to be true, the result can contain both male users with lower salaries and users of other genders earning more than 70,000.

## ORDER BY and LIMIT — Sorting and Limiting Results
This query combines OR, ORDER BY, and LIMIT to filter, sort, and restrict the number of results.
Find male users or users earning more than 70,000, sort them by date of birth from newest to oldest, and show only the top 5.
SQL COMMAND
```sql
SELECT * FROM users WHERE gender = 'Male' OR salary > 70000 ORDER BY date_of_birth DESC LIMIT 5;
```
What does this query do?
It finds users who either:
are Male, OR 
have a salary greater than 70,000 
Then:
ORDER BY date_of_birth DESC → Sorts the matching users by date of birth from newest to oldest. 
LIMIT 5 → Returns only the first 5 records after sorting.

# Pattern Matching & Sorting
LIKE, AND, OR, and ORDER BY

## IN
IN is used to check whether a column's value matches any value in a specified list.
SQL COMMAND
```sql
SELECT * FROM users WHERE gender IN ('Male', 'Other');
```
This returns users whose gender is either Male or Other.
It is similar to:
```sql
WHERE gender = 'Male'
   OR gender = 'Other';
```

## LIKE — Pattern Matching
LIKE is used to search for values that match a specific pattern.
MySQL uses:
% → Matches zero or more characters 
_ → Matches exactly one character 

Contains Anything
```sql
SELECT * FROM users WHERE name LIKE '%a%';
```
Returns names containing a anywhere.

Starts With A
```sql
SELECT * FROM users WHERE name LIKE 'A%';
```
Returns names that start with A.

Ends With a
```sql
SELECT * FROM users WHERE name LIKE '%a';
```
Returns names that end with a.

Contains li
```sql
SELECT * FROM users WHERE name LIKE '%li%';
```
Returns names containing li anywhere.

🧠 Remember
'A%'     → Starts with A
'%a'     → Ends with a
'%a%'    → Contains a
'%li%'   → Contains li

## AND / OR
These operators are used to combine multiple conditions in a WHERE clause.

AND
AND requires both conditions to be true.
SQL COMMAND
```sql
SELECT * FROM users WHERE gender = 'Female' AND date_of_birth > '1990-01-01';
```
This returns users who:
Are Female 
AND were born after 1990-01-01 
Both conditions must be satisfied.

OR
OR requires at least one condition to be true.
SQL COMMAND
```sql
SELECT * FROM users WHERE gender = 'Male' OR gender = 'Other';
```
This returns users whose gender is Male or Other.

🧠 Quick Summary

| Operator | Purpose | Example |
|---|---|---|
| IN | Match any value from a list | gender IN ('Male','Other') |
| LIKE | Pattern matching | name LIKE 'A%' |
| % | Zero or more characters | 'A%' |
| _ | Exactly one character | 'A_' |
| AND | All conditions must be true | gender='Male' AND id>10 |
| OR | At least one condition must be true | gender='Male' OR gender='Other' |

Important difference
```sql
WHERE gender IN ('Male', 'Other');
```
is a cleaner way of writing:
```sql
WHERE gender = 'Male'
   OR gender = 'Other';
```
So when you have multiple possible values for the same column, IN is usually easier to read.