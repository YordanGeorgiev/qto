doProvisionDbAdmin(){

   test -z "${PROJ_INSTANCE_DIR-}" && export PROJ_INSTANCE_DIR="$PRODUCT_INSTANCE_DIR"
   source $PROJ_INSTANCE_DIR/.env ; env_type=$ENV_TYPE
   test -z ${PROJ_CONF_FILE:-} && export PROJ_CONF_FILE="$PROJ_INSTANCE_DIR/cnf/env/$env_type.env.json"
   doExportJsonSectionVars $PROJ_CONF_FILE '.env.db'
   doLog "INFO using PROJ_INSTANCE_DIR: $PROJ_INSTANCE_DIR" ; doLog "INFO using PROJ_CONF_FILE: $PROJ_CONF_FILE"

   sudo mkdir -p /etc/postgresql/11/main/
   sudo mkdir -p /var/lib/postgresql/11/main

   # echo "postgres:postgres" | chpasswd  # probably not needed ...
   echo 'export PS1="`date "+%F %T"` \u@\h  \w \\n\\n  "' | sudo tee -a /var/lib/postgresql/.bashrc
  
   echo "postgres:$postgres_usr_pw" | sudo chpasswd
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
   cd -

}
