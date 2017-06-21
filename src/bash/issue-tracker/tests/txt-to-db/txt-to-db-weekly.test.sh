# src/bash/issue-tracker/funcs/txt-to-db.test.sh

# v1.1.0
# ---------------------------------------------------------
# tests the issues txt file to db load action
# ---------------------------------------------------------
doTestTxtToDbWeekly(){

	doLog "DEBUG START doTestTxtToDbWeekly"
   export period='weekly'
   bash src/bash/issue-tracker/issue-tracker.sh -a txt-to-db
   exit_code=$?

   # and check the values from the db
   psql -d "$db_name" -c '
   SELECT id , category , name 
   FROM '"$period"'_issue order by name
   ;';

   sleep "$sleep_interval"
   test $exit_code -ne 0 && return
	doLog "DEBUG STOP  doTestTxtToDbWeekly"
}
# eof func doTestTxtToDb


# eof file: src/bash/issue-tracker/funcs/txt-to-db.test.sh
