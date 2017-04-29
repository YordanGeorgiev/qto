# src/bash/issue-tracker/funcs/db-to-txt.help.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doHelpDbToTxt comments ...
# ---------------------------------------------------------
doHelpDbToTxt(){

	doLog "DEBUG START doHelpDbToTxt"
	
	cat doc/txt/issue-tracker/helps/db-to-txt.help.txt
	
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

	doLog "DEBUG STOP  doHelpDbToTxt"
}
# eof func doHelpDbToTxt


# eof file: src/bash/issue-tracker/funcs/db-to-txt.help.sh
