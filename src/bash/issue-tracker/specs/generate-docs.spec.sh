# src/bash/issue-tracker/funcs/generate-docs.spec.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doSpecGenerateDocs comments ...
# ---------------------------------------------------------
doSpecGenerateDocs(){

	doLog "DEBUG START doSpecGenerateDocs"
	
	cat doc/txt/issue-tracker/specs/generate-docs.spec.txt
	
	sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

	doLog "DEBUG STOP  doSpecGenerateDocs"
}
# eof func doSpecGenerateDocs


# eof file: src/bash/issue-tracker/funcs/generate-docs.spec.sh
