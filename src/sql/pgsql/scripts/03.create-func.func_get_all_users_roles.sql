-- DROP FUNCTION func_get_all_users_app_roles ;
create or replace function func_get_all_users_app_roles() returns setof record as
'
declare
r record;
begin
for r in EXECUTE ''
   SELECT users.id, email, password, app_roles.name as app_roles
   FROM user_app_roles
   LEFT JOIN app_roles ON (app_roles.guid = user_app_roles.app_roles_guid)
   LEFT JOIN users ON (users.guid = user_app_roles.users_guid)
   WHERE 1=1
''  loop
return next r;
end loop;
return;
end
'
language 'plpgsql';


-- select * from func_get_all_users_app_roles();
-- call by: 
-- psql -d dev_qto -c "select * from func_get_all_users_app_roles() as users_app_roles(id bigint, email varchar(200), password varchar(200), app_roles varchar(100))"


