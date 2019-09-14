# src/bash/qto/funcs/generate-sql.func.sh

# v1.2.0
# ---------------------------------------------------------
# read the lst file for each var in headers to copy template
# into a new %script%.sql search and replaces vars with 
# values from the lst file both in file names and in content
# ---------------------------------------------------------
doGenerateSQL(){

	doLog "DEBUG START doGenerateSQL"
	
   while read -r list_file ; do   #foreach list file in the dat/lst/sql dir

      cd $PRODUCT_INSTANCE_DIR/src/sql/mysql/run
         
      # foreach sql template
      while read -r sql_template ; do

         headers=$(head -n 1 "$list_file")
         TMP_IFS=$IFS
         
         while read -r line ; do

            sql_file=$sql_template

            IFS=$' \t\n' read -r -a column_names <<< "$headers"
            #debug ok printf '%s\n' "${column_names[@]}"

            IFS=$' \t\n' read -r -a tokens <<< "$line"
            #debug ok printf '%s\n' "${tokens[@]}"

            for index in "${!column_names[@]}"
            do
                to_srch="${column_names[$index]}"
                to_repl="${tokens[$index]}"
                sql_file=$(echo "$sql_file"|perl -ne 's/(.*)\.SQL/$1.sql/g;print')
                sql_file=$(echo "$sql_file"|perl -ne 's{%'"$to_srch"'%}{'"$to_repl"'}g;print')
            done
            cp -v "$sql_template" "$sql_file"
            
            for index in "${!column_names[@]}"
            do
                to_srch="${column_names[$index]}"
                to_repl="${tokens[$index]}"
                perl -pi -e "use utf8 ; binmode STDOUT, \":utf8\"; 
                use open':encoding(utf8)';s{%""$to_srch""%}{""$to_repl""}g;" "$sql_file"
            done
          
         done < <(tail -n +2 "$list_file") # cat all but the first line 
      done < <(find $PRODUCT_INSTANCE_DIR/src/sql/mysql/run -type f -name '*.SQL')
   done < <(find $PRODUCT_INSTANCE_DIR/dat/lst/sql/mysql/run -type f -name '*.list')
   
   IFS=$TMP_IFS   # revert back to the original IFS
   find . -name '*.bak' | xargs rm -fv
   chmod -v 770 *.sql 
   cd $PRODUCT_INSTANCE_DIR
	
	sleep "$sleep_interval"
	# add your action implementation code here ... 

	doLog "DEBUG STOP  doGenerateSQL"
}
# eof func doGenerateSQL

# eof file: src/bash/qto/funcs/generate-sql.func.sh
