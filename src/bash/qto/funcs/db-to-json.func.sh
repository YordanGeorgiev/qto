# src/bash/qto/funcs/db-to-json.func.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doDbToJson comments ...
# ---------------------------------------------------------
doDbToJson(){

	doLog "DEBUG START doDbToJson"
	
	#cat doc/txt/qto/funcs/db-to-json.func.txt

   set -x
	sleep "$sleep_interval"
   clear ; export tables=`curl -s -k http://$web_host:3000/$postgres_db_name/select-tables| \
   jq -r '.| .dat| .[] | .table_name'|perl -ne 's/\s+/,/g;print'`;
   export do_truncate_tables=1 ; export rdbms_type=postgres ; 
   perl src/perl/qto/script/qto.pl --do db-to-json --tables $tables

	doLog "DEBUG STOP  doDbToJson"
}
# eof func doDbToJson


# eof file: src/bash/qto/funcs/db-to-json.func.sh
