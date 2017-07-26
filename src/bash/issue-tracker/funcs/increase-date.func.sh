# src/bash/issue-tracker/funcs/increase-date.func.sh
# today is --date="+0 day"
# tommorrow is --date="+1 day"
#
# ---------------------------------------------------------
# v1.1.3
# cat doc/txt/issue-tracker/funcs/increase-date.func.txt
# ---------------------------------------------------------
doIncreaseDate(){

	doLog "DEBUG START doIncreaseDate"
   test -z ${proj_txt_dir+x} && export exit_code=1 \
      && doExit "define a project by doParseIniEnvVars <<path-to-proj-conf-file>> !!!" && exit 1

   # if a relative path is passed add to the product version dir
   [[ $proj_txt_dir == /* ]] || export proj_txt_dir="$product_instance_dir"/"$proj_txt_dir"

   # find the latest project_daily_txt_dir
   latest_proj_daily_txt_dir=$(find "$proj_txt_dir/issues" -type d|sort -nr | head -n 1|grep -v tmp)

   # define the today's daily_txt_dir
   todays_monthly_txt_dir="$proj_txt_dir"'/issues/'"$(date +%Y)"'/'"$(date +%Y-%m)"
   mkdir -p $todays_monthly_txt_dir
   todays_daily_txt_dir="$proj_txt_dir"'/issues/'"$(date +%Y)"'/'"$(date +%Y-%m)"'/'"$(date --date="+1 day" +%Y-%m-%d)"
  
   error_msg="
   nothing can be done - as the daily dir : 
      $todays_daily_txt_dir 
   already exists !!!
   "
   test -d "$todays_daily_txt_dir" && export exit_code=1 && doExit "$error_msg"

   todays_tmp_dir=$tmp_dir/$(date "+%Y-%m-%d")    # becauses of vboxsf !!!
   cmd="cp -vr $latest_proj_daily_txt_dir $todays_tmp_dir/"
   doRunCmdOrExit "$cmd"

   cd $todays_tmp_dir

   # foreach sh or txt file
   while read -r f ; do 
      export last_day=$(echo $f|cut -d'.' -f 4);

      table=$(echo $f|cut -d'.' -f 3); proj=$(echo $f|cut -d'.' -f 2); 
      doLog "DEBUG table: $table"

      file_ext=$(echo $f|cut -d'.' -f 5); 
      doLog "DEBUG file_ext: $file_ext"

      mv -v "$f" '.'"$proj"."$table".`date --date="+1 day" "+%Y-%m-%d"`."$file_ext"
   # obs works only on gnu find !
   done < <(find . -type f -regex ".*\.\(sh\|txt\)")
  

   # foreach xls file
   while read -r f ; do 
      proj=$(echo $f|cut -d'.' -f 2); 
      doLog "DEBUG proj: $proj"

      table=$(echo $f|cut -d'.' -f 3); 
      doLog "DEBUG table: $table"

      timestamp=$(echo $f|cut -d'.' -f4); 
      doLog "DEBUG timestamp: $timestamp"

      file_ext=$(echo $f|cut -d'.' -f 5); 
      doLog "DEBUG file_ext: $file_ext"

      mv -v "$f" '.'"$proj"."$table".`date --date="+1 day" "+%Y%m%d_%H%M%S"`."$file_ext"
   done < <(find . -type f -name "*.xlsx")

   # search and replace the daily
   today=$(date +%Y-%m-%d)
   while read -r f ; do 
      perl -pi -e 's/\@'"$last_day"'/\@'"$today"'/g;' "$f" ; 
   done < <(find . -type f -name '*.txt' -o -name '*.sh')
   
   rm -f *.bak       # remove any possible bak files
   mv $todays_tmp_dir $todays_daily_txt_dir 

   msg=" OK for creating the daily project dir:
         $todays_daily_txt_dir"
   doLog "INFO ""$msg"

	doLog "DEBUG STOP  doIncreaseDate"
}
# eof func doIncreaseDate

# eof file: src/bash/issue-tracker/funcs/increase-date.func.sh
