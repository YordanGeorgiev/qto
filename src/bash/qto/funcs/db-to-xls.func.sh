# src/bash/qto/funcs/db-to-xls.func.sh

# v0.6.9
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


# eof file: src/bash/qto/funcs/db-to-xls.func.sh
