# src/bash/qto/funcs/remove-package-files.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestRemovePackageFiles comments ...
# ---------------------------------------------------------
doTestRemovePackageFiles(){

	do_log "DEBUG START doTestRemovePackageFiles"
	
	cat doc/txt/qto/tests/remove-package-files.test.txt
	
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

	do_log "DEBUG STOP  doTestRemovePackageFiles"
}
# eof func doTestRemovePackageFiles


# eof file: src/bash/qto/funcs/remove-package-files.test.sh
