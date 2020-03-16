
CREATE FUNCTION func_get_all_users_roles()
  RETURNS TABLE (
                 id           bigint
               , users_id     bigint
               , email        varchar(200)
               , user_name    varchar(200)
               , user_status       smallint
               , roles        varchar(100)
               , description  varchar(200)
 ) AS 
$func$
BEGIN
   RETURN QUERY
   SELECT 
		ROW_NUMBER () OVER (ORDER BY users.id) as id
		, users.id as users_id
		, users.email as email
		, users.name as user_name 
      , users.status as user_status
		, roles.name as role
		, user_roles.description as description
   FROM user_roles
   LEFT JOIN roles ON (roles.guid = user_roles.roles_guid)
   LEFT JOIN users ON (users.guid = user_roles.users_guid)
   WHERE 1=1
;
END
$func$  LANGUAGE plpgsql;

-- call by: psql -d dev_qto -c "select * from func_get_all_users_roles() "
