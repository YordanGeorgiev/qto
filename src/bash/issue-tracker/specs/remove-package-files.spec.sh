# src/bash/issue-tracker/funcs/remove-package-files.spec.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doSpecRemovePackageFiles comments ...
# ---------------------------------------------------------
doSpecRemovePackageFiles(){

	doLog "DEBUG START doSpecRemovePackageFiles"
	
	cat doc/txt/issue-tracker/specs/remove-package-files.spec.txt
	
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

	doLog "DEBUG STOP  doSpecRemovePackageFiles"
}
# eof func doSpecRemovePackageFiles


# eof file: src/bash/issue-tracker/funcs/remove-package-files.spec.sh
