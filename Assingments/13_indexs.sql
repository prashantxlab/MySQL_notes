use startersql;
select * from users;

show indexes from users;
select * from users where email='aarav@example.com' and gender='Male';

create index idx_email on users(gender);
create index idx_gender_salary on users(gender,salary);

drop index idx_email on users;