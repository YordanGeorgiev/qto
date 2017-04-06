# src/bash/issue-tracker/funcs/log-test-run-entry.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestLogTestRunEntry comments ...
# ---------------------------------------------------------
doTestLogTestRunEntry(){

	doLog "DEBUG START doTestLogTestRunEntry"
	
	cat doc/txt/issue-tracker/tests/log-test-run-entry.test.txt
	
	test -z "$sleep_interval" || sleep "$sleep_interval"

   action_n='some-action-name'

   # should initialize the test run report
   doLogTestRunEntry 'INIT'

   doLogTestRunEntry 'START'
   
   # should register the test line start time
   doLogTestRunEntry 'INFO' ' '$(date "+%H:%M:%S")
   
   # should register the test line stop time
   doLogTestRunEntry 'INFO' ' '$(date "+%H:%M:%S")
   
   # should addd the name of the action to test 
   doLogTestRunEntry 'INFO' ' '"$action_n"
   
   # should close the test run line
   doLogTestRunEntry 'STOP' 0
   
   # should close and print the test run report 
   doLogTestRunEntry 'STATUS'

	doLog "DEBUG STOP  doTestLogTestRunEntry"
}
# eof func doTestLogTestRunEntry


# eof file: src/bash/issue-tracker/funcs/log-test-run-entry.test.sh
