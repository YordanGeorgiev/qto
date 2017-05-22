# src/bash/issue-tracker/funcs/xls-to-db.func.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doXlsToDb comments ...
# ---------------------------------------------------------
doXlsToDb(){

	doLog "DEBUG START doXlsToDb"
	
	cat doc/txt/issue-tracker/funcs/xls-to-db.func.txt
	
	sleep "$sleep_interval"

   # find out the latest xls file from the project daily dir
   # pass it to the xls-to-rdbms tool as the input xls file

   export xls_file=$(find $proj_txt_dir -name '*.xlsx'| sort -nr|head -n 1)
	
	# Action !!!
   # bash /opt/csitea/src/bash/xls-to-rdbms.sh -a run-xls-to-rdbms
   # bash /opt/csitea/xls-to-rdbms/xls-to-rdbms.0.0.4.dev.ysg/src/bash/xls-to-rdbms/xls-to-rdbms.sh \
   #   -a run-xls-to-rdbms 
   perl src/perl/issue_tracker/script/issue_tracker.pl \
      --do xls-to-db --xls-file $xls_file

   exit_code=$?
   doLog "INFO doRunIssueTracker exit_code $exit_code"
   test $exit_code -ne 0 && doExit $exit_code "failed to run issue_tracker.pl"  
  
	doLog "DEBUG STOP  doXlsToDb"
}
# eof func doXlsToDb


# eof file: src/bash/issue-tracker/funcs/xls-to-db.func.sh
