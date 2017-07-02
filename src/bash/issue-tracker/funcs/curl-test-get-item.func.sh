# src/bash/issue-tracker/funcs/curl-test-get-item.func.sh

# v1.0.9
# ---------------------------------------------------------
# 
# ---------------------------------------------------------
doCurlTestGetItem(){

	doLog "DEBUG START doCurlTestGetItem"
	
	# cat doc/txt/issue-tracker/funcs/curl-test-get-item.func.txt
	
	sleep "$sleep_interval"
	# Action !!!
   while read -r guid ; do 
      curl "http://$web_host"':'"$web_port/$db_name/get/company_eps/$guid" ; 
   done < <(psql -d dev_stockit_issues -t -c "SELECT guid FROM company_eps")

	doLog "DEBUG STOP  doCurlTestGetItem"
}
# eof func doCurlTestGetItem


# eof file: src/bash/issue-tracker/funcs/curl-test-get-item.func.sh
