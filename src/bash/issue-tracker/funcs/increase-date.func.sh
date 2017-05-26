# src/bash/issue-tracker/funcs/increase-date.func.sh

# v1.0.9
doIncreaseDate(){

	doLog "DEBUG START doIncreaseDate"
	# cat doc/txt/issue-tracker/funcs/increase-date.func.txt
   test -z ${proj_txt_dir+x} && export exit_code=1 \
      && doExit "define a project by doParseIniEnvVars <<path-to-proj-conf-file>> !!!" && exit 1

   # if a relative path is passed add to the product version dir
   [[ $proj_txt_dir == /* ]] || export proj_txt_dir="$product_instance_dir"/"$proj_txt_dir"

   # find the latest project_daily_txt_dir
   latest_proj_daily_txt_dir=$(find "$proj_txt_dir/issues" -type d|sort -nr | head -n 1|grep -v tmp)

   # define the today's daily_txt_dir
   todays_daily_txt_dir="$proj_txt_dir"'/issues/'"$(date +%Y)"'/'"$(date +%Y-%m)"'/'"$(date +%Y-%m-%d)"
   test -d "$todays_daily_txt_dir" && exit_code=1 && doExit "nothing to do, as $todays_daily_txt_dir exists !!!"

   todays_tmp_dir=$tmp_dir/$(date "+%Y-%m-%d")    # becauses of vboxsf !!!
   cmd="cp -vr $latest_proj_daily_txt_dir $todays_tmp_dir/"
   doRunCmdOrExit "$cmd"

   cd $todays_tmp_dir
   while read -r f ; do 
      export yesterday=$(echo $f|cut -d'.' -f 3);
      period=$(echo $f|cut -d'.' -f 4); proj=$(echo $f|cut -d'.' -f 2); 
      extsion=$(echo $f|cut -d'.' -f 5); 
      doLog "DEBUG extsion: $extsion"
      mv -v "$f" '.'"$proj".`date "+%Y-%m-%d"`."$period"."$extsion"
   done < <(find . -type f -name '*.txt' -o -name '*.sh')
   
   # search and replace the daily
   today=$(date +%Y-%m-%d)
   while read -r f ; do 
      perl -pi -e 's/\@'"$yesterday"'/\@'"$today"'/g;' "$f" ; 
   done < <(find . -type f -name '*.txt' -o -name '*.sh')
   
   rm -f *.bak       # remove any possible bak files

   mv $todays_tmp_dir $todays_daily_txt_dir 

   doLog "INFO OK for increase-date on $todays_daily_txt_dir"
	doLog "DEBUG STOP  doIncreaseDate"
}
# eof func doIncreaseDate

# eof file: src/bash/issue-tracker/funcs/increase-date.func.sh
