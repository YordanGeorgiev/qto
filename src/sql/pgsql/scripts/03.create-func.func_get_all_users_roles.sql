-- DROP FUNCTION func_get_all_users_roles ;
create or replace function func_get_all_users_roles() returns setof record as
'
declare
r record;
begin
for r in EXECUTE ''
   SELECT users.id, email, password, roles.name as roles
   FROM user_roles
   LEFT JOIN roles ON (roles.guid = user_roles.roles_guid)
   LEFT JOIN users ON (users.guid = user_roles.users_guid)
   WHERE 1=1
''  loop
return next r;
end loop;
return;
end
'
language 'plpgsql';


-- select * from func_get_all_users_roles();
-- call by: 
-- psql -d dev_qto -c "select * from func_get_all_users_roles() as users_roles(id bigint, email varchar(200), password varchar(200), roles varchar(100))"


