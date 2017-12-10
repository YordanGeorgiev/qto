# src/bash/issue-tracker/funcs/generate-docs.help.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doHelpGenerateDocs comments ...
# ---------------------------------------------------------
doHelpGenerateDocs(){

	doLog "DEBUG START doHelpGenerateDocs"
	
	cat doc/txt/issue-tracker/helps/generate-docs.help.txt
	
	sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

	doLog "DEBUG STOP  doHelpGenerateDocs"
}
# eof func doHelpGenerateDocs


# eof file: src/bash/issue-tracker/funcs/generate-docs.help.sh
