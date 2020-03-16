
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
      SELECT meta_tables.guid , meta_tables.name 
         FROM meta_tables
         WHERE 1=1 and meta_tables.name not like 'test_%'
         ) t2
   cross join (
      SELECT meta_routes.guid , meta_routes.name FROM meta_routes) t3
   
;
END
$func$  LANGUAGE plpgsql;

-- INSERT INTO items_roles_permissions ( roles_guid,meta_tables_guid,meta_routes_guid,name,description) 
-- call by: psql -d dev_qto -c "select * from func_get_items_roles_permissions() "
