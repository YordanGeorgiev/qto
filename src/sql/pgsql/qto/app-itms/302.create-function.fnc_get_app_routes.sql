CREATE FUNCTION fnc_get_app_routes()
	RETURNS TABLE (
			  id				bigint
			, is_open		bool 
			, is_open_in	bool 
			, is_backend	bool 
			, has_subject	bool 
			, name			varchar (200)
	) AS 
$func$
BEGIN
	RETURN QUERY
	SELECT 
		ROW_NUMBER () OVER (ORDER BY app_routes.name) as id
		, app_routes.is_open as is_open
		, app_routes.is_open_in as is_open_in
		, app_routes.is_backend as is_backend
		, app_routes.has_subject as has_subject
		, app_routes.name as name
	FROM app_routes
	WHERE 1=1
;
END
$func$  LANGUAGE plpgsql;

-- \echo 'call by: psql -d dev_qto -c "select * from fnc_get_app_routes() "'
