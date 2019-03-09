# src/bash/qto/funcs/db-to-xls.help.sh

# v1.0.9
# ---------------------------------------------------------
# wrapper func to present the db-to-xls help file
# ---------------------------------------------------------
doHelpDbToXls(){

	doLog "DEBUG START doHelpDbToXls"
	
	cat doc/txt/qto/helps/db-to-xls.help.txt
	
	sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

	doLog "DEBUG STOP  doHelpDbToXls"
}
# eof func doHelpDbToXls


# eof file: src/bash/qto/funcs/db-to-xls.help.sh
