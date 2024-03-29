# src/bash/qto/funcs/backup-postgres-db.test.sh

doTestBackupPostgresDb(){

	do_log "DEBUG START doTestBackupPostgresDb"
	
	# Action !!!
   bash src/bash/qto/qto.sh -a backup-postgres-db
	sleep "$sleep_interval"
   
   # there should be at least one file in the current daily dir which is not older than 
   while read -r f; do 
      count=$(( count + 1 ))
   done < <(find $mix_data_dir/`date "+%Y"`/`date "+%Y-%m"`/`date "+%Y-%m-%d"`/sql/$postgres_app_db -name '*full.dmp.sql' -mmin -1)

   if [ $count -lt 1 ]; then
      msg="db dump files are not found !!!"
      export exit_code=1 ;
      do_exit "$msg";
      exit 1 ;
   fi
   
   msg="at least one db dump file was created"
   test $exit_code -ne 0 && return
 
	do_log "DEBUG STOP  doTestBackupPostgresDb"
}
# eof func doTestBackupPostgresDb


# eof file: src/bash/qto/funcs/backup-postgres-db.test.sh
