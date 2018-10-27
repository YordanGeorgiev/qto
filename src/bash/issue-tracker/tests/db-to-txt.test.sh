# src/bash/issue-tracker/funcs/db-to-txt.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestDbToTxt comments ...
# ---------------------------------------------------------
doTestDbToTxt(){

	doLog "DEBUG START doTestDbToTxt"
	
	cat doc/txt/issue-tracker/tests/db-to-txt.test.txt
	
	sleep "$sleep_interval"
	# Action !!!
   src/bash/issue-tracker/issue-tracker.sh -a db-to-txt

   exit_code=$?
   sleep "$sleep_interval"
   test $exit_code -ne 0 && return

	doLog "DEBUG STOP  doTestDbToTxt"
}
# eof func doTestDbToTxt


# eof file: src/bash/issue-tracker/funcs/db-to-txt.test.sh
