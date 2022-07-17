# file: src/bash/qto/funcs/increase-date.func.sh
# today is --date="+1 day"
# tommorrow is --date="+1 day"
#
# ---------------------------------------------------------
# cat doc/txt/qto/funcs/increase-date.func.txt
# ---------------------------------------------------------
do_increase_date(){

   test -z "${PROJ_INSTANCE_DIR:-}" && PROJ_INSTANCE_DIR="$PRODUCT_DIR"
   #
   do_export_json_section_vars $PROJ_INSTANCE_DIR/cnf/env/$ENV.env.json '.env.db'
   mix_data_dir=$PROJ_INSTANCE_DIR/dat/mix

   # find the latest project_daily_txt_dir
   latest_proj_daily_dir=""
   latest_proj_daily_dir=$(find $mix_data_dir -type d -maxdepth 3|grep -v txt|grep -v json|grep -v xls|sort -nr|head -1)
   echo "using the following latest_proj_daily_dir: $latest_proj_daily_dir"
   sleep 1

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
  	do_log "INFO $msg"

   # define the today's daily_data_dir
   tgt_days_monthly_data_dir="$mix_data_dir"/$(date "+%Y" -d "$tgt_date")
   tgt_days_monthly_data_dir="$tgt_days_monthly_data_dir"/$(date "+%Y-%m" -d "$tgt_date")
   mkdir -p $tgt_days_monthly_data_dir
   export daily_data_dir="$tgt_days_monthly_data_dir"'/'$(date "+%Y-%m-%d" -d "$tgt_date")

   error_msg="
   nothing can be done - as the daily data dir \$daily_data_dir :
      $daily_data_dir
   already exists !!!
      "
   test -d "$daily_data_dir" && do_exit 1 "$error_msg"

   todays_tmp_dir=$tmp_dir/$(date "+%Y-%m-%d" -d "$tgt_date")    # becauses of vboxsf !!!
   cmd="cp -vr $latest_proj_daily_dir $todays_tmp_dir/"

   doRunCmdOrExit "$cmd" ; cd $todays_tmp_dir

   # foreach sh or txt file
   while read -r f ; do
      export last_day=$(echo $f|cut -d'.' -f 4);

      table=$(echo $f|cut -d'.' -f 3); proj=$(echo $f|cut -d'.' -f 2);
      #debug do_log "DEBUG table: $table"

      file_ext=$(echo $f|cut -d'.' -f 5);
      # debug do_log "DEBUG file_ext: $file_ext"

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
   rm -rfvd $daily_data_dir/tmp

   export daily_data_dir=$mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")

   # remove all the tmp xls files
   rm -v "$daily_data_dir/xls/"'/~'*.xlsx

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
      do_log "DEBUG" "mv $f" -> "$daily_data_dir/$proj"."$table".$(date "+%Y%m%d_%H%M%S" -d "$tgt_date")."$file_ext"
      # and I just don't know where this one comes from, but it is fake !!!
      rm -v "$daily_data_dir/$proj"."$table".$(date "+%Y%m%d_%H%M%S" -d "$tgt_date")."$file_ext"
      mv "$f" "$daily_data_dir/xls/$proj"."$table".$(date "+%Y%m%d_%H%M%S" -d "$tgt_date")."$file_ext"
   done < <(find $daily_data_dir/xls -type f \( -name "*.xlsx" -o -name "*.xls" \))

   doBackupPostgresDb

   msg=" OK for creating the daily project dir:
         $daily_data_dir"
   do_log "INFO ""$msg"

	do_log "DEBUG STOP  doIncreaseDate"
}

# eof file: src/bash/qto/funcs/increase-date.func.sh
