# Data Types & Constraints

## More Data Types
TIMESTAMP : Stores date and time, automatically set to the current timestamp. 
BOOLEAN : Stores TRUE or FALSE values. 
DECIMAL(10, 2) : Stores exact numeric data values, useful for financial data. The first number is the total number of digits, and the second is the number of digits after the decimal point. 

## Constraints Explained
AUTO_INCREMENT : Automatically generates a unique number for each row. 
PRIMARY KEY : Uniquely identifies each row in the table. 
NOT NULL : Ensures a column cannot have a NULL value. 
UNIQUE : Ensures all values in a column are different. 
DEFAULT : Sets a default value for a column if no value is provided.

# Selecting Data from a Table

## Select All Columns
SQL COMMAND
```sql
SELECT * FROM users;
```
This fetches every column and every row from the users table.

## Select Specific Columns
SQL COMMAND
```sql
SELECT name, email FROM users;
```
This only fetches the name and email columns from all rows.

## Renaming a Table
To rename an existing table:
SQL COMMAND
```sql
RENAME TABLE users TO customers;
```
To rename it back:
SQL COMMAND
```sql
RENAME TABLE customers TO users;
```

# Altering Tables in MySQL
Modifying Existing Table Structure:
Altering a Table: You can use ALTER TABLE to modify an existing table.

## Add a Column
SQL COMMAND
```sql
ALTER TABLE users
ADD COLUMN is_active BOOLEAN DEFAULT TRUE;
```

## Drop a Column
SQL COMMAND
```sql
ALTER TABLE users
DROP COLUMN is_active;
```

## Modify a Column Type
SQL COMMAND
```sql
ALTER TABLE users
MODIFY COLUMN name VARCHAR(150);
```

## Move a Column to the First Position
To move a column (e.g., email) to the first position:
SQL COMMAND
```sql
ALTER TABLE users
MODIFY COLUMN email VARCHAR(100) FIRST;
```

# Advanced Table Modifications
Managing Column Position and Structure:
Altering Tables in MySQL
Add, Drop, Modify, Move, and Rename Columns
You can use ALTER TABLE to modify the structure of an existing table.

## Add a Column
Add a new is_active column with BOOLEAN data type and default value TRUE.
SQL COMMAND
```sql
ALTER TABLE users
ADD COLUMN is_active BOOLEAN DEFAULT TRUE;
```

## Drop a Column
Delete the is_active column from the table.
SQL COMMAND
```sql
ALTER TABLE users
DROP COLUMN is_active;
```
Drop multiple Columns
Deleting mobile_number and city form the table
SQL COMMAND
```sql
alter table users drop column mobile_number, drop column city;
```

## Modify a Column
Change the maximum length of the name column from its current size to 150 characters.
SQL COMMAND
```sql
ALTER TABLE users
MODIFY COLUMN name VARCHAR(150);
```

## Move a Column to the First Position
Use FIRST to move a column to the beginning of the table.
SQL COMMAND
```sql
ALTER TABLE users
MODIFY COLUMN email VARCHAR(100) FIRST;
```

## Move a Column After Another Column
Use AFTER to move a column after a specific column.
For example, move gender after name:
SQL COMMAND
```sql
ALTER TABLE users
MODIFY COLUMN gender ENUM('Male', 'Female', 'Other')
AFTER name;
```
You can use the same method to move other columns:
```sql
ALTER TABLE users
MODIFY COLUMN email VARCHAR(100) AFTER gender;
```
Note: MySQL does not have a LAST keyword for moving columns. To place a column at the end, use AFTER with the column that should come immediately before it.

Note: While moving/modifying the column we are suppose to mention the data type of the column as well, make sure to mention the full/all the data types associated with the column as it is otherwise it will be silently modified.
Example:
```sql
ALTER TABLE users
MODIFY COLUMN created_at TIMESTAMP AFTER city;
```

## Add Multiple Columns
You can add multiple columns in a single query.
SQL COMMAND
```sql
ALTER TABLE users
ADD COLUMN phone VARCHAR(15),
ADD COLUMN city VARCHAR(100);
```

## Rename a Column
Use RENAME COLUMN to change a column's name.
SQL COMMAND
```sql
ALTER TABLE users
RENAME COLUMN phone TO mobile_number;
```

## Useful Command
To check the table after making changes:
```sql
SELECT * FROM users;
```
Remove multiple columns