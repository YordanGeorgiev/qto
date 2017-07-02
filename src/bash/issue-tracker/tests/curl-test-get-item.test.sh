# src/bash/issue-tracker/funcs/curl-test-get-item.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestCurlTestGetItem comments ...
# ---------------------------------------------------------
doTestCurlTestGetItem(){

	doLog "DEBUG START doTestCurlTestGetItem"
	
	cat doc/txt/issue-tracker/tests/curl-test-get-item.test.txt
	
	sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!
   bash src/bash/issue-tracker/issue-tracker.sh -a curl-test-get-item

	doLog "DEBUG STOP  doTestCurlTestGetItem"
}
# eof func doTestCurlTestGetItem


# eof file: src/bash/issue-tracker/funcs/curl-test-get-item.test.sh
