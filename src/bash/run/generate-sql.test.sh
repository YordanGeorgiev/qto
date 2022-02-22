# src/bash/qto/funcs/generate-sql.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestGenerateSQL comments ...
# ---------------------------------------------------------
doTestGenerateSQL(){

	do_log "DEBUG START doTestGenerateSQL"
	
	cat doc/txt/qto/tests/generate-sql.test.txt
	
	sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!
   bash src/bash/qto/qto.sh -a generate-sql

	do_log "DEBUG STOP  doTestGenerateSQL"
}
# eof func doTestGenerateSQL


# eof file: src/bash/qto/funcs/generate-sql.test.sh
