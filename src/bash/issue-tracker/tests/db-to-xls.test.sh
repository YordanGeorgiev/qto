# src/bash/issue-tracker/funcs/db-to-xls.test.sh

# v1.0.9
# ---------------------------------------------------------
# the wrapper func around the db to xls conversion
# ---------------------------------------------------------
doTestDbToXls(){

	doLog "DEBUG START doTestDbToXls"
	
	cat doc/txt/issue-tracker/tests/db-to-xls.test.txt
	
	sleep "$sleep_interval"
	# Action !!!
   src/bash/issue-tracker/issue-tracker.sh -a db-to-xls
   
   exit_code=$?
	doLog "INFO txt-to-db.test-1 exit_code: $exit_code "
   sleep "$sleep_interval"
   test $exit_code -ne 0 && return

	doLog "DEBUG STOP  doTestDbToXls"
}
# eof func doTestDbToXls


# eof file: src/bash/issue-tracker/funcs/db-to-xls.test.sh
