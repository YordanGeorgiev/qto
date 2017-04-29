# src/bash/issue-tracker/funcs/txt-to-db.test.sh

# v1.1.0
# ---------------------------------------------------------
# tests the issues txt file to db load action
# ---------------------------------------------------------
doTestTxtToDb(){

	doLog "DEBUG START doTestTxtToDb"
	
	cat doc/txt/issue-tracker/tests/txt-to-db.test.txt
	
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# Action !!!
   bash  src/bash/issue-tracker/issue-tracker.sh -a txt-to-db
   exit_code=$?
	doLog " txt-to-db.test-1 exit_code: $exit_code "
   test -z "$sleep_interval" || sleep "$sleep_interval"
   test $exit_code -ne 0 && return

	doLog "DEBUG STOP  doTestTxtToDb"
}
# eof func doTestTxtToDb


# eof file: src/bash/issue-tracker/funcs/txt-to-db.test.sh
