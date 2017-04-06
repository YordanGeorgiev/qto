# src/bash/issue-tracker/funcs/generate-sql.help.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doHelpGenerateSQL comments ...
# ---------------------------------------------------------
doHelpGenerateSQL(){

	doLog "DEBUG START doHelpGenerateSQL"
	
	cat doc/txt/issue-tracker/helps/generate-sql.help.txt
	
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

	doLog "DEBUG STOP  doHelpGenerateSQL"
}
# eof func doHelpGenerateSQL


# eof file: src/bash/issue-tracker/funcs/generate-sql.help.sh
