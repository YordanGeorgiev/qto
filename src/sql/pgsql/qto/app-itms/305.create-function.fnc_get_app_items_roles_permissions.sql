-- file: src/sql/pgsql/qto/app-itms/305.create-function.fnc_get_app_items_roles_permissions.sql
-- purpose: 
-- answers the question which role to what route has access to ... 
-- usage:
-- psql -d dev_qto -c "select * from fnc_get_app_items_roles_permissions() "

CREATE FUNCTION fnc_get_app_items_roles_permissions()
	RETURNS TABLE (
							id								 bigint
							 , app_roles_name				 varchar(200)
							 , table_name				 varchar(200)
							 , route_name				 varchar(200)
							 , name							 varchar(200)
 ) AS 
$func$
BEGIN
	 RETURN QUERY
	 SELECT 
		ROW_NUMBER () OVER (ORDER BY app_roles.guid) as id
			, app_roles.name	 as app_roles_name
			, t2.name			as table_name
			, t3.name			as route_name
		, cast(app_roles.name || '__' || t3.name || '__ON__' || t2.name as varchar(200))	AS name
	 FROM app_roles
	 CROSS JOIN (
			SELECT app_items.guid , app_items.name 
				 FROM app_items
				 WHERE 1=1 and app_items.name NOT LIKE 'test_%'
				 ) t2
	 CROSS JOIN (
			SELECT app_routes.guid , app_routes.name FROM app_routes) t3
	 
;
END
$func$	LANGUAGE plpgsql;