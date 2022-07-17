#!/bin/bash

do_chk_provision_db_users(){

   test -z ${PROJ_CONF_FILE:-} && export PROJ_CONF_FILE="$PRODUCT_DIR/cnf/env/$ENV.env.json"
   source $PRODUCT_DIR/lib/bash/funcs/export-json-section-vars.sh
   do_export_json_section_vars $PROJ_CONF_FILE '.env.db'

	# generate the sql for the provisioning of the postgres_sys_usr_admin
	cat << EOF_SQL_CODE > /tmp/$$.tmp.sql
		DO
		\$\$
		DECLARE r record;
			BEGIN
				IF NOT EXISTS (
					SELECT
					FROM   pg_catalog.pg_roles
					WHERE  rolname = '$postgres_sys_usr_admin') THEN
						CREATE ROLE "$postgres_sys_usr_admin" WITH SUPERUSER CREATEROLE
						CREATEDB REPLICATION BYPASSRLS PASSWORD '$postgres_sys_usr_admin_pw' LOGIN ;
				END IF;
			END ;
		\$\$;
		ALTER ROLE $postgres_sys_usr_admin WITH SUPERUSER CREATEROLE
			CREATEDB REPLICATION BYPASSRLS PASSWORD  '$postgres_sys_usr_admin_pw' LOGIN ;
   	GRANT ALL PRIVILEGES ON DATABASE POSTGRES TO $postgres_sys_usr_admin" ;
EOF_SQL_CODE

	# run the sql for the provisioning of the postgres_sys_usr_admin
	sudo -Hiu postgres PGPASSWORD=$postgres_rdbms_usr_pw psql --port $postgres_rdbms_port \
         --host $postgres_rdbms_host -d postgres < /tmp/$$.tmp.sql
	rm -rv /tmp/$$.tmp.sql

	# verify the sql for the provisioning of the postgres_sys_usr_admin
  sudo -Hiu postgres PGPASSWORD=$postgres_rdbms_usr_pw psql --port $postgres_rdbms_port \
         --host $postgres_rdbms_host -d postgres -c '\du'
}
