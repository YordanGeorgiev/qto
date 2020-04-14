# src/bash/qto/funcs/run-data-load-tests.func.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/qto/funcs/run-data-load-tests.func.txt
# ---------------------------------------------------------
doRunDataLoadTests(){

	do_log "DEBUG START doRunDataLoadTests"
	
   do_log "INFO START test the Select Controller "
   do_log " $postgres_db_name/select-tables"
   do_log " $postgres_db_name/select/<<table-name>>"
   test_script='src/perl/qto/t/lib/Qto/App/benchmarks/LoadTestSelect.t'
   do_log "INFO START $test_script"
   perl src/perl/qto/t/lib/Qto/Controller/LoadTestSelect.pl
   test $? -ne 0 && return
   do_log "INFO STOP  $test_script"
	echo -e "\n\n\n" 

	do_log "DEBUG STOP  doRunDataLoadTests"
}
# eof func doRunDataLoadTests


# eof file: src/bash/qto/funcs/run-data-load-tests.func.sh
