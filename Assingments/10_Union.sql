select name from users
union 
select name from admin_users;

select email, name, 'User' as role from users
union
select email, name, 'Admin' as role from admin_users;