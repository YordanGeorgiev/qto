# src/bash/issue-tracker/funcs/xls-to-db.func.sh

# v0.1.8
# ---------------------------------------------------------
# todo: add doXlsToDb comments ...
# ---------------------------------------------------------
doXlsToDb(){

	doLog "DEBUG START doXlsToDb"
	
	# cat doc/txt/issue-tracker/funcs/xls-to-db.func.txt
	
	sleep "$sleep_interval"
   test -z ${issues_order_by_attribute+x} && export issues_order_by_attribute='category'
   test -z ${period+x} && export period='daily'
   test -z ${tables+x} && export tables='daily_issues'

   # find out the latest xls file from the project daily dir
   # pass it to the xls-to-rdbms tool as the input xls file
   
   test -z ${xls_file+x} && \
      export xls_file=$(find $proj_txt_dir -name '*.xlsx'| grep '.all.'| sort -nr|head -n 1)
   test -z ${xls_file+x} && \
      export xls_file=$(find $proj_txt_dir -name '*.xlsx'| grep $period| sort -nr|head -n 1)
   # Action !!!
   perl src/perl/issue_tracker/script/issue_tracker.pl \
      --do xls-to-db --xls-file $xls_file --tables $tables
   exit_code=$?
   
#   psql -d "$db_name" -c '
#   SELECT category , substring ( description from 0 for 40 ) as descrption , start_time , stop_time
#   FROM '"$tables"'_issues order by '"$issues_order_by_attribute"'
#   ;';

   doLog "INFO doRunIssueTracker exit_code $exit_code"
   test $exit_code -ne 0 && doExit $exit_code "failed to run issue_tracker.pl"  
  
	doLog "DEBUG STOP  doXlsToDb"
}
# eof func doXlsToDb


# eof file: src/bash/issue-tracker/funcs/xls-to-db.func.sh
