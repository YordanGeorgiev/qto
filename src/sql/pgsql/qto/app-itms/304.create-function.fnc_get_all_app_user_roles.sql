CREATE FUNCTION fnc_get_all_app_user_roles()
	RETURNS TABLE (
							id					 bigint
							 , user_id		 bigint
							 , email				varchar(200)
							 , user_name		varchar(200)
							 , user_status	smallint
							 , app_role		varchar(100)
							 , description	varchar(200)
 ) AS 
$func$
BEGIN
	 RETURN QUERY
	 SELECT 
		ROW_NUMBER () OVER (ORDER BY app_users.id) as id
		, app_users.id as user_id
		, app_users.email as email
		, app_users.name as user_name 
			, app_users.status as user_status
		, app_roles.name as app_role
		, app_user_roles.description as description
	 FROM app_user_roles
	 LEFT JOIN app_roles ON (app_roles.guid = app_user_roles.guid)
	 LEFT JOIN app_users ON (app_users.guid = app_user_roles.guid)
	 WHERE 1=1
;
END
$func$	LANGUAGE plpgsql;

-- \echo 'call by: psql -d dev_qto -c "select * from fnc_get_all_app_user_roles() "'