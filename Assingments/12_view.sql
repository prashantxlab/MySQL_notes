create view rich_user as
select * from users where salary > 70000;

select * from rich_user;

update users set salary=30000 where id=2;

drop view rich_user;