# src/bash/issue-tracker/funcs/db-to-gsheet.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestDbToGsheet comments ...
# ---------------------------------------------------------
doTestDbToGsheet(){

	doLog "DEBUG START doTestDbToGsheet"
	
	cat doc/txt/issue-tracker/tests/db-to-gsheet.test.txt
	
	sleep "$sleep_interval"
	# Action !!!
   bash src/bash/issue-tracker/issue-tracker.sh -a db-to-gsheet -t $tables

	doLog "DEBUG STOP  doTestDbToGsheet"
}
# eof func doTestDbToGsheet


# eof file: src/bash/issue-tracker/funcs/db-to-gsheet.test.sh
