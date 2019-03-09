# src/bash/qto/funcs/db-to-xls.func.sh

# v1.0.9
# ---------------------------------------------------------
# the wrapper func for db to xls issues conversion
# cat doc/txt/qto/funcs/db-to-xls.func.txt
# ---------------------------------------------------------
doDbToXls(){

	doLog "DEBUG START doDbToXls"
	
	
	sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!
   doLog "INFO START testing db-to-xls"
   test -z ${tables+x} && export tables='daily_issues'
   perl src/perl/qto/script/qto.pl --do db-to-xls --tables $tables
   exit_code=$?
   doLog "INFO doRunQto exit_code $exit_code"
   test $exit_code -ne 0 && doExit $exit_code "failed to run qto.pl"  
   


	doLog "DEBUG STOP  doDbToXls"
}
# eof func doDbToXls


# eof file: src/bash/qto/funcs/db-to-xls.func.sh
