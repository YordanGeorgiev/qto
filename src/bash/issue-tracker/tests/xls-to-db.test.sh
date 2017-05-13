# src/bash/issue-tracker/funcs/xls-to-db.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestXlsToDb comments ...
# ---------------------------------------------------------
doTestXlsToDb(){

	doLog "DEBUG START doTestXlsToDb"
	
	cat doc/txt/issue-tracker/tests/xls-to-db.test.txt
	
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!
   src/bash/issue-tracker/issue-tracker.sh -a xls-to-db
   exit_code=$?
   test -z "$sleep_interval" || sleep "$sleep_interval"
   test $exit_code -ne 0 && return

	doLog "DEBUG STOP  doTestXlsToDb"
}
# eof func doTestXlsToDb


# eof file: src/bash/issue-tracker/funcs/xls-to-db.test.sh
