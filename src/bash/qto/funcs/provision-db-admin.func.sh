doProvisionDbAdmin(){
   test -z "${proj_instance_dir-}" && export proj_instance_dir="$product_instance_dir"
   source $proj_instance_dir/.env ; env_type=$ENV_TYPE
   test -z ${proj_conf_file:-} && export proj_conf_file="$proj_instance_dir/cnf/env/$env_type.env.json"
   do_export_json_section_vars $proj_conf_file '.env.db'
   do_log "INFO using proj_instance_dir: $proj_instance_dir" ; 
   do_log "INFO using proj_conf_file: $proj_conf_file"
   echo 'export PS1="`date "+%F %T"` \u@\h  \w \\n\\n  "' | sudo tee -a /var/lib/postgresql/.bashrc
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

   
   cd /tmp ; sudo -u postgres PGPASSWORD=$postgres_usr_pw psql --port $postgres_db_port -d postgres --host $postgres_db_host -c "
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
   CREATEDB REPLICATION BYPASSRLS PASSWORD  '"$postgres_db_useradmin_pw"' LOGIN ; "
   sudo -u postgres PGPASSWORD=$postgres_usr_pw psql --port $postgres_db_port --host $postgres_db_host -c "
      grant all privileges on database postgres to $postgres_db_useradmin" ; cd -

}
