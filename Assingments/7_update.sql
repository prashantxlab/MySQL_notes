select * from users;
insert into users (name, email, gender, date_of_birth, salary) 
values('Joginder','joginder@example.com','Other','2000-02-02','70000');

update users set salary = '45000', email='joginder@xyz.com' where id=27;

update users set salary = '45000', email='aarav@aarav.com' where email='aarav@example.com';

update users set salary = salary+10000 where salary<60000;
SET SQL_SAFE_UPDATES = 0;