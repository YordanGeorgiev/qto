# src/bash/issue-tracker/funcs/run-issue-tracker.func.sh

# v1.1.1
# ---------------------------------------------------------
# todo: add doRunIssueTracker comments ...
# ---------------------------------------------------------
doRunIssueTracker(){

	doLog "DEBUG START doRunIssueTracker"

   # uncoment to sshow the specs 	
   #	cat doc/txt/issue-tracker/funcs/perl/run-issue-tracker.func.txt
	# test -z "$sleep_interval" || sleep "$sleep_interval"
   # add your action implementation code here ... 
   #   nice_date=$(date "+%Y-%m-%d")
   #   nice_year=$(date "+%Y")
   #   nice_year_month=$(date "+%Y-%m")
   # issues_file='/vagrant/futu/futu-here/doc/here.issues.'"$nice_date"'.sh'
   # issues_file='/vagrant/csitea/issue-tracker/doc/txt/issues/'"$nice_year"'/'"$nice_year_month"'/'$nice_date'/issue-tracker.issues.'"$nice_date"'.daily.txt'
   # Action ... !!!
   #   perl src/perl/issue_tracker/script/issue_tracker.pl --do file-to-db --issues_file $issues_file
   #   exit_code=$?
   #   doLog "INFO doRunIssueTracker exit_code $exit_code"
   #   test $exit_code -ne 0 && doExit $exit_code "failed to run issue_tracker.pl"  

 
   # run with pre-defined in the shell prjoject 
   doLog "INFO START testing file-to-db"
   perl src/perl/issue_tracker/script/issue_tracker.pl --do file-to-db 
   exit_code=$?
   doLog "INFO doRunIssueTracker exit_code $exit_code"
   test $exit_code -ne 0 && doExit $exit_code "failed to run issue_tracker.pl"  
  
 
   doLog "INFO START testing db-to-xls"
   # perl src/perl/issue_tracker/script/issue_tracker.pl --do db-to-xls --issues_file $issues_file \
   perl src/perl/issue_tracker/script/issue_tracker.pl --do db-to-xls
   exit_code=$?
   doLog "INFO doRunIssueTracker exit_code $exit_code"
   test $exit_code -ne 0 && doExit $exit_code "failed to run issue_tracker.pl"  
   

   doLog "INFO START testing file-to-db"
   perl src/perl/issue_tracker/script/issue_tracker.pl --do db-to-txt
   exit_code=$?
   doLog "INFO doRunIssueTracker exit_code $exit_code"
   test $exit_code -ne 0 && doExit $exit_code "failed to run issue_tracker.pl"  
#
	doLog "DEBUG STOP  doRunIssueTracker"
}
# eof func doRunIssueTracker


# eof file: src/bash/issue-tracker/funcs/run-issue-tracker.func.sh
