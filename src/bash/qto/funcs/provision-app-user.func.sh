doProvisionDbAdmin(){

   source $PRODUCT_INSTANCE_DIR/lib/bash/funcs/export-json-section-vars.sh
   doExportJsonSectionVars $PRODUCT_INSTANCE_DIR/cnf/env/$ENV_TYPE.env.json '.env.db'

   PGPASSWORD="${postgres_db_useradmin_pw:-}" psql -q -t -X -w -U "${postgres_db_useradmin:-}" \
      -h $postgres_db_host -p $postgres_db_port \
		-v ON_ERROR_STOP=1 \
      -v postgres_db_user_pw="${postgres_db_user_pw:-}" \
      -v postgres_db_name="${postgres_db_name:-}" -c "
DO
$do$
BEGIN
   IF NOT EXISTS (
      SELECT 
      FROM   pg_catalog.pg_roles
      WHERE  rolname = '"$postgres_db_user"') THEN
		   CREATE ROLE "$postgres_db_user" WITH PASSWORD '"$postgres_db_user_pw"' LOGIN ;
   END IF;
END
$do$;
ALTER ROLE "$postgres_db_user" WITH PASSWORD  '"$postgres_db_user_pw"' LOGIN ;

ALTER DEFAULT PRIVILEGES IN SCHEMA public 
   GRANT ALL PRIVILEGES ON TABLES TO "$postgres_db_user";
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
   GRANT ALL PRIVILEGES ON SEQUENCES TO "$postgres_db_user";

GRANT SELECT ON ALL TABLES IN SCHEMA PUBLIC TO "$postgres_db_user";
GRANT SELECT ON ALL TABLES IN SCHEMA pg_catalog TO "$postgres_db_user";
GRANT ALL PRIVILEGES ON DATABASE "$postgres_db_name" TO "$postgres_db_user"
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO "$postgres_db_user" ;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO "$postgres_db_user" ; 
GRANT SELECT, INSERT, UPDATE, DELETE , REFERENCES ON ALL TABLES IN SCHEMA public TO "$postgres_db_user" ;

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolreplication, rolconnlimit FROM pg_roles 
WHERE 1=1
AND rolname='"$postgres_db_user"'
"

}
