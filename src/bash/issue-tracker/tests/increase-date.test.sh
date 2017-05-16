# src/bash/issue-tracker/funcs/increase-date.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestIncreaseDate comments ...
# ---------------------------------------------------------
doTestIncreaseDate(){
   
   set -eu
	doLog "DEBUG START doTestIncreaseDate"
	
	cat doc/txt/issue-tracker/tests/increase-date.test.txt
	
	sleep "$sleep_interval"
   bash src/bash/issue-tracker/issue-tracker.sh -a increase-date
 
	# add your action implementation code here ... 
	# Action !!!
	doLog "DEBUG STOP  doTestIncreaseDate"
}
# eof func doTestIncreaseDate


# eof file: src/bash/issue-tracker/funcs/increase-date.test.sh
