use startersql;

select * from users;
select * from addresses;

select users.name,users.gender, addresses.city, addresses.state 
from users
inner join addresses on users.id = addresses.user_id;

select users.name, addresses.city from users
left join addresses on users.id = addresses.user_id;

select users.name, addresses.city from users
right join addresses 
on users.id = addresses.user_id;
