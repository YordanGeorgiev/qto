CREATE FUNCTION fnc_get_function_args(
	IN funcname character varying,
	IN schema character varying,
	OUT pos integer,
	OUT direction character,
	OUT argname character varying,
	OUT datatype character varying)
RETURNS SETOF RECORD AS $$DECLARE
	rettype character varying;
	argtypes oidvector;
	allargtypes oid[];
	argmodes "char"[];
	argnames text[];
	mini integer;
	maxi integer;
BEGIN
	/* get object ID of function */
	SELECT INTO rettype, argtypes, allargtypes, argmodes, argnames
				 CASE
				 WHEN pg_proc.proretset
				 THEN 'setof ' || pg_catalog.format_type(pg_proc.prorettype, NULL)
				 ELSE pg_catalog.format_type(pg_proc.prorettype, NULL) END,
				 pg_proc.proargtypes,
				 pg_proc.proallargtypes,
				 pg_proc.proargmodes,
				 pg_proc.proargnames
		FROM pg_catalog.pg_proc
				 JOIN pg_catalog.pg_namespace
				 ON (pg_proc.pronamespace = pg_namespace.oid)
	 WHERE pg_proc.prorettype <> 'pg_catalog.cstring'::pg_catalog.regtype
		 AND (pg_proc.proargtypes[0] IS NULL
			OR pg_proc.proargtypes[0] <> 'pg_catalog.cstring'::pg_catalog.regtype)
		 -- AND NOT pg_proc.proisagg
		 AND pg_proc.proname = funcname
		 AND pg_namespace.nspname = schema
		 AND pg_catalog.pg_function_is_visible(pg_proc.oid);
	
	/* bail out if not found */
	IF NOT FOUND THEN
		RETURN;
	END IF;
	
	/* return a row for the return value */
	pos = 0;
	direction = 'o'::char;
	argname = 'RETURN VALUE';
	datatype = rettype;
	RETURN NEXT;
	
	/* unfortunately allargtypes is NULL if there are no OUT parameters */
	IF allargtypes IS NULL THEN
		mini = array_lower(argtypes, 1); maxi = array_upper(argtypes, 1);
	ELSE
		mini = array_lower(allargtypes, 1); maxi = array_upper(allargtypes, 1);
	END IF;
	IF maxi < mini THEN RETURN; END IF;
	
	/* loop all the arguments */
	FOR i IN mini .. maxi LOOP
		pos = i - mini + 1;
		IF argnames IS NULL THEN
			argname = NULL;
		ELSE
			argname = argnames[pos];
		END IF;
		IF allargtypes IS NULL THEN
			direction = 'i'::char;
			datatype = pg_catalog.format_type(argtypes[i], NULL);
		ELSE
			direction = argmodes[i];
			datatype = pg_catalog.format_type(allargtypes[i], NULL);
		END IF;
		RETURN NEXT;
	END LOOP;
	
	RETURN;
END;$$ LANGUAGE plpgsql STABLE STRICT SECURITY INVOKER;

COMMENT ON FUNCTION fnc_get_function_args(character varying, character
varying)
IS $$For a function name and schema, this procedure selects for each
argument the following data:
- position in the argument list (0 for the return value)
- direction 'i', 'o', or 'b'
- name (NULL if not defined)
- data type$$;

-- src: https://www.alberton.info/postgresql_meta_info.html
-- call by: psql -d dev_qto -c "SELECT * FROM	fnc_get_function_args('fnc_get_all_users_app_roles','public') "
