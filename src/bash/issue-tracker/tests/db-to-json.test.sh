# src/bash/issue-tracker/funcs/db-to-json.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestDbToJson comments ...
# ---------------------------------------------------------
doTestDbToJson(){

	doLog "DEBUG START doTestDbToJson"
	
	# cat doc/txt/issue-tracker/tests/db-to-json.test.txt

   bash src/bash/issue-tracker/issue-tracker.sh -a db-to-json
	sleep "$sleep_interval"
	
   # Action !!!
   while read -r t ; do test -f "$product_instance_dir/dat/json/$t.json" || export exit_code=1 ; done \
   < <(curl -s -k http://$web_host:3000/$postgres_db_name/select-tables| jq -r '.| .dat| .[] | .table_name')

   
	doLog "DEBUG STOP  doTestDbToJson"
}
# eof func doTestDbToJson


# eof file: src/bash/issue-tracker/funcs/db-to-json.test.sh
