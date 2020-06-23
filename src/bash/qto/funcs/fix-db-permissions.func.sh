# use this shell actios ONLY after deployment
doFixDbPermissions(){

   doProvisionDbAdmin

   test -z "${proj_instance_dir-}" && proj_instance_dir="$product_instance_dir"
   source $proj_instance_dir/.env ; env_type=$ENV_TYPE
   test -z $proj_conf_file && proj_conf_file=$proj_instance_dir/cnf/env/$env_type.env.json
   do_export_json_section_vars $proj_conf_file '.env.db'

   do_log "INFO using proj_instance_dir: $proj_instance_dir" ; 
   do_log "INFO using proj_conf_file: $proj_conf_file"

   cd /tmp
   sudo -u postgres PGPASSWORD=$postgres_usr_pw psql --port $postgres_db_port --host $postgres_db_host -c "
      grant all privileges on database $postgres_db_name to $postgres_db_useradmin" ;

   sudo -u postgres PGPASSWORD=$postgres_usr_pw psql --port $postgres_db_port \
      --host $postgres_db_host -d $postgres_db_name -c "
      ALTER USER $postgres_db_user WITH PASSWORD '"$postgres_db_user_pw"'";

   PGPASSWORD=$postgres_db_useradmin_pw psql -U "${postgres_db_useradmin:-}" \
      --host $postgres_db_host --port $postgres_db_port -d "$postgres_db_name" \
      -c "  GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON ALL TABLES IN SCHEMA public TO $postgres_db_user; 
            GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO $postgres_db_user"

   sudo -u postgres PGPASSWORD=$postgres_usr_pw psql \
      --port $postgres_db_port --host $postgres_db_host -d "$postgres_db_name" -c \
         "GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON ALL TABLES 
         IN SCHEMA public TO $postgres_db_user; 
         GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO $postgres_db_user"
   sudo -u postgres PGPASSWORD=$postgres_usr_pw psql \
      --port $postgres_db_port --host $postgres_db_host -d "$postgres_db_name" -c \
         "GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO $postgres_db_user"
   cd -

}
