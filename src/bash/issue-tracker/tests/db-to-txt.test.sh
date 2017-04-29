# src/bash/issue-tracker/funcs/db-to-txt.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestDbToTxt comments ...
# ---------------------------------------------------------
doTestDbToTxt(){

	doLog "DEBUG START doTestDbToTxt"
	
	cat doc/txt/issue-tracker/tests/db-to-txt.test.txt
	
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

	doLog "DEBUG STOP  doTestDbToTxt"
}
# eof func doTestDbToTxt


# eof file: src/bash/issue-tracker/funcs/db-to-txt.test.sh
