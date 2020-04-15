
CREATE FUNCTION func_get_items_roles_permissions()
  RETURNS TABLE (
                 id                 bigint
               , roles_name         varchar(200)
               , table_name         varchar(200)
               , route_name         varchar(200)
               , name               varchar(200)
 ) AS 
$func$
BEGIN
   RETURN QUERY
   SELECT 
		ROW_NUMBER () OVER (ORDER BY roles.guid) as id
      , roles.name   as roles_name
      , t2.name      as table_name
      , t3.name      as route_name
		, cast(roles.name || '__' || t3.name || '__ON__' || t2.name as varchar(200))  as name
   from roles
   cross join (
      SELECT app_items.guid , app_items.name 
         FROM app_items
         WHERE 1=1 and app_items.name not like 'test_%'
         ) t2
   cross join (
      SELECT meta_routes.guid , meta_routes.name FROM meta_routes) t3
   
;
END
$func$  LANGUAGE plpgsql;

-- INSERT INTO items_roles_permissions ( roles_guid,app_items_guid,meta_routes_guid,name,description) 
-- call by: psql -d dev_qto -c "select * from func_get_items_roles_permissions() "
