# src/bash/issue-tracker/funcs/create-ctags.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestCreateCtags comments ...
# ---------------------------------------------------------
doTestCreateCtags(){

	doLog "DEBUG START doTestCreateCtags"
	
	cat doc/txt/issue-tracker/tests/create-ctags.test.txt
	
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

	doLog "DEBUG STOP  doTestCreateCtags"
}
# eof func doTestCreateCtags


# eof file: src/bash/issue-tracker/funcs/create-ctags.test.sh
