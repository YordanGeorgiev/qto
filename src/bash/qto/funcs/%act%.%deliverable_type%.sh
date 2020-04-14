# src/bash/qto/funcs/%act%.%deliverable_type%.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add %full_func% comments ...
# ---------------------------------------------------------
%full_func%(){

	do_log "DEBUG START %full_func%"
	
	cat doc/txt/qto/%deliverable_type%s/%act%.%deliverable_type%.txt
	
	sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

	do_log "DEBUG STOP  %full_func%"
}
# eof func %full_func%


# eof file: src/bash/qto/funcs/%act%.%deliverable_type%.sh
