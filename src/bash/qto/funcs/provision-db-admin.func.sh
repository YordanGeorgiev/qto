doProvisionDbAdmin(){

   source $PRODUCT_INSTANCE_DIR/lib/bash/funcs/export-json-section-vars.sh
   doExportJsonSectionVars $PRODUCT_INSTANCE_DIR/cnf/env/$ENV_TYPE.env.json '.env.db'

   sudo mkdir -p /etc/postgresql/11/main/
   sudo mkdir -p /var/lib/postgresql/11/main

   # echo "postgres:postgres" | chpasswd  # probably not needed ...
   echo 'export PS1="`date "+%F %T"` \u@\h  \w \\n\\n  "' | sudo tee -a /var/lib/postgresql/.bashrc
   
   sudo -u postgres psql -c "
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
   sudo -u postgres psql -c "grant all privileges on database postgres to "$postgres_db_useradmin" ;"

}
