# src/bash/qto/funcs/backup-postgres-table.func.sh

# ---------------------------------------------------------
doBackupPostgresTable(){

   test -z ${table:-} && doExit 1 "no table defined to backup !!!"
	table="$(echo -e "${table}" | sed -e 's/[[:space:]]*$//')" #or how-to to trin leading space
   mkdir -p $PRODUCT_INSTANCE_DIR/dat/mix/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")/tmp
   dump_file=$PRODUCT_INSTANCE_DIR/dat/mix/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")/tmp/${table:-}.data.sql

	doLog "DEBUG START doBackupPostgresTable"
   echo "start running : pg_dump  --verbose --data-only --table public.$table $postgres_db_name "
   echo -e "\n --file $dump_file \n"

   PGPASSWORD="${postgres_db_useradmin_pw:-}" pg_dump -U "${postgres_db_useradmin:-}"  \
      -h $postgres_db_host -p $postgres_db_port -w \
      --verbose --data-only --table public.$table $postgres_db_name \
      --file $dump_file
   echo "stop running : pg_dump  --verbose --data-only --table public.$table $postgres_db_name \\"
   echo -e " --file $DataDir/tmp/$table.data.sql \n"

   doLog "INFO produced the following file : $(ls -1 $dump_file)"
   doLog "INFO with the following amount of lines :"
   wc -l $dump_file
   echo -e "\n\n"
	doLog "DEBUG STOP  doBackupPostgresTable"
}

# eof file: src/bash/qto/funcs/backup-postgres-table.func.sh
