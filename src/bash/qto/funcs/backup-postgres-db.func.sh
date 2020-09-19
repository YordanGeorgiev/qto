# src/bash/qto/funcs/backup-postgres-db.func.sh

# ---------------------------------------------------------
# create a full database backup containing db create clause
# ---------------------------------------------------------
doBackupPostgresDb(){

   source $PROJ_INSTANCE_DIR/.env ; env_type=$ENV_TYPE
   test -z ${PROJ_CONF_FILE:-} && export PROJ_CONF_FILE="$PROJ_INSTANCE_DIR/cnf/env/$env_type.env.json"
   source $PROJ_INSTANCE_DIR/lib/bash/funcs/export-json-section-vars.sh
   do_export_json_section_vars $PROJ_CONF_FILE '.env.db'

   mix_data_dir="$PROJ_INSTANCE_DIR/dat/mix"

   backup_dir=$mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")/sql/$postgres_app_db
   backup_fname=$postgres_app_db.`date "+%Y%m%d_%H%M%S"`.full.dmp.sql
   test -d $backup_dir || mkdir -p $backup_dir

   which nmap 2>/dev/null && nmap -Pnv -p $postgres_rdbms_port $postgres_rdbms_host || \
         do_exit 1 "cannot connect to $postgres_rdbms_port:$postgres_rdbms_host"

   PGPASSWORD="${postgres_sys_usr_admin_pw:-}" pg_dump -U "${postgres_sys_usr_admin:-}"  \
         -h $postgres_rdbms_host -p $postgres_rdbms_port -w --format=plain \
         $postgres_app_db   > $backup_dir/$backup_fname

   ls -1 $mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")/sql/$postgres_app_db/* | sort -nr
   echo -e "\n"
   wc -l $mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")/sql/$postgres_app_db/* | sort -nr
   sleep 1
   
   echo "Full database backup completed successfully."

}
# eof file: src/bash/qto/funcs/backup-postgres-db.func.sh
