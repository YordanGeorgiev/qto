# src/bash/issue-tracker/funcs/gmail-txt-issues.func.sh

# v1.0.0
# ---------------------------------------------------------
# todo: add doGmailTxtIssues comments ...
# ---------------------------------------------------------
doGmailTxtIssues(){

	doLog "DEBUG START doGmailTxtIssues"
	
   mutt --help >/dev/null 2>&1 ||
	{ doLog "ERROR. mutt is not installed or not in PATH. Aborting." >&2; exit 1; }
   todays_daily_txt_dir="$proj_daily_data_root_dir"'/'"$(date +%Y)"'/'"$(date +%Y-%m)"'/'"$(date +%Y-%m-%d)"
  
   msg="nothing to do, as $todays_daily_txt_dir does NOT exist!!!"
   test -d "$todays_daily_txt_dir" || export exit_code=1
   test -d "$todays_daily_txt_dir" || doExit "$msg"

   msg="the $todays_daily_txt_dir dir exist proceed"
   doLog "DEBUG $msg"

	# cat doc/txt/issue-tracker/funcs/gmail-txt-issues.func.txt
	sleep "$sleep_interval"
   while read -r f ; do 
      subj=$(cat $f|head -n1)
      subj=$(echo $subj|perl -ne 's/START //g;print;')
      for Email in $Emails; do (
         echo -e "running: \n"
         echo mutt -s "$issue_tracker_project proj ::: $subj :::" -a "$f" -- "$Email" \< $f
         mutt -s "$issue_tracker_project proj ::: $subj :::" -a "$f" -- "$Email" < $f
         echo -e "\n"
      );
      done
   done < <(find $todays_daily_txt_dir -type f -name '*.txt')
   
	doLog "DEBUG STOP  doGmailTxtIssues"
}
# eof func doGmailTxtIssues


# eof file: src/bash/issue-tracker/funcs/gmail-txt-issues.func.sh
