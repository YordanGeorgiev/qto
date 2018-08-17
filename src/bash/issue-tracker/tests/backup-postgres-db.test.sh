# src/bash/issue-tracker/funcs/backup-postgres-db.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestBackupPostgresDb comments ...
# ---------------------------------------------------------
doTestBackupPostgresDb(){

	doLog "DEBUG START doTestBackupPostgresDb"
	
	# Action !!!
   bash src/bash/issue-tracker/issue-tracker.sh -a backup-postgres-db
	sleep "$sleep_interval"
   
   # there should be at least one file in the current daily dir which is not older than 
   while read -r f; do 
      count=$(( count + 1 ))
   done < <(find $mix_data_dir/`date "+%Y"`/`date "+%Y-%m"`/`date "+%Y-%m-%d"`/sql/$postgres_db_name -name '*.dmp.sql' -mmin -1)

   if [ $count -lt 1 ]; then
      msg="db dump files are not found !!!"
      export exit_code=1 ;
      doExit "$msg";
      exit 1 ;
   fi
   
   msg="at least one db dump file was created"
   test $exit_code -ne 0 && return
 
	doLog "DEBUG STOP  doTestBackupPostgresDb"
}
# eof func doTestBackupPostgresDb


# eof file: src/bash/issue-tracker/funcs/backup-postgres-db.test.sh
