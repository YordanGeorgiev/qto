# src/bash/qto/funcs/db-to-gsheet.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestDbToGsheet comments ...
# ---------------------------------------------------------
doTestDbToGsheet(){

	doLog "DEBUG START doTestDbToGsheet"
	
	cat doc/txt/qto/tests/db-to-gsheet.test.txt
	
	sleep "$sleep_interval"
	# Action !!!
   bash src/bash/qto/qto.sh -a db-to-gsheet -t $tables

	doLog "DEBUG STOP  doTestDbToGsheet"
}
# eof func doTestDbToGsheet


# eof file: src/bash/qto/funcs/db-to-gsheet.test.sh
