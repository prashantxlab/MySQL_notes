insert into users values (1, 'Prashant', 'Male','pras@mail.com', '2000-02-17', default);
insert into users (name, gender, email, date_of_birth) 
values('Prashant2', 'Male','pras2@mail.com', '2001-02-17');
Select * from users;

insert into users (name, gender, email, date_of_birth) 
values('Prashant3', 'Male','pras3@mail.com', '2002-02-17');
Select * from users;

desc users;

alter table users modify column id int auto_increment;
alter table users modify column created_at timestamp, default current_timestamp;

drop database startersql;
