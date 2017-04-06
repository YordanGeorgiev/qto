# src/bash/issue-tracker/funcs/generate-action-files.help.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doHelpGenerateActionFiles comments ...
# ---------------------------------------------------------
doHelpGenerateActionFiles(){

	doLog "DEBUG START doHelpGenerateActionFiles"
	
	cat doc/txt/issue-tracker/helps/generate-action-files.help.txt
	
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

	doLog "DEBUG STOP  doHelpGenerateActionFiles"
}
# eof func doHelpGenerateActionFiles


# eof file: src/bash/issue-tracker/funcs/generate-action-files.help.sh
