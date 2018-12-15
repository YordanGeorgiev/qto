# src/bash/issue-tracker/funcs/run-data-load-tests.func.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/funcs/run-data-load-tests.func.txt
# ---------------------------------------------------------
doRunDataLoadTests(){

	doLog "DEBUG START doRunDataLoadTests"
	
   doLog "INFO START test the Select Controller "
   doLog " $postgres_db_name/select-tables"
   doLog " $postgres_db_name/select/<<table-name>>"
   test_script='src/perl/issue_tracker/t/lib/IssueTracker/Controller/LoadTestSelect.pl'
   doLog "INFO START $test_script"
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/LoadTestSelect.pl
   test $? -ne 0 && return
   doLog "INFO STOP  $test_script"
	echo -e "\n\n\n" 

	doLog "DEBUG STOP  doRunDataLoadTests"
}
# eof func doRunDataLoadTests


# eof file: src/bash/issue-tracker/funcs/run-data-load-tests.func.sh
