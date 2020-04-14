# src/bash/qto/funcs/remove-action-files.func.sh

# v1.1.2
# ---------------------------------------------------------
# obs we assume that the caller is in the PRODUCT_INSTANCE_DIR
# simply delete each file which greps finds to match to the action
# name(s) cnfigured in the : 
# src/bash/qto/tests/rem-qto-actions.lst
# list file
# ---------------------------------------------------------
doRemoveActionFiles(){

	do_log "DEBUG START doRemoveActionFiles"
	
	# for each defined action 	
	while read -r act ; do (
		do_log "INFO STOP  :: removing action: $act"
		find . | grep $act | cut -c 3- | xargs rm -fv "{}"
      for env in `echo dev tst prd src`; do perl -pi -e 's/^.*?'$act'.*\n$//gm' "met/.$env.";done;
		
	); 
	done< <(cat "src/bash//tests/rem--actions.lst")

	do_log "DEBUG STOP  doRemoveActionFiles"
}
# eof func doRemoveActionFiles


# eof file: src/bash/qto/funcs/remove-action-files.func.sh
