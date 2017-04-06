# src/bash/issue-tracker/funcs/generate-sql.spec.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doSpecGenerateSQL comments ...
# ---------------------------------------------------------
doSpecGenerateSQL(){

	doLog "DEBUG START doSpecGenerateSQL"
	
	cat doc/txt/issue-tracker/specs/generate-sql.spec.txt
	
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

	doLog "DEBUG STOP  doSpecGenerateSQL"
}
# eof func doSpecGenerateSQL


# eof file: src/bash/issue-tracker/funcs/generate-sql.spec.sh
