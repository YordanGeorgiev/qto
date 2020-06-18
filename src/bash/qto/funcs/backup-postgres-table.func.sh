# src/bash/qto/funcs/backup-postgres-table.func.sh

doBackupPostgresTable(){
   
   test -z "${PROJ_INSTANCE_DIR-}" && export PROJ_INSTANCE_DIR="$product_instance_dir"
   source $PROJ_INSTANCE_DIR/.env ; env_type=$ENV_TYPE
   test -z ${PROJ_CONF_FILE:-} && export PROJ_CONF_FILE="$PROJ_INSTANCE_DIR/cnf/env/$env_type.env.json"
   do_export_json_section_vars $PROJ_CONF_FILE '.env.db'
   do_log "INFO using PROJ_INSTANCE_DIR: $PROJ_INSTANCE_DIR" ; do_log "INFO using PROJ_CONF_FILE: $PROJ_CONF_FILE"

   test -z ${table:-} && do_exit 1 "no table defined to backup !!!"
	table="$(echo -e "${table}" | sed -e 's/[[:space:]]*$//')" #or how-to to trin leading space
   dump_dir=$PROJ_INSTANCE_DIR/dat/mix/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")/tmp
   mkdir -p $dump_dir || do_exit 1 "cannot create the dump_dir: $dump_dir"
   dump_file=$dump_dir/${postgres_db_name:-}.${table:-}.$(date "+%Y%m%d_%H%M%S").data.sql

   echo "start running : pg_dump  --verbose --data-only --table public.$table $postgres_db_name "
   echo -e "\n --file $dump_file \n"

   # --verbose --data-only --table public.$table $postgres_db_name \
   PGPASSWORD="${postgres_db_useradmin_pw:-}" pg_dump -U "${postgres_db_useradmin:-}"  \
      -h $postgres_db_host -p $postgres_db_port -w \
      --verbose --table public.$table $postgres_db_name \
      --file $dump_file

   perl -pi -e "print \"DROP TABLE public.$table; \n \" if $. == 1" $dump_file
   echo "stop running : pg_dump  --verbose --data-only --table public.$table $postgres_db_name \\"
   echo -e " --file $dump_file \n"

   do_log "INFO produced the following file : $(ls -1 $dump_file)"
   do_log "INFO with the following amount of lines :"
   wc -l $dump_file
   echo -e "\n\n"
}

