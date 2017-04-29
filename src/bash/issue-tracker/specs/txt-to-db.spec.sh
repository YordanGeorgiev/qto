# src/bash/issue-tracker/funcs/txt-to-db.spec.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doSpecTxtToDb comments ...
# ---------------------------------------------------------
doSpecTxtToDb(){

	doLog "DEBUG START doSpecTxtToDb"
	
	cat doc/txt/issue-tracker/specs/txt-to-db.spec.txt
	
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

	doLog "DEBUG STOP  doSpecTxtToDb"
}
# eof func doSpecTxtToDb


# eof file: src/bash/issue-tracker/funcs/txt-to-db.spec.sh
