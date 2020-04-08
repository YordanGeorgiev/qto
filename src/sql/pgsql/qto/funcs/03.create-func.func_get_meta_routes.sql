DROP FUNCTION func_get_meta_routes ; 
CREATE FUNCTION func_get_meta_routes()
  RETURNS TABLE (
               id             bigint
             , is_open        bool 
             , is_backend     bool 
             , has_subject    bool 
             , name           varchar (200)
 ) AS 
$func$
BEGIN
   RETURN QUERY
   SELECT 
		ROW_NUMBER () OVER (ORDER BY meta_routes.name) as id
      , meta_routes.is_open as is_open
      , meta_routes.is_backend as is_backend
      , meta_routes.has_subject as has_subject
      , meta_routes.name as name
   FROM meta_routes
   WHERE 1=1
;
END
$func$  LANGUAGE plpgsql;

-- call by: psql -d dev_qto -c "select * from func_get_meta_routes() "
