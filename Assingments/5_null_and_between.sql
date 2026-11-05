select * from users where id is null;

select * from users where name is not null;

select * from users where id between 5 and 10;

select * from users where id>=10;

select * from users where gender='Male';

-- insert into users (name, email, gender, date_of_birth, salary) 
-- Values(Hijra, hijra@example.com, Other, 2000-01-01, 69000.00);

INSERT INTO users (name, email, gender, date_of_birth, salary) VALUES
('Hijra', 'Hijra@example.com', 'Other', '2000-01-01', 69000.00);

select * from users where gender='Other';

select * from users where id between '5' and '10';

select * from users where gender='Female' and salary>'70000';
