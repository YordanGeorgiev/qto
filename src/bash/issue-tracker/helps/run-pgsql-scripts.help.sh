# src/bash/issue-tracker/funcs/run-pgsql-scripts.help.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doHelpRunPgsqlScripts comments ...
# ---------------------------------------------------------
doHelpRunPgsqlScripts(){

	doLog "DEBUG START doHelpRunPgsqlScripts"
	
	cat doc/txt/issue-tracker/helps/run-pgsql-scripts.help.txt
	
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

	doLog "DEBUG STOP  doHelpRunPgsqlScripts"
}
# eof func doHelpRunPgsqlScripts


# eof file: src/bash/issue-tracker/funcs/run-pgsql-scripts.help.sh
