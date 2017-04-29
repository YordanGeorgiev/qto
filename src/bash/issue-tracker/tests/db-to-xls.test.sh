# src/bash/issue-tracker/funcs/db-to-xls.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestDbToXls comments ...
# ---------------------------------------------------------
doTestDbToXls(){

	doLog "DEBUG START doTestDbToXls"
	
	cat doc/txt/issue-tracker/tests/db-to-xls.test.txt
	
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

	doLog "DEBUG STOP  doTestDbToXls"
}
# eof func doTestDbToXls


# eof file: src/bash/issue-tracker/funcs/db-to-xls.test.sh
