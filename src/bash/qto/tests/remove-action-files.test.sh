# src/bash/qto/funcs/remove-action-files.test.sh

# v1.1.2
# ---------------------------------------------------------
# adds first an action to remove 
# generates all the aciton files (( it will add this new ) 
# action to remove
# and tests the actual removal at the end 
# ---------------------------------------------------------
doTestRemoveActionFiles(){

	source $product_instance_dir/lib/bash/funcs/flush-screen.sh
	do_log "DEBUG START doTestRemoveActionFiles"

	doSpecRemoveActionFiles
	sleep "$sleep_interval"
	do_flush_screen

	doHelpRemoveActionFiles
	sleep "$sleep_interval"
	do_flush_screen
	
	cat doc/txt/qto/tests/remove-action-files.test.txt
	sleep "$sleep_interval"
	do_flush_screen
	
	# add an action to remove
	found=$(grep -c action-to-remove src/bash/qto/tests/rem-qto-actions.lst)
	test $found -eq 0 && \
	echo action-to-remove >> src/bash/qto/tests/rem-qto-actions.lst
	found=0
	
	found=$(grep -c action-to-remove src/bash/qto/tests/all-qto-tests.lst)
	test $found -eq 0 && \
		echo action-to-remove >> src/bash/qto/tests/all-qto-tests.lst

	# now generate the code files for this action to remove
	bash src/bash/qto/qto.sh -a generate-action-files		
	sleep "$sleep_interval"
	do_flush_screen

	# and test the actual removal of the action 	
	bash src/bash/qto/qto.sh -a remove-action-files		
	do_log "DEBUG STOP  doTestRemoveActionFiles"

	sleep "$sleep_interval"

	do_flush_screen
}
# eof func doTestRemoveActionFiles


# eof file: src/bash/qto/funcs/remove-action-files.test.sh
