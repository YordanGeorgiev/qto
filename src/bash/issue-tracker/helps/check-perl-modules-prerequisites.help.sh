# src/bash/issue-tracker/funcs/check-perl-modules-prerequisites.help.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doHelpCheckPerlModulesPrerequisites comments ...
# ---------------------------------------------------------
doHelpCheckPerlModulesPrerequisites(){

	doLog "DEBUG START doHelpCheckPerlModulesPrerequisites"
	
	cat doc/txt/issue-tracker/helps/check-perl-modules-prerequisites.help.txt
	
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

	doLog "DEBUG STOP  doHelpCheckPerlModulesPrerequisites"
}
# eof func doHelpCheckPerlModulesPrerequisites


# eof file: src/bash/issue-tracker/funcs/check-perl-modules-prerequisites.help.sh
