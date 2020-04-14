# src/bash/qto/funcs/log-test-run-entry.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestLogTestRunEntry comments ...
# ---------------------------------------------------------
doTestLogTestRunEntry(){

	do_log "DEBUG START doTestLogTestRunEntry"
	
	cat doc/txt/qto/tests/log-test-run-entry.test.txt
	
	sleep "$sleep_interval"

   action_n='some-action-name'

   # should initialize the test run report
   do_logTestRunEntry 'INIT'

   do_logTestRunEntry 'START'
   
   # should register the test line start time
   do_logTestRunEntry 'INFO' ' '$(date "+%H:%M:%S")
   
   # should register the test line stop time
   do_logTestRunEntry 'INFO' ' '$(date "+%H:%M:%S")
   
   # should addd the name of the action to test 
   do_logTestRunEntry 'INFO' ' '"$action_n"
   
   # should close the test run line
   do_logTestRunEntry 'STOP' 0
   
   # should close and print the test run report 
   do_logTestRunEntry 'STATUS'

	do_log "DEBUG STOP  doTestLogTestRunEntry"
}
# eof func doTestLogTestRunEntry


# eof file: src/bash/qto/funcs/log-test-run-entry.test.sh
