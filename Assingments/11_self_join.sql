use startersql;
select * from users;
-- alter table users drop column reffered_by;

alter table users add column referred_by_id int;
update users set referred_by_id = 1 where id in (2,3,13,15,16,18,20);
update users set referred_by_id = 2 where id = 4;

select a.id, 
a.name as user_name,
b.name as referred_by_name
from users a 
inner join users b on a.referred_by_id = b.id;






