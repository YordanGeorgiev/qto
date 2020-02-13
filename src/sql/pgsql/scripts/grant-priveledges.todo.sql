
	EXECUTE format( 'REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM %I'
			, current_setting('myvars.postgres_db_user', true)::text 
			, current_setting('myvars.postgres_db_user_pw', true)::text
	);
	EXECUTE format( 'REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM %I'
			, current_setting('myvars.postgres_db_user', true)::text 
			, current_setting('myvars.postgres_db_user_pw', true)::text
	);
	EXECUTE format( 'REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public FROM %I'
			, current_setting('myvars.postgres_db_user', true)::text 
			, current_setting('myvars.postgres_db_user_pw', true)::text
	);
	EXECUTE format( 'REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public FROM %I'
			, current_setting('myvars.postgres_db_user', true)::text 
			, current_setting('myvars.postgres_db_user_pw', true)::text
	);
	EXECUTE format( 'REASSIGN OWNED BY %I TO postgres;'
			, current_setting('myvars.postgres_db_user', true)::text 
	);
	EXECUTE format( 'DROP OWNED BY %I CASCADE' 
			, current_setting('myvars.postgres_db_user', true)::text 
	);
