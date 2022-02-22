# src/bash/qto/funcs/db-to-gsheet.func.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/qto/funcs/db-to-gsheet.func.txt
# ---------------------------------------------------------
doDbToGsheet(){

	do_log "DEBUG START doDbToGsheet"
	
	
	sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!
   do_log "INFO START testing db-to-gsheet"
   test -z ${tables+x} && export tables='daily_issues'
   perl src/perl/qto/script/qto.pl --do db-to-gsheet --tables $tables
   exit_code=$?
   do_log "INFO doRunQto exit_code $exit_code"
   test $exit_code -ne 0 && do_exit $exit_code "failed to run qto.pl"  
   



	do_log "DEBUG STOP  doDbToGsheet"
}
# eof func doDbToGsheet


# eof file: src/bash/qto/funcs/db-to-gsheet.func.sh
