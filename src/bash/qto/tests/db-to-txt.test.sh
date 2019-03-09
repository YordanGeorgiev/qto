# src/bash/qto/funcs/db-to-txt.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestDbToTxt comments ...
# ---------------------------------------------------------
doTestDbToTxt(){

	doLog "DEBUG START doTestDbToTxt"
	
	cat doc/txt/qto/tests/db-to-txt.test.txt
	
	sleep "$sleep_interval"
	# Action !!!
   src/bash/qto/qto.sh -a db-to-txt

   exit_code=$?
   sleep "$sleep_interval"
   test $exit_code -ne 0 && return

	doLog "DEBUG STOP  doTestDbToTxt"
}
# eof func doTestDbToTxt


# eof file: src/bash/qto/funcs/db-to-txt.test.sh
