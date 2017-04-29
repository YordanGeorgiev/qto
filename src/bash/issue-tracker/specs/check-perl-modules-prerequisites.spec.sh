# src/bash/issue-tracker/funcs/check-perl-modules-prerequisites.spec.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doSpecCheckPerlModulesPrerequisites comments ...
# ---------------------------------------------------------
doSpecCheckPerlModulesPrerequisites(){

	doLog "DEBUG START doSpecCheckPerlModulesPrerequisites"
	
	cat doc/txt/issue-tracker/specs/check-perl-modules-prerequisites.spec.txt
	
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

	doLog "DEBUG STOP  doSpecCheckPerlModulesPrerequisites"
}
# eof func doSpecCheckPerlModulesPrerequisites


# eof file: src/bash/issue-tracker/funcs/check-perl-modules-prerequisites.spec.sh
