#!/bin/bash

do_fix_db_permissions(){

   do_setup_db_roles

   test -z "${PROJ_INSTANCE_DIR-}" && PROJ_INSTANCE_DIR="$PRODUCT_DIR"

   test -z $PROJ_CONF_FILE && PROJ_CONF_FILE=$PROJ_INSTANCE_DIR/cnf/env/$ENV.env.json
   do_export_json_section_vars $PROJ_CONF_FILE '.env.db'

   do_log "INFO using PROJ_INSTANCE_DIR: $PROJ_INSTANCE_DIR" ;
   do_log "INFO using PROJ_CONF_FILE: $PROJ_CONF_FILE"

   cd /tmp
   sudo -u postgres PGPASSWORD=$postgres_usr_pw psql --port $postgres_rdbms_port --host $postgres_rdbms_host -c "
      grant all privileges on database $postgres_app_db to $postgres_sys_usr_admin" ;

   sudo -u postgres PGPASSWORD=$postgres_usr_pw psql --port $postgres_rdbms_port \
      --host $postgres_rdbms_host -d $postgres_app_db -c "
      ALTER USER $postgres_app_usr WITH PASSWORD '"$postgres_app_usr_pw"'";

   PGPASSWORD=$postgres_sys_usr_admin_pw psql -U "${postgres_sys_usr_admin:-}" \
      --host $postgres_rdbms_host --port $postgres_rdbms_port -d "$postgres_app_db" \
      -c "  GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON ALL TABLES IN SCHEMA public TO $postgres_app_usr;
            GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO $postgres_app_usr"

   sudo -u postgres PGPASSWORD=$postgres_usr_pw psql \
      --port $postgres_rdbms_port --host $postgres_rdbms_host -d "$postgres_app_db" -c \
         "GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON ALL TABLES
         IN SCHEMA public TO $postgres_app_usr;
         GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO $postgres_app_usr"
   sudo -u postgres PGPASSWORD=$postgres_usr_pw psql \
      --port $postgres_rdbms_port --host $postgres_rdbms_host -d "$postgres_app_db" -c \
         "GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO $postgres_app_usr"
   cd -

}
