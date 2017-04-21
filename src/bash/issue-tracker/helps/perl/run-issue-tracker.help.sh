# src/bash/issue-tracker/funcs/run-issue-tracker.help.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doHelpRunIssueTracker comments ...
# ---------------------------------------------------------
doHelpRunIssueTracker(){

	doLog "DEBUG START doHelpRunIssueTracker"
	
	cat doc/txt/issue-tracker/helps/perl/run-issue-tracker.help.txt
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 

	doLog "DEBUG STOP  doHelpRunIssueTracker"
}
# eof func doHelpRunIssueTracker


# eof file: src/bash/issue-tracker/funcs/run-issue-tracker.help.sh
