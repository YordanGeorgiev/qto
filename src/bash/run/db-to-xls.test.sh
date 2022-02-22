# src/bash/qto/funcs/db-to-xls.test.sh

# v0.6.9
# ---------------------------------------------------------
# the wrapper func around the db to xls conversion
# ---------------------------------------------------------
doTestDbToXls(){

	do_log "DEBUG START doTestDbToXls"
	
	cat doc/txt/qto/tests/db-to-xls.test.txt
	
	sleep "$sleep_interval"
	# Action !!!
   src/bash/qto/qto.sh -a db-to-xls
   
   exit_code=$?
	do_log "INFO txt-to-db.test-1 exit_code: $exit_code "
   sleep "$sleep_interval"
   test $exit_code -ne 0 && return

	do_log "DEBUG STOP  doTestDbToXls"
}


# eof file: src/bash/qto/funcs/db-to-xls.test.sh
