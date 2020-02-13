# use this shell actios ONLY after deployment
doFixDbPermissions(){

   doProvisionDbAdmin

   doExportJsonSectionVars $PROJ_CONF_FILE '.env.db'
   doLog "INFO using PROJ_INSTANCE_DIR: $PROJ_INSTANCE_DIR" ; 
   doLog "INFO using PROJ_CONF_FILE: $PROJ_CONF_FILE"

   cd /tmp
   sudo -u postgres PGPASSWORD=$postgres_usr_pw psql --port $postgres_db_port --host $postgres_db_host -c "
      grant all privileges on database $postgres_db_name to $postgres_db_useradmin" ;

   sudo -u postgres PGPASSWORD=$postgres_usr_pw psql --port $postgres_db_port \
      --host $postgres_db_host -d $postgres_db_name -c "
      ALTER USER $postgres_db_user WITH PASSWORD '"$postgres_db_user_pw"'";

   sudo -u postgres PGPASSWORD=$postgres_usr_pw psql --port $postgres_db_port \
      --host $postgres_db_host -d $postgres_db_name -c "
      GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public 
      TO $postgres_db_user ;"

   sudo -u postgres PGPASSWORD=$postgres_usr_pw psql \
      --port $postgres_db_port --host $postgres_db_host -d "$postgres_db_name" -c \
         "GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON ALL TABLES 
         IN SCHEMA public TO $postgres_db_user; 
         GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO $postgres_db_user"
   cd -

}
