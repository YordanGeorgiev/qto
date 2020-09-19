doSetUpDbRoles(){
   test -z "${PROJ_INSTANCE_DIR-}" && export PROJ_INSTANCE_DIR="$PRODUCT_INSTANCE_DIR"
   source $PROJ_INSTANCE_DIR/.env ; env_type=$ENV_TYPE
   test -z ${PROJ_CONF_FILE:-} && export PROJ_CONF_FILE="$PROJ_INSTANCE_DIR/cnf/env/$env_type.env.json"
   do_export_json_section_vars $PROJ_CONF_FILE '.env.db'
   do_log "INFO using PROJ_INSTANCE_DIR: $PROJ_INSTANCE_DIR" ; 
   do_log "INFO using PROJ_CONF_FILE: $PROJ_CONF_FILE"
   echo 'export PS1="`date "+%F %T"` \u@\h  \w \\n\\n  "' | sudo tee -a /var/lib/postgresql/.bashrc
   sudo -u root echo "postgres:$postgres_rdbms_usr_pw" | sudo chpasswd

   expect <<- EOF_EXPECT
      set timeout -1
      spawn sudo -u postgres psql --port $postgres_rdbms_port -c "\\\password"
      expect "Enter new password: "
      send -- "$postgres_usr_pw\r"
      expect "Enter it again: "
      send -- "$postgres_usr_pw\r"
      expect eof
EOF_EXPECT

   
   cd /tmp ; sudo -u postgres PGPASSWORD=$postgres_usr_pw psql --port $postgres_rdbms_port -d postgres --host $postgres_rdbms_host -c "
	DO \$\$DECLARE r record;
		BEGIN
			IF NOT EXISTS (
				SELECT 
				FROM   pg_catalog.pg_roles
				WHERE  rolname = '"$postgres_sys_usr_admin"') THEN
					CREATE ROLE "$postgres_sys_usr_admin" WITH SUPERUSER CREATEROLE 
               CREATEDB REPLICATION BYPASSRLS PASSWORD '"$postgres_sys_usr_admin_pw"' LOGIN ;
			END IF;
		END\$\$;
	ALTER ROLE "$postgres_sys_usr_admin" WITH SUPERUSER CREATEROLE 
   CREATEDB REPLICATION BYPASSRLS PASSWORD  '"$postgres_sys_usr_admin_pw"' LOGIN ; "
   sudo -u postgres PGPASSWORD=$postgres_usr_pw psql --port $postgres_rdbms_port --host $postgres_rdbms_host -c "
      grant all privileges on database postgres to $postgres_sys_usr_admin" ; cd -

}
