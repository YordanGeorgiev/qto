# src/bash/qto/funcs/run-data-load-tests.func.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/qto/funcs/run-data-load-tests.func.txt
# ---------------------------------------------------------
doRunDataLoadTests(){

	doLog "DEBUG START doRunDataLoadTests"
	
   doLog "INFO START test the Select Controller "
   doLog " $postgres_db_name/select-tables"
   doLog " $postgres_db_name/select/<<table-name>>"
   test_script='src/perl/qto/t/lib/Qto/Controller/LoadTestSelect.pl'
   doLog "INFO START $test_script"
   perl src/perl/qto/t/lib/Qto/Controller/LoadTestSelect.pl
   test $? -ne 0 && return
   doLog "INFO STOP  $test_script"
	echo -e "\n\n\n" 

	doLog "DEBUG STOP  doRunDataLoadTests"
}
# eof func doRunDataLoadTests


# eof file: src/bash/qto/funcs/run-data-load-tests.func.sh
