# src/bash/issue-tracker/funcs/increase-date.func.sh
# today is --date="+1 day"
# tommorrow is --date="+1 day"
#
# ---------------------------------------------------------
# v1.1.4
# cat doc/txt/issue-tracker/funcs/increase-date.func.txt
# ---------------------------------------------------------
doIncreaseDate(){
	doLog "DEBUG START doIncreaseDate"
   test -z ${mix_data_dir+x} && export exit_code=1 \
      && doExit "define a project by doParseIniEnvVars <<path-to-proj-conf-file>> !!!" && exit 1

   # if a relative path is passed add to the product version dir
   [[ $mix_data_dir == /* ]] || \
      export mix_data_dir="$product_instance_dir"/"$mix_data_dir"

   # find the latest project_daily_txt_dir
   latest_proj_daily_dir=""
   latest_proj_daily_dir=$(find $mix_data_dir -type d|sort|grep -v txt|grep -v json|grep -v xls|sort -nr|head -1)
   echo "latest_proj_daily_dir: $latest_proj_daily_dir" 

	# debug set -x
   if [[ ${tgt_date+x} && -n $tgt_date ]] ; then
		
		case "$tgt_date" in
			  today)
         		export tgt_date=$(date --date="+0 day" "+%Y-%m-%d")
					;;
			  tomorrow)
         		export tgt_date=$(date --date="+1 day" "+%Y-%m-%d")
					;;
			  yesterday)
         		export tgt_date=$(date --date="-1 day" "+%Y-%m-%d")
					;;
			  *)
					# check that the date is the %Y-%m-%d format
				 	doRunCmdOrExit 'date +%Y-%m-%d -d '"$tgt_date"
		esac

   else
      export tgt_date=$(date --date="+0 day" "+%Y-%m-%d")
   fi
   
	msg="using the following date: \"$tgt_date\""
  	doLog "INFO $msg"
  
   # set -x
   # define the today's daily_txt_dir
   tgt_days_monthly_data_dir="$mix_data_dir"/$(date "+%Y" -d "$tgt_date")
   tgt_days_monthly_data_dir="$tgt_days_monthly_data_dir"/$(date "+%Y-%m" -d "$tgt_date")
   mkdir -p $tgt_days_monthly_data_dir
   export daily_data_dir="$tgt_days_monthly_data_dir"'/'$(date "+%Y-%m-%d" -d "$tgt_date")


   error_msg="
   nothing can be done - as the daily data dir \$daily_data_dir : 
      $daily_data_dir 
   already exists !!!
      "
   test -d "$daily_data_dir" && export exit_code=1 && doExit "$error_msg"

   todays_tmp_dir=$tmp_dir/$(date "+%Y-%m-%d" -d "$tgt_date")    # becauses of vboxsf !!!
   cmd="cp -vr $latest_proj_daily_dir $todays_tmp_dir/"

   doRunCmdOrExit "$cmd"
   cd $todays_tmp_dir

   # foreach sh or txt file
   while read -r f ; do 
      export last_day=$(echo $f|cut -d'.' -f 4);

      table=$(echo $f|cut -d'.' -f 3); proj=$(echo $f|cut -d'.' -f 2); 
      #debug doLog "DEBUG table: $table"

      file_ext=$(echo $f|cut -d'.' -f 5); 
      # debug doLog "DEBUG file_ext: $file_ext"

      mv "$f" '.'"$proj"."$table".`date "+%Y-%m-%d" -d "$tgt_date"`."$file_ext"
   # obs works only on gnu find !
   done < <(find . -type f -regex ".*\.\(sh\|txt\)")
  

   # search and replace the daily
   today=$(date +%Y-%m-%d)
   while read -r f ; do 
      perl -pi -e 's/\@'"$last_day"'/\@'"$today"'/g;' "$f" ; 
   done < <(find . -type f -name '*.txt' -o -name '*.sh')
   
   rm -f *.bak       # remove any possible bak files
   mv $todays_tmp_dir $daily_data_dir 
  
   # foreach xls file
   while read -r f ; do 
      file_name="${f##*/}"
      proj=$(echo $file_name|cut -d'.' -f 1); 
      table=$(echo $file_name|cut -d'.' -f 2); 
      timestamp=$(echo $file_name|cut -d'.' -f 3); 
      # file_name="${f%.*}"
      # file_name=$(basename -- "$f")
      file_ext="${f##*.}"
      mkdir -p "$daily_data_dir/xls"
      doLog "DEBUG" "mv $f" -> "$daily_data_dir/$proj"."$table".$(date "+%Y%m%d_%H%M%S" -d "$tgt_date")."$file_ext"
      mv "$f" "$daily_data_dir/xls/$proj"."$table".$(date "+%Y%m%d_%H%M%S" -d "$tgt_date")."$file_ext"
      # and I just don't know where this one comes from, but it is fake !!!
      rm -v "$daily_data_dir/$proj"."$table".$(date "+%Y%m%d_%H%M%S" -d "$tgt_date")."$file_ext"
   done < <(find $daily_data_dir -type f -name "*.xlsx"| grep -v '/[.~]')

   doBackupPostgresDb

   msg=" OK for creating the daily project dir:
         $daily_data_dir"
   doLog "INFO ""$msg"

	doLog "DEBUG STOP  doIncreaseDate"
}
# eof func doIncreaseDate

# eof file: src/bash/issue-tracker/funcs/increase-date.func.sh
