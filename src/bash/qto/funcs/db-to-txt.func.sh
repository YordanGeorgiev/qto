# src/bash/qto/funcs/db-to-txt.func.sh

# v1.0.9
# ---------------------------------------------------------
# wrapper for fetching the issues from the db and printing them to file
# ---------------------------------------------------------
doDbToTxt(){

	doLog "DEBUG START doDbToTxt"
	
	# cat doc/txt/qto/funcs/db-to-txt.func.txt
	
	sleep "$sleep_interval"

	# Action !!!
   test -z ${tables+x} && export tables='daily_issues'
   perl src/perl/qto/script/qto.pl --do db-to-txt --tables $tables
   exit_code=$?
   doLog "INFO doRunQto exit_code $exit_code"
   test $exit_code -ne 0 && doExit $exit_code "failed to run qto.pl"  

	doLog "DEBUG STOP  doDbToTxt"
}
# eof func doDbToTxt


# eof file: src/bash/qto/funcs/db-to-txt.func.sh
