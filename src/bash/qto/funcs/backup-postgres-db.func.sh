# src/bash/qto/funcs/backup-postgres-db.func.sh

# v0.6.5
# ---------------------------------------------------------
# cat doc/txt/qto/funcs/backup-postgres-db.func.txt
# ---------------------------------------------------------
doBackupPostgresDb(){

	doLog "DEBUG START doBackupPostgresDb"
	# Action !!!
   test -z "${proj_instance_dir-}" && proj_instance_dir="$product_instance_dir"
   test -z "${mix_data_dir-}" && mix_data_dir="$proj_instance_dir/dat/mix"

   test -z "${postgres_db_name-}" && postgres_db_name="${env_type-}"_"${run_unit//-/_}"
   mkdir -p $mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")/sql/$postgres_db_name/; 

   PGPASSWORD="${postgres_db_useradmin_pw:-}" pg_dump -v ON_ERROR_STOP=1 -q -t -X -w -U "${postgres_db_useradmin:-}" \
   --column-inserts --data-only $postgres_db_name  > \
   $mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")/sql/$postgres_db_name/$postgres_db_name.`date "+%Y%m%d_%H%M%S"`.insrt.dmp.sql 
   ls -1 $mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")/sql/$postgres_db_name/* | sort -nr
   wc -l $mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")/sql/$postgres_db_name/* | sort -nr
	
	sleep "$sleep_interval"

	doLog "DEBUG STOP  doBackupPostgresDb"
}


# eof file: src/bash/qto/funcs/backup-postgres-db.func.sh
