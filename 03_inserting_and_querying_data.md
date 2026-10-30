# Inserting Data into MySQL Tables

## Adding Records Using INSERT INTO 
To add data into a table, we use the INSERT INTO statement.

### Insert Without Specifying Column Names
This method requires you to provide values for all columns in the correct order, except columns with AUTO_INCREMENT or DEFAULT values.
SQL COMMAND
```sql
INSERT INTO users
VALUES
(1, 'Alice', 'alice@example.com', 'Female', '1995-05-14', DEFAULT);
```
⚠️ Not recommended when the table structure may change later, such as when new columns are added.

### Insert by Specifying Column Names ⭐
This is the recommended approach because it is safer and more readable.
You specify only the columns into which you want to insert data.
SQL COMMAND
```sql
INSERT INTO users
(name, email, gender, date_of_birth)
VALUES
('Bob', 'bob@example.com', 'Male', '1990-11-23');
```
MySQL automatically handles:
id → generated because it is AUTO_INCREMENT 
created_at → generated because it has DEFAULT CURRENT_TIMESTAMP 

### Multiple Row Inserts
You can insert multiple records in a single query.
SQL COMMAND
```sql
INSERT INTO users
(name, email, gender, date_of_birth)
VALUES
('Bob', 'bob@example.com', 'Male', '1990-11-23'),
('Charlie', 'charlie@example.com', 'Other', '1988-02-17');
```

🧠 Quick Summary
INSERT INTO table VALUES (...)
→ Insert a complete row in column order.
INSERT INTO table (column1, column2, ...)
VALUES (...)
→ Insert data into specific columns. ⭐ Recommended
Multiple VALUES (...)
→ Insert multiple rows in one query.

Important: If a column has AUTO_INCREMENT or a DEFAULT value, you generally don't need to provide a value for it when using the column-list approach.

Open MySQL workbench and run the scripts provided into handbook.
01_createusertable.sql  this script is for creating database and the tables.
02_insertdata.sql  this script is for inserting the dummy data of the users.
We can use query “select * from users;” to view all the data contained in the users table.

# Querying Data in MySQL Using SELECT

## Retrieving and Filtering Data
The SELECT statement is used to retrieve data from a table.

### Basic SELECT Syntax
To select specific columns:
SQL SYNTAX
```sql
SELECT column1, column2 FROM table_name;
```

Example
To obtain the name and gender from the users table:
```sql
SELECT name, gender FROM users;
```
To obtain gender first and then name:
```sql
SELECT gender, name FROM users;
```
The order of columns in the SELECT statement determines the order in which they appear in the result.

### Select All Columns
Use * to select all columns from a table.
SQL COMMAND
```sql
SELECT * FROM users;
```
This returns all columns and all rows from the users table.

### Filtering Rows with WHERE
The WHERE clause is used to filter rows based on a condition.

Equal To =
To obtain users whose gender is Male:
SQL COMMAND
```sql
SELECT * FROM users WHERE gender = 'Male';
```
This returns all data for users whose gender is Male.

Not Equal To != or <>
To obtain users whose gender is not Female:
SQL COMMAND
```sql
SELECT * FROM users WHERE gender != 'Female';
```
MySQL also supports <>:
```sql
SELECT * FROM users WHERE gender <> 'Female';
```
Both mean not equal to.

Example
To obtain all users whose gender is not Male:
```sql
SELECT * FROM users WHERE gender != 'Male';
```

Greater Than >
The > operator returns values greater than the specified value.
SQL COMMAND
```sql
SELECT * FROM users WHERE id > 10;
```
This returns users whose id is greater than 10.

Less Than <
The < operator returns values less than the specified value.
SQL COMMAND
```sql
SELECT * FROM users WHERE date_of_birth < '1995-09-09';
```
This returns users whose date of birth is before 1995-09-09.

Greater Than or Equal To >=
The >= operator returns values greater than or equal to the specified value.
SQL COMMAND
```sql
SELECT * FROM users WHERE id >= 5;
```
This returns users whose id is 5 or greater.

Less Than or Equal To <=
The <= operator returns values less than or equal to the specified value.
SQL COMMAND
```sql
SELECT * FROM users WHERE id <= 20;
```
This returns users whose id is 20 or less.

### Custom Ordering with ORDER BY
Normally, ORDER BY sorts data according to the column's values. You can also create a custom order using CASE.
For example, to display Male first, Female second, and everything else after that:
SQL COMMAND
```sql
SELECT gender, name
FROM users
ORDER BY CASE
    WHEN gender = 'Male' THEN 1
    WHEN gender = 'Female' THEN 2
    ELSE 3
END;
```
How it works
Male       → 1
Female     → 2
Everything → 3
MySQL sorts according to these numbers, giving you the required order.

| Operator / Keyword | Purpose | Example |
|---|---|---|
| SELECT | Retrieve data | SELECT name FROM users; |
| * | Select all columns | SELECT * FROM users; |
| WHERE | Filter rows | WHERE gender = 'Male' |
| = | Equal to | id = 10 |
| != / <> | Not equal to | gender != 'Male' |
| > | Greater than | id > 10 |
| < | Less than | id < 10 |
| >= | Greater than or equal | id >= 10 |
| <= | Less than or equal | id <= 10 |
| ORDER BY | Sort results | ORDER BY name |
| CASE | Create custom conditions/order | CASE WHEN ... THEN ... END |