# src/bash/issue-tracker/funcs/xls-to-db.func.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doXlsToDb comments ...
# ---------------------------------------------------------
doXlsToDb(){

	doLog "DEBUG START doXlsToDb"
	
	cat doc/txt/issue-tracker/funcs/xls-to-db.func.txt
	
	test -z "$sleep_interval" || sleep "$sleep_interval"

   # find out the latest xls file from the project daily dir
   # pass it to the xls-to-rdbms tool as the input xls file



	# add your action implementation code here ... 
	# Action !!!
   bash /opt/csitea/src/bash/xls-to-rdbms.sh
	doLog "DEBUG STOP  doXlsToDb"
}
# eof func doXlsToDb


# eof file: src/bash/issue-tracker/funcs/xls-to-db.func.sh
