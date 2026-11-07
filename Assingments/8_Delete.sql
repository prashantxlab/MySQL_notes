use startersql;
select * from users;

delete from users where id = '27';

select * from users where salary < '60000';
delete from users where salary < '60000';

select * from users order by salary asc;

truncate users;

drop table users;


