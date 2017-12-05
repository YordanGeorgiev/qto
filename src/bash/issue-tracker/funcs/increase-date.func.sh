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
   test -z ${proj_daily_data_root_dir+x} && export exit_code=1 \
      && doExit "define a project by doParseIniEnvVars <<path-to-proj-conf-file>> !!!" && exit 1

   # if a relative path is passed add to the product version dir
   [[ $proj_daily_data_root_dir == /* ]] || \
      export proj_daily_data_root_dir="$product_instance_dir"/"$proj_daily_data_root_dir"

   # find the latest project_daily_txt_dir
   latest_proj_daily_txt_dir=$(find "$proj_daily_data_root_dir" -type d|sort -nr | head -n 1|grep -v tmp)
   
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
      msg="skip the creation of the network backup as no network_backup_dir is configured"
      doLog "INFO  $msg"
   fi
   
	msg="using the following date: \"$tgt_date\""
  	doLog "INFO $msg"
  
   # set -x
   # define the today's daily_txt_dir
   tgt_days_monthly_data_dir="$proj_daily_data_root_dir"/$(date "+%Y" -d "$tgt_date")
   tgt_days_monthly_data_dir="$tgt_days_monthly_data_dir"/$(date "+%Y-%m" -d "$tgt_date")
   mkdir -p $tgt_days_monthly_data_dir
   tgt_dates_daily_data_dir="$tgt_days_monthly_data_dir"'/'$(date "+%Y-%m-%d" -d "$tgt_date")
 
   error_msg="
   nothing can be done - as the daily dir : 
      $tgt_dates_daily_data_dir 
   already exists !!!
   "
   test -d "$tgt_dates_daily_data_dir" && export exit_code=1 && doExit "$error_msg"

   todays_tmp_dir=$tmp_dir/$(date "+%Y-%m-%d" -d "$tgt_date")    # becauses of vboxsf !!!
   cmd="cp -vr $latest_proj_daily_txt_dir $todays_tmp_dir/"
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
  

   # foreach xls file
   while read -r f ; do 
      proj=$(echo $f|cut -d'.' -f 2); 
      #debug doLog "DEBUG proj: $proj"

      table=$(echo $f|cut -d'.' -f 3); 
      #debug doLog "DEBUG table: $table"

      timestamp=$(echo $f|cut -d'.' -f4); 
      #debug doLog "DEBUG timestamp: $timestamp"

      file_ext=$(echo $f|cut -d'.' -f 5); 
      # debug doLog "DEBUG file_ext: $file_ext"

      mv "$f" '.'"$proj"."$table".$(date "+%Y%m%d_%H%M%S" -d "$tgt_date")."$file_ext"
   done < <(find . -type f -name "*.xlsx")

   # search and replace the daily
   today=$(date +%Y-%m-%d)
   while read -r f ; do 
      perl -pi -e 's/\@'"$last_day"'/\@'"$today"'/g;' "$f" ; 
   done < <(find . -type f -name '*.txt' -o -name '*.sh')
   
   rm -f *.bak       # remove any possible bak files
   mv $todays_tmp_dir $tgt_dates_daily_data_dir 

   msg=" OK for creating the daily project dir:
         $tgt_dates_daily_data_dir"
   doLog "INFO ""$msg"

	doLog "DEBUG STOP  doIncreaseDate"
}
# eof func doIncreaseDate

# eof file: src/bash/issue-tracker/funcs/increase-date.func.sh
