# src/bash/issue-tracker/funcs/remove-package-files.help.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doHelpRemovePackageFiles comments ...
# ---------------------------------------------------------
doHelpRemovePackageFiles(){

	doLog "DEBUG START doHelpRemovePackageFiles"
	
	cat doc/txt/issue-tracker/helps/remove-package-files.help.txt
	
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

	doLog "DEBUG STOP  doHelpRemovePackageFiles"
}
# eof func doHelpRemovePackageFiles


# eof file: src/bash/issue-tracker/funcs/remove-package-files.help.sh
