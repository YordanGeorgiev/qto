# src/bash/issue-tracker/funcs/txt-to-db.test.sh

# v1.1.0
# ---------------------------------------------------------
# tests the issues txt file to db load action
# ---------------------------------------------------------
doTestTxtToDbDaily(){

	doLog "DEBUG START doTestTxtToDbDaily"
   export period='daily'
   bash src/bash/issue-tracker/issue-tracker.sh -a txt-to-db
   exit_code=$?

   # and check the values from the db
   psql -d "$postgres_db_name" -c '
   SELECT id , category , name 
   FROM '"$period"'_issues order by name
   ;';

   sleep "$sleep_interval"
   test $exit_code -ne 0 && return
	doLog "DEBUG STOP  doTestTxtToDbDaily"
}
# eof func doTestTxtToDb


# eof file: src/bash/issue-tracker/funcs/txt-to-db.test.sh
