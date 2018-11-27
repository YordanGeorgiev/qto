# src/bash/issue-tracker/funcs/backup-postgres-db.func.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/funcs/backup-postgres-db.func.txt
# ---------------------------------------------------------
doBackupPostgresDb(){

	doLog "DEBUG START doBackupPostgresDb"
	# Action !!!
   test -z "${proj_instance_dir-}" && proj_instance_dir="$product_instance_dir"
   test -z "${mix_data_dir-}" && mix_data_dir="$proj_instance_dir/dat/mix"

   test -z "${postgres_db_name-}" && postgres_db_name="${env_type-}"_"${run_unit//-/_}"
   mkdir -p $mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")/sql/$postgres_db_name/; 
   pg_dump  --column-inserts --data-only $postgres_db_name  > \
   $mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")/sql/$postgres_db_name/$postgres_db_name.`date "+%Y%m%d_%H%M%S"`.insrt.dmp.sql 
   ls -1 $mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")/sql/$postgres_db_name/* | sort -nr
   wc -l $mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")/sql/$postgres_db_name/* | sort -nr
	
	sleep "$sleep_interval"

	doLog "DEBUG STOP  doBackupPostgresDb"
}


# eof file: src/bash/issue-tracker/funcs/backup-postgres-db.func.sh
