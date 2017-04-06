# src/bash/issue-tracker/funcs/log-test-run-entry.func.sh

# 
# ---------------------------------------------------------
# provides a mean for registering test run log entries 
# Usage:
# doLogTestRunEntry START "$msg"
# doLogTestRunEntry INFO "$msg"
# doLogTestRunEntry STOP $exit_code "$msg"
# doLogTestRunEntry STATUS
# ---------------------------------------------------------
doLogTestRunEntry(){

	doLog "DEBUG START doLogTestRunEntry"

   case "$1" in
     INIT)
         # cat doc/txt/issue-tracker/funcs/log-test-run-entry.func.txt
         component_name=$wrap_name
         test -z "$component_name" && component_name="$wrap_name_tester"
         test -z "$test_run_report_line" && test_run_report_line='   '
         test -z "$test_run_report_file" \
         && test_run_report_file="$product_instance_dir/dat/tests/$component_name"'.test-run-report.'`date "+%Y%m%d_%H%M%S"`'.txt'
         echo -e "\n" > "$test_run_report_file"
         echo -e `date "+%Y-%m-%d %H:%M:%S"`"\t START $component_name test run report \n" >> "$test_run_report_file"
         echo "result  start-time  stop-time   action-name" >> "$test_run_report_file"
         shift;
         ;;
     START)
         test_run_report_line='   nok   '
         shift;
         ;;
     INFO)
         shift;
         test_run_report_line="$test_run_report_line""$*"
         ;;
     STOP)
         shift;
         exit_code=$1
         if test "$exit_code" -eq 0; then
            test_run_report_line=$(echo "$test_run_report_line"|perl -ne 's/   nok   /   ok   /g;print')
         fi
         echo -e "$test_run_report_line" >> "$test_run_report_file"
         ;;
     STATUS)
         echo -e "\n\n"
         echo -e "\n\n" >> "$test_run_report_file"
         echo -e `date "+%Y-%m-%d %H:%M:%S"`"\t STOP  $component_name test run report" >> "$test_run_report_file"
         cat "$test_run_report_file"
         echo -e "\n\n"
         doLog "product instance tests listing"
         find "$product_instance_dir"'/dat/tests' -type f -exec stat -c "%y %n" {} \; | sort -nr
         echo -e "\n\n"
         ;;
     *)
         echo $"Usage: $0 {START|STOP|INFO|STATUS}" 1>&2 
   esac	
        
	doLog "DEBUG STOP  doLogTestRunEntry"
}
# eof func doLogTestRunEntry


# eof file: src/bash/issue-tracker/funcs/log-test-run-entry.func.sh
