# src/bash/issue-tracker/funcs/xls-to-db.help.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doHelpXlsToDb comments ...
# ---------------------------------------------------------
doHelpXlsToDb(){

	doLog "DEBUG START doHelpXlsToDb"
	
	cat doc/txt/issue-tracker/helps/xls-to-db.help.txt
	
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

	doLog "DEBUG STOP  doHelpXlsToDb"
}
# eof func doHelpXlsToDb


# eof file: src/bash/issue-tracker/funcs/xls-to-db.help.sh
