# src/bash/issue-tracker/funcs/run-issue-tracker.func.sh

# v1.1.1
# ---------------------------------------------------------
# todo: add doRunIssueTracker comments ...
# ---------------------------------------------------------
doRunIssueTracker(){

	doLog "DEBUG START doRunIssueTracker"
	
	cat doc/txt/issue-tracker/funcs/perl/run-issue-tracker.func.txt
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 
   nice_date=$(date "+%Y-%m-%d")
   nice_year=$(date "+%Y-%m")
   # issues_file="/vagrant/futu/futu-care/futu-care.1.0.1.prd.ysg/docs/txt/daily/""$nice_year""/""$nice_date"".daily-issues.ygeo.txt"
   issues_file='/vagrant/ysg/data/scrum/daily/'"$nice_year"'/'"$nice_date"'.daily-issues.ysg.txt'
   # issues_file='/vagrant/futu/telia/doc/txt/'"$nice_year"'/'"$nice_date"'.futu-telia-issues.txt'
   # issues_file='/vagrant/futu/telia/doc/txt/'"$nice_year"'/telia-issues.'"$nice_date"'.txt'
   # issues_file='/vagrant/futu/futu-here/doc/here.issues.'"$nice_date"'.sh'
	
   # Action ... !!!
   perl src/perl/issue_tracker/script/issue_tracker.pl --do file-to-db --issues_file $issues_file
   exit_code=$?
   doLog "INFO doRunIssueTracker exit_code $exit_code"
   test $exit_code -ne 0 && doExit $exit_code "failed to run issue_tracker.pl"  
   
   # Action ... !!!
   perl src/perl/issue_tracker/script/issue_tracker.pl --do db-to-xls --issues_file $issues_file
   exit_code=$?
   doLog "INFO doRunIssueTracker exit_code $exit_code"
   test $exit_code -ne 0 && doExit $exit_code "failed to run issue_tracker.pl"  
#
	doLog "DEBUG STOP  doRunIssueTracker"
}
# eof func doRunIssueTracker


# eof file: src/bash/issue-tracker/funcs/run-issue-tracker.func.sh
