# src/bash/issue-tracker/funcs/run-issue-tracker.spec.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doSpecRunIssueTracker comments ...
# ---------------------------------------------------------
doSpecRunIssueTracker(){

	doLog "DEBUG START doSpecRunIssueTracker"
	
	cat doc/txt/issue-tracker/specs/perl/run-issue-tracker.spec.txt
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 

	doLog "DEBUG STOP  doSpecRunIssueTracker"
}
# eof func doSpecRunIssueTracker


# eof file: src/bash/issue-tracker/funcs/run-issue-tracker.spec.sh
