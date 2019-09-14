# src/bash/qto/funcs/xls-to-db.func.sh

# v0.1.8
# ---------------------------------------------------------
# load xls to db
# cat doc/txt/qto/funcs/xls-to-db.func.txt
# ---------------------------------------------------------
doXlsToDb(){

	doLog "DEBUG START doXlsToDb"
	
	sleep "$sleep_interval"
   test -z ${items_order_by_attribute+x} && export items_order_by_attribute='category'
   test -z ${period+x} && export period='daily'
   test -z ${tables+x} && export tables='daily_issues'
   
   # find out the latest xls file from the project daily dir
   # pass it to the xls-to-rdbms tool as the input xls file
   # or leave the app to guess it ... 
   test -z ${xls_file+x} && \
      export xls_file=$(find ${mix_data_dir} -name '*.xlsx'| grep '.all.'| sort -rn|head -n 1)
   test -z ${xls_file} && \
      export xls_file=$(find $mix_data_dir -name '*.xlsx'| grep $period| sort -rn|head -n 1)

   cmd="perl src/perl/qto/script/qto.pl --do xls-to-db --tables $tables"
   test -z ${xls_file} || cmd="$cmd --xls-file $xls_file"

   doLog "INFO using: mix_data_dir: ${mix_data_dir+}"
   doLog "INFO using xls_file: $xls_file"
   # Action !!!
   $cmd

   exit_code=$?
   
#   psql -d "$postgres_db_name" -c '
#   SELECT id category , substring ( description from 0 for 40 ) as descrption , start_time , stop_time
#   FROM '"$tables"'_issues order by '"$items_order_by_attribute"'
#   ;';

   doLog "INFO doRunQto exit_code $exit_code"
   test $exit_code -ne 0 && doExit $exit_code "failed to run qto.pl"  
  
	doLog "DEBUG STOP  doXlsToDb"
}
# eof func doXlsToDb


# eof file: src/bash/qto/funcs/xls-to-db.func.sh
