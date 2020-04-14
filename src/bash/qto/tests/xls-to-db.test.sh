# src/bash/qto/funcs/xls-to-db.test.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/qto/tests/xls-to-db.test.txt
# ---------------------------------------------------------
doTestXlsToDb(){

	do_log "DEBUG START doTestXlsToDb"
	
	
	sleep "$sleep_interval"
	# Action !!!
   export load_model='upsert'
   export rdbms_type='postgres'
   src/bash/qto/qto.sh -a xls-to-db -t monthly_issues,daily_issues
   exit_code=$?
   sleep "$sleep_interval"
   test $exit_code -ne 0 && return
   
	# Action !!!
   export load_model='nested-set'
   src/bash/qto/qto.sh -a xls-to-db -t devops_guide_doc,userstories_doc
   exit_code=$?
   sleep "$sleep_interval"
   test $exit_code -ne 0 && return

	do_log "DEBUG STOP  doTestXlsToDb"
}


# eof file: src/bash/qto/funcs/xls-to-db.test.sh
