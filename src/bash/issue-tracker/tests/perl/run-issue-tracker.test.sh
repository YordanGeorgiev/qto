# src/bash/issue-tracker/funcs/run-issue-tracker.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestRunIssueTracker comments ...
# ---------------------------------------------------------
doTestRunIssueTracker(){

	doLog "DEBUG START doTestRunIssueTracker"
	
	cat doc/txt/issue-tracker/tests/perl/run-issue-tracker.test.txt
	test -z "$sleep_interval" || sleep "$sleep_interval"

	# Action !!!	
	bash src/bash/issue-tracker/issue-tracker.sh -a run-issue-tracker
   exit_code=$?
	doLog " run-issue-tracker.test-1 exit_code: $exit_code "

   test -z "$sleep_interval" || sleep "$sleep_interval"
   test $exit_code -ne 0 && return

	doLog "DEBUG STOP  doTestRunIssueTracker"

}
# eof func doTestRunIssueTracker


# eof file: src/bash/issue-tracker/funcs/run-issue-tracker.test.sh
