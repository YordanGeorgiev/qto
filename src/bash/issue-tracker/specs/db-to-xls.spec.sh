# src/bash/issue-tracker/funcs/db-to-xls.spec.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doSpecDbToXls comments ...
# ---------------------------------------------------------
doSpecDbToXls(){

	doLog "DEBUG START doSpecDbToXls"
	
	cat doc/txt/issue-tracker/specs/db-to-xls.spec.txt
	
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

	doLog "DEBUG STOP  doSpecDbToXls"
}
# eof func doSpecDbToXls


# eof file: src/bash/issue-tracker/funcs/db-to-xls.spec.sh
