# SQL Functions in MySQL
Aggregate, String, Date, Mathematical & Conditional Functions

## What are SQL Functions?
SQL functions are built-in MySQL operations that perform a specific task on data.
They are used to analyze, calculate, transform, or format data while retrieving it from a table.
For example:
```sql
SELECT AVG(salary)
FROM users;
```
This calculates the average salary of all users.

## Why are Functions Used?
Functions help you perform operations without manually processing the data.
For example, instead of retrieving every salary and calculating the average yourself, MySQL can do it:
Database → AVG() → Average salary

MySQL functions can be broadly grouped into:
Aggregate Functions   → Work on multiple rows
String Functions      → Work with text
Date Functions        → Work with dates/time
Mathematical Functions → Perform calculations
Conditional Functions → Apply logical conditions

## 1. Aggregate Functions
Aggregate functions perform calculations on multiple rows and return a summarized result.
The main aggregate functions covered here are:
COUNT() → Count rows
SUM()   → Calculate total
AVG()   → Calculate average
MIN()   → Find minimum
MAX()   → Find maximum

### COUNT()
COUNT() is used to count rows or values.

Count Total Users
```sql
SELECT COUNT(*)
FROM users;
```
This returns the total number of rows in the users table.

Count Female Users
```sql
SELECT COUNT(*)
FROM users
WHERE gender = 'Female';
```
This counts the number of users whose gender is Female.

🧠 Important
COUNT(*)
counts rows, including rows where individual columns contain NULL.
COUNT(column_name) behaves differently: it counts only non-NULL values in that column.

Example:
```sql
SELECT COUNT(date_of_birth)
FROM users;
```
This counts users who have a date_of_birth value.

### 2. MIN() and MAX()
These functions find the smallest and largest value in a column.
Find Minimum and Maximum Salary
```sql
SELECT
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary
FROM users;
```
Result conceptually:
min_salary    max_salary
----------    ----------
30000         120000
MIN() → Lowest value 
MAX() → Highest value 

### 3. SUM()
SUM() calculates the total of numeric values in a column.
Calculate Total Salary
```sql
SELECT SUM(salary) AS total_payroll
FROM users;
```
This calculates the total salary of all users.

🧠 Important
SUM() is normally used with numeric columns, such as:
salary
price
quantity
amount

### 4. AVG()
AVG() calculates the average value of a numeric column.
Find Average Salary
```sql
SELECT AVG(salary) AS avg_salary
FROM users;
```
This returns the average salary of the users.
Conceptually:
Average = Total salary / Number of applicable values

### 5. GROUP BY
GROUP BY is used to divide rows into groups based on one or more columns.
It is especially useful with aggregate functions.
Average Salary by Gender
```sql
SELECT
    gender,
    AVG(salary) AS avg_salary
FROM users
GROUP BY gender;
```
Instead of getting one average for the entire table, MySQL calculates a separate average for each gender.
Example result:
gender    avg_salary
------    ----------
Female    65000
Male      72000
Other     58000

🧠 Important Pattern
```sql
SELECT grouping_column, AGGREGATE_FUNCTION(column)
FROM table
GROUP BY grouping_column;
```
For example:
```sql
SELECT gender, COUNT(*)
FROM users
GROUP BY gender;
```
This counts users in each gender group.

## 6. String Functions
String functions are used to work with text/string data.
The functions covered here are:
LENGTH() → Find string length
LOWER()  → Convert to lowercase
UPPER()  → Convert to uppercase
CONCAT() → Combine strings

### LENGTH()
LENGTH() returns the number of bytes used by a string in MySQL.
For ordinary ASCII/English text, this is typically the same as the number of characters.
Find Name Length
```sql
SELECT
    name,
    LENGTH(name) AS name_length
FROM users;
```
Example:
name      name_length
------    -----------
Alice     5
Robert    6
Important: LENGTH() counts bytes, not characters. For character count, MySQL provides CHAR_LENGTH().

### 7. LOWER() and UPPER()
These functions change the letter case of text.
Convert to Lowercase
```sql
SELECT
    name,
    LOWER(name) AS lowercase_name
FROM users;
```
Example:
Alice → alice

Convert to Uppercase
```sql
SELECT
    name,
    UPPER(name) AS uppercase_name
FROM users;
```
Example:
Alice → ALICE
These functions do not change the stored value. They only change how the value is displayed in the query result.

### 8. CONCAT()
CONCAT() is used to combine multiple strings into one string.
Combine Name and Email
```sql
SELECT
    CONCAT(name, ' <', email, '>')
    AS user_contact
FROM users;
```
If:
name  = Alice
email = alice@example.com
The result would be:
Alice <alice@example.com>

Another Example
```sql
SELECT CONCAT(name, ' - ', gender)
FROM users;
```
Result:
Alice - Female

## 9. Date Functions
Date functions are used to retrieve, extract, or calculate information from dates and times.
The functions covered here are:
NOW()          → Current date and time
YEAR()         → Extract year
MONTH()        → Extract month
DAY()          → Extract day
DATEDIFF()     → Difference between dates
TIMESTAMPDIFF() → Difference between dates in a specified unit

### NOW()
NOW() returns the current date and time according to the MySQL session's current date/time context.
```sql
SELECT NOW();
```
Example result:
2026-09-22 02:20:15

### 10. YEAR(), MONTH(), DAY()
These functions extract individual parts from a date.
Extract Year
```sql
SELECT
    name,
    YEAR(date_of_birth) AS birth_year
FROM users;
```
Example:
name      birth_year
------    ----------
Alice     1995
Bob       1998

Extract Month
```sql
SELECT
    name,
    MONTH(date_of_birth) AS birth_month
FROM users;
```

Extract Day
```sql
SELECT
    name,
    DAY(date_of_birth) AS birth_day
FROM users;
```

### 11. DATEDIFF()
DATEDIFF() calculates the number of days between two dates.
Find Number of Days Since Birth
```sql
SELECT
    name,
    DATEDIFF(CURDATE(), date_of_birth) AS days_lived
FROM users;
```
Here:
CURDATE()      → Today's date
date_of_birth  → User's birth date
DATEDIFF()     → Difference in days
DATEDIFF() returns a number of days, not years, months, hours, etc.

### 12. TIMESTAMPDIFF()
TIMESTAMPDIFF() calculates the difference between two dates/times in a specified unit.
Calculate Age in Completed Years
```sql
SELECT
    name,
    TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) AS age
FROM users;
```
Here:
YEAR          → Unit in which to calculate the difference
date_of_birth → Starting date
CURDATE()     → Ending date
For example, if someone was born on 1995-05-14, this can return their completed age in years.
Other Units
You can use:
TIMESTAMPDIFF(MONTH, start_date, end_date)
TIMESTAMPDIFF(DAY, start_date, end_date)
TIMESTAMPDIFF(HOUR, start_time, end_time)

## 13. Mathematical Functions
Mathematical functions are used to perform calculations or manipulate numeric values.
The functions covered here are:
ROUND() → Round a number
FLOOR() → Round down
CEIL()  → Round up
MOD()   → Find remainder

### ROUND()
ROUND() rounds a number to the nearest value.
```sql
SELECT
    salary,
    ROUND(salary) AS rounded
FROM users;
```
You can also specify decimal places:
```sql
SELECT ROUND(123.4567, 2);
```
Result:
123.46

### FLOOR()
FLOOR() returns the largest integer less than or equal to a number.
```sql
SELECT FLOOR(123.75);
```
Result:
123

### CEIL()
CEIL() returns the smallest integer greater than or equal to a number.
```sql
SELECT CEIL(123.25);
```
Result:
124
CEILING() is also a MySQL synonym for CEIL().

🧠 Remember
ROUND(123.6) → 124
FLOOR(123.6) → 123
CEIL(123.6)  → 124

### 14. MOD()
MOD() returns the remainder after division.
Find Remainder
```sql
SELECT
    id,
    MOD(id, 2) AS remainder
FROM users;
```
For example:
id = 10 → MOD(10,2) = 0
id = 11 → MOD(11,2) = 1
Therefore:
Remainder = 0 → Even
Remainder = 1 → Odd
You can use it to identify even and odd IDs.

## 15. Conditional Function — IF()
IF() allows you to apply a condition and return different values depending on the result.
Example
```sql
SELECT
    name,
    gender,
    IF(gender = 'Female', 'Yes', 'No') AS is_female
FROM users;
```
If the user is Female:
is_female → Yes
Otherwise:
is_female → No

Basic Syntax
IF(condition, value_if_true, value_if_false)
Example:
IF(salary > 70000, 'High', 'Low')
This can classify users based on salary.

⭐ AS — Column Alias
You will notice many examples use:
AVG(salary) AS avg_salary
AS creates an alias, or temporary name, for the result column.
For example:
```sql
SELECT
    AVG(salary) AS avg_salary
FROM users;
```
Instead of the result column having a generated name such as AVG(salary), it appears as:
avg_salary
Aliases do not rename the actual database column.

🧠 Important Difference: Aggregate vs Other Functions
This is an important concept.

Aggregate Function
Works across multiple rows and usually produces a summary:
```sql
SELECT AVG(salary)
FROM users;
```
Result:
72000

Scalar/Single-Row Function
Generally works on a value from each row:
```sql
SELECT name, UPPER(name)
FROM users;
```
Result:
Alice → ALICE
Bob   → BOB

So:
AVG()       → Many rows → One summarized result
UPPER()     → One row/value → Transformed value

📌 Function Summary

| Function | Purpose | Example |
|---|---|---|
| COUNT() | Count rows/values | COUNT(*) |
| SUM() | Calculate total | SUM(salary) |
| AVG() | Calculate average | AVG(salary) |
| MIN() | Find lowest value | MIN(salary) |
| MAX() | Find highest value | MAX(salary) |
| GROUP BY | Create groups for aggregation | GROUP BY gender |
| LENGTH() | Get string byte length | LENGTH(name) |
| LOWER() | Convert text to lowercase | LOWER(name) |
| UPPER() | Convert text to uppercase | UPPER(name) |
| CONCAT() | Combine strings | CONCAT(name, email) |
| NOW() | Current date + time | NOW() |
| YEAR() | Extract year | YEAR(date_of_birth) |
| MONTH() | Extract month | MONTH(date_of_birth) |
| DAY() | Extract day | DAY(date_of_birth) |
| DATEDIFF() | Difference in days | DATEDIFF(date1,date2) |
| TIMESTAMPDIFF() | Difference in specified unit | TIMESTAMPDIFF(YEAR,...) |
| ROUND() | Round a number | ROUND(salary,2) |
| FLOOR() | Round down | FLOOR(12.8) |
| CEIL() | Round up | CEIL(12.2) |
| MOD() | Find remainder | MOD(id,2) |
| IF() | Conditional result | IF(salary>70000,'High','Low') |

🎯 Most Important Patterns to Remember

Aggregate
```sql
SELECT AVG(salary)
FROM users;
```

Aggregate + GROUP BY
```sql
SELECT gender, AVG(salary)
FROM users
GROUP BY gender;
```

String transformation
```sql
SELECT UPPER(name)
FROM users;
```

Date extraction
```sql
SELECT YEAR(date_of_birth)
FROM users;
```

Date difference
```sql
SELECT DATEDIFF(CURDATE(), date_of_birth)
FROM users;
```

Mathematical calculation
```sql
SELECT MOD(id, 2)
FROM users;
```

Conditional logic
```sql
SELECT IF(salary > 70000, 'High', 'Low')
FROM users;
```

One particularly important distinction for your notes 📌
Functions generally calculate/transform values; GROUP BY groups rows so aggregate functions can produce a separate result for each group.
For example:
```sql
SELECT gender, AVG(salary)
FROM users
GROUP BY gender;
```
Here, AVG() is the function, while GROUP BY determines how the rows are grouped before the average is calculated.