# src/bash/issue-tracker/funcs/backup-postgres-db.func.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/funcs/backup-postgres-db.func.txt
# ---------------------------------------------------------
doBackupPostgresDb(){

	doLog "DEBUG START doBackupPostgresDb"
	
	# Action !!!
   mkdir -p $mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")/sql/$postgres_db_name/; 
   pg_dump  --column-inserts --data-only $postgres_db_name  > \
   $mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")/sql/$postgres_db_name/$postgres_db_name.`date "+%Y%m%d_%H%M%S"`.insrt.dmp.sql 
   ls -1 $mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")/sql/$postgres_db_name/* | sort -nr
	
	sleep "$sleep_interval"

	doLog "DEBUG STOP  doBackupPostgresDb"
}


# eof file: src/bash/issue-tracker/funcs/backup-postgres-db.func.sh
