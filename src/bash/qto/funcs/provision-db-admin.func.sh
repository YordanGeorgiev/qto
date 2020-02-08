doProvisionDbAdmin(){

   test -z "${PROJ_INSTANCE_DIR-}" && export PROJ_INSTANCE_DIR="$PRODUCT_INSTANCE_DIR"
   source $PROJ_INSTANCE_DIR/.env ; env_type=$ENV_TYPE
   test -z ${PROJ_CONF_FILE:-} && export PROJ_CONF_FILE="$PROJ_INSTANCE_DIR/cnf/env/$env_type.env.json"

   doExportJsonSectionVars $PROJ_CONF_FILE '.env.db'
   doLog "INFO using PROJ_INSTANCE_DIR: $PROJ_INSTANCE_DIR" ; 
   doLog "INFO using PROJ_CONF_FILE: $PROJ_CONF_FILE"

   echo 'export PS1="`date "+%F %T"` \u@\h  \w \\n\\n  "' | sudo tee -a /var/lib/postgresql/.bashrc
   # uncomment to run manually
   # echo "copy-paste: $postgres_usr_pw"
   # sudo -u postgres psql -c "\password"  ; exit ;
   sudo -u root echo "postgres:$postgres_os_usr_pw" | sudo chpasswd

   expect <<- EOF_EXPECT
      set timeout -1
      spawn sudo -u postgres psql --port $postgres_db_port -c "\\\password"
      expect "Enter new password: "
      send -- "$postgres_usr_pw\r"
      expect "Enter it again: "
      send -- "$postgres_usr_pw\r"
      expect eof
EOF_EXPECT

   cd /tmp/
   sudo -u postgres PGPASSWORD=$postgres_usr_pw psql --port $postgres_db_port --host $postgres_db_host -c "
	DO \$\$DECLARE r record;
		BEGIN
			IF NOT EXISTS (
				SELECT 
				FROM   pg_catalog.pg_roles
				WHERE  rolname = '"$postgres_db_useradmin"') THEN
					CREATE ROLE "$postgres_db_useradmin" WITH SUPERUSER CREATEROLE 
               CREATEDB REPLICATION BYPASSRLS PASSWORD '"$postgres_db_useradmin_pw"' LOGIN ;
			END IF;
		END\$\$;
	ALTER ROLE "$postgres_db_useradmin" WITH SUPERUSER CREATEROLE 
   CREATEDB REPLICATION BYPASSRLS PASSWORD  '"$postgres_db_useradmin_pw"' LOGIN ; 
"
   sudo -u postgres PGPASSWORD=$postgres_usr_pw psql --port $postgres_db_port --host $postgres_db_host -c "
      grant all privileges on database postgres to $postgres_db_useradmin" ;
   sudo -u postgres PGPASSWORD=$postgres_usr_pw psql --port $postgres_db_port --host $postgres_db_host -c "
      grant all privileges on database $postgres_db_name to $postgres_db_useradmin" ;
   sudo -u postgres PGPASSWORD=$postgres_usr_pw psql --port $postgres_db_port \
      --host $postgres_db_host -d $postgres_db_name -c "
      GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public 
      TO $postgres_db_user ;"

   psql -d "$postgres_db_name" -c "GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON ALL TABLES 
   IN SCHEMA public TO $postgres_db_user; 
   GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO $postgres_db_user"
   cd -

}
