show databases;
select * from users;

select name, gender from users;
select gender, name from users;

SELECT gender, name
FROM users
ORDER BY CASE
    WHEN gender = 'Male' THEN 1
    WHEN gender = 'Female' THEN 2
    ELSE 3
END;

Select * from users where gender='Male';

select * from users where gender!='Male';

Select * from users where date_of_birth<'1995-09-09';

select name, gender, salary from users where id != 10;

Select id, name, email, gender from users where id<=5;

select * from users where id=null;

select * from users where id is not null;

select * from users where date_of_birth between '1999-01-01'and'2000-01-01';
