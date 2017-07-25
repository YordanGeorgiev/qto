#!/bin/bash 
# file: src/bash/issue-tracker.sh doc at the eof file

umask 022    ;

set -u -o pipefail

# print the commands
# set -x
# print each input line as well
# set -v
# exit the script if any statement returns a non-true return value. gotcha !!!
# set -e # src: http://mywiki.wooledge.org/BashFAQ/105
trap "exit 1" TERM
export TOP_PID=$$

#v1.2.5 
#------------------------------------------------------------------------------
# the main function called
#------------------------------------------------------------------------------
main(){
	doInit
   
   test -z "${1+x}" && arg='print-usage'

	case ${arg:-} in
		'-usage')
		actions="print-usage "
		;;
		'--usage')
		actions="print-usage "
		;;
		'-help')
		actions="print-help "
		;;
		'--help' )
		actions="print-help "
		;;
	esac

	test -z "${actions+x}" && doParseCmdArgs "$@"

	doSetVars
	doCheckReadyToStart
	doRunActions "$@"
	doExit 0 "# = STOP  MAIN = $run_unit "
}
#eof main

# v1.2.5 
#------------------------------------------------------------------------------
# the "reflection" func - identify the the funcs per file
#------------------------------------------------------------------------------
get_function_list () {
    env -i PATH=/bin:/usr/bin:/usr/local/bin bash --noprofile --norc -c '
    source "'"$1"'"
    typeset -f |
    grep '\''^[^{} ].* () $'\'' |
    awk "{print \$1}" |
    while read -r function_name; do
        type "$function_name" | head -n 1 | grep -q "is a function$" || continue
        echo "$function_name"
    done
'
}
#eof func get_function_list



# v1.2.5 
#------------------------------------------------------------------------------
# run all the actions
#------------------------------------------------------------------------------
doRunActions(){

	cd $product_instance_dir
   test -z "$actions" && doPrintUsage && doExit 0 

	while read -d ' ' action ; do (
		doLog "DEBUG action: \"$action\""

		while read -r func_file ; do (
         doLog "DEBUG func_file: $func_file"

			while read -r function_name ; do (
            doLog "DEBUG function_name: $function_name"

				action_name=`echo $(basename $func_file)|sed -e 's/.func.sh//g'`
				test "$action_name" != $action && continue
				
				doLog "INFO running action :: $action_name":"$function_name"
				test "$action_name" == "$action" && $function_name

			);
			done< <(get_function_list "$func_file")
		); 
		done < <(find src/bash/issue-tracker/funcs -type f -name '*.sh')

				
		test "$action" == 'to-dev'									&& doChangeEnvType 'dev'
		test "$action" == 'to-tst'									&& doChangeEnvType 'tst'
		test "$action" == 'to-git'									&& doChangeEnvType 'git'
		test "$action" == 'to-qas'									&& doChangeEnvType 'qas'
		test "$action" == 'to-prd'									&& doChangeEnvType 'prd'
		[[ $action == to-ver=* ]]									&& doChangeVersion $action
		[[ $action == to-app=* ]]									&& doCloneToApp $action
	);
	done < <(echo "$actions")



}
#eof func doRunActions


#v 1.2.5 
#------------------------------------------------------------------------------
# register the run-time vars before the call of the $0
#------------------------------------------------------------------------------
doInit(){
   call_start_dir=`pwd`
   run_unit_bash_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
   tmp_dir="$run_unit_bash_dir/tmp/.tmp.$$"
   mkdir -p "$tmp_dir"
   ( set -o posix ; set )| sort >"$tmp_dir/vars.before"
   my_name_ext=`basename $0`
   run_unit=${my_name_ext%.*}
   host_name=$(hostname -s)
: "${sleep_interval:=0}"
}
#eof doInit



#v1.2.5 
#------------------------------------------------------------------------------
# parse the single letter command line args
#------------------------------------------------------------------------------
doParseCmdArgs(){

   # traverse all the possible cmd args
   while getopts ":a:c:i:h:t:" opt; do
     case $opt in
      a)
         actions="${actions:-}""$OPTARG "
         ;;
      c)
         export run_unit="$OPTARG "
         ;;
      i)
         include_file="$OPTARG"
         ;;
      h)
         doPrintHelp
         ;;
      t)
         export tables="$OPTARG "
         ;;
      \?)
         doExit 2 "Invalid option: -$OPTARG"
         ;;
      :)
         doExit 2 "Option -$OPTARG requires an argument."
         ;;
     esac
   done
}
#eof func doParseCmdArgs




#v1.2.5 
#------------------------------------------------------------------------------
# create an example host dependant ini file
#------------------------------------------------------------------------------
doCreateDefaultConfFile(){

	echo -e "#file: $cnf_file \n\n" >> $cnf_file
	echo -e "[MainSection] \n" >> $cnf_file
	echo -e "#use simple var_name=var_value syntax \n">>$cnf_file
	echo -e "#the name of this application ">>$cnf_file
	echo -e "app_name=$run_unit\n" >> $cnf_file
	echo -e "#the e-mails to send the package to ">>$cnf_file
	echo -e "Emails=some.email@company.com\n" >> $cnf_file
	echo -e "#the name of this application's db" >> $cnf_file
	echo -e "db_name=$env_type""_""$run_unit\n\n" >> $cnf_file
	echo -e "#eof file: $cnf_file" >> $cnf_file

}
#eof func doCreateDefaultConfFile


#v1.2.5 
#------------------------------------------------------------------------------
# perform the checks to ensure that all the vars needed to run are set
#------------------------------------------------------------------------------
doCheckReadyToStart(){

   test -f $cnf_file || doCreateDefaultConfFile 

	# check http://stackoverflow.com/a/677212/65706
	# but which works for both cygwin and Ubuntu
	command -v zip 2>/dev/null || { echo >&2 "The zip binary is missing ! Aborting ..."; exit 1; }
	which perl 2>/dev/null || { echo >&2 "The perl binary is missing ! Aborting ..."; exit 1; }

}
#eof func doCheckReadyToStart





# v1.2.7
#------------------------------------------------------------------------------
# clean and exit with passed status and message
# call by: 
# export exit_code=0 ; doExit "ok msg"
# export exit_code=1 ; doExit "NOK msg"
#------------------------------------------------------------------------------
doExit(){
   exit_msg="$*"

   if (( $exit_code != 0 )); then
      exit_msg=" ERROR --- exit_code $exit_code --- exit_msg : $exit_msg"
      >&2 echo "$exit_msg"
      # doSendReport
      doLog "FATAL STOP FOR $run_unit RUN with: "
      doLog "FATAL exit_code: $exit_code exit_msg: $exit_msg"
   else
      doLog "INFO  STOP FOR $run_unit RUN with: "
      doLog "INFO  STOP FOR $run_unit RUN: $exit_code $exit_msg"
   fi

   doCleanAfterRun
	cd $call_start_dir 

   #src: http://stackoverflow.com/a/9894126/65706
   test $exit_code -ne 0 && kill -s TERM "$TOP_PID" && exit $exit_code
   test $exit_code -eq 0 && exit 0
   #test $exit_code -ne 0 && kill -9 "$TOP_PID"
}
#eof func doExit


#v1.2.5 
#------------------------------------------------------------------------------
# echo pass params and print them to a log file and terminal
# with timestamp and $host_name and $0 PID
# usage:
# doLog "INFO some info message"
# doLog "DEBUG some debug message"
#------------------------------------------------------------------------------
doLog(){
   type_of_msg=$(echo $*|cut -d" " -f1)
   msg="$(echo $*|cut -d" " -f2-)"
   [[ $type_of_msg == DEBUG ]] && [[ $do_print_debug_msgs -ne 1 ]] && return
   [[ $type_of_msg == INFO ]] && type_of_msg="INFO "

   # print to the terminal if we have one
   test -t 1 && echo " [$type_of_msg] `date "+%Y.%m.%d-%H:%M:%S"` [issue-tracker][@$host_name] [$$] $msg "

   # define default log file none specified in cnf file
   test -z ${log_file:-} && \
		mkdir -p $product_instance_dir/dat/log/bash && \
			log_file="$product_instance_dir/dat/log/bash/$run_unit.`date "+%Y%m"`.log"
   echo " [$type_of_msg] `date "+%Y.%m.%d-%H:%M:%S"` [$run_unit][@$host_name] [$$] $msg " >> $log_file
}
#eof func doLog

# v1.2.5 
#------------------------------------------------------------------------------
# echo pass params and print them to a log file and terminal
# with timestamp and $host_name and $0 PID
# usage:
# doLog "INFO some info message"
# doLog "DEBUG some debug message"
#------------------------------------------------------------------------------
doRunLog(){
   uuid="$*"

   # print to the terminal if we have one
   # test -t 1 && echo " [$type_of_msg] `date "+%Y.%m.%d-%H:%M:%S"` [issue-tracker][@$host_name] [$$] $msg "

   # define default log file none specified in cnf file
   test -z ${run_log_file:-} && \
		mkdir -p $product_instance_dir/dat/log && \
			export run_log_file="$product_instance_dir/dat/log/$run_unit.`date "+%Y%m%d_%H%M%S"`.run.log"
   echo "`date "+%Y-%m-%d - %H:%M:%S"` $uuid " >> $run_log_file
}
#eof func doLog

#v1.1.0
#------------------------------------------------------------------------------
# cleans the unneeded during after run-time stuff
# do put here the after cleaning code
#------------------------------------------------------------------------------
doCleanAfterRun(){
   # remove the temporary dir and all the stuff bellow it
   cmd="rm -fvr $tmp_dir"
   doRunCmdAndLog "$cmd"


#   while read -r f ; do 
#      test -f $f && rm -fv "$f" ; 
#   done < <(find "$run_unit_bash_dir" -type f -name '*.bak')
}
#eof func doCleanAfterRun


#v1.2.5 
#------------------------------------------------------------------------------
# run a command and log the call and its output to the log_file
# doPrintHelp: doRunCmdAndLog "$cmd"
#------------------------------------------------------------------------------
doRunCmdAndLog(){
  cmd="$*" ;
  doLog "DEBUG running cmd and log: \"$cmd\""

   msg=$($cmd 2>&1)
   ret_cmd=$?
   error_msg=": Failed to run the command:
		\"$cmd\" with the output:
		\"$msg\" !!!"

   [ $ret_cmd -eq 0 ] || doLog "$error_msg"
   doLog "DEBUG : cmdoutput : \"$msg\""
}
#eof func doRunCmdAndLog


#v1.2.5 
#------------------------------------------------------------------------------
# run a command on failure exit with message
# doPrintHelp: doRunCmdOrExit "$cmd"
# call by:
# set -e ; doRunCmdOrExit "$cmd" ; set +e
#------------------------------------------------------------------------------
doRunCmdOrExit(){
   cmd="$*" ;

   doLog "DEBUG running cmd or exit: \"$cmd\""
   msg=$($cmd 2>&1)
   exit_code=$?
   # if occured during the execution exit with error
   error_msg=": FATAL : Failed to run the command \"$cmd\" with the output \"$msg\" !!!"
   [ $exit_code -eq 0 ] || doExit "$exit_code" "$error_msg"

   #if no occured just log the message
   doLog "DEBUG : cmdoutput : \"$msg\""
}
#eof func doRunCmdOrExit


#v1.2.5 
#------------------------------------------------------------------------------
# set the variables from the $0.$host_name.cnf file which has ini like syntax
#------------------------------------------------------------------------------
doSetVars(){
   cd $run_unit_bash_dir
   for i in {1..3} ; do cd .. ; done ;
   export product_instance_dir=`pwd`;
	# include all the func files to fetch their funcs 
	while read -r func_file ; do . "$func_file" ; done < <(find . -name "*func.sh")
	# while read -r func_file ; do echo "$func_file" ; done < <(find . -name "*func.sh")

   # this will be dev , tst, prd
   env_type=$(echo `basename "$product_instance_dir"`|cut -d'.' -f5)
	product_version=$(echo `basename "$product_instance_dir"`|cut -d'.' -f2-4)
	environment_name=$(basename "$product_instance_dir")

	cd ..
	product_dir=`pwd`;

	cd ..
	product_base_dir=`pwd`;

	org_dir=`pwd`
	org_name=$(echo `basename "$org_dir"`)

	cd ..
	org_base_dir=`pwd`;

	cd "$run_unit_bash_dir/"

   # start set default vars
   do_print_debug_msgs=0
   # stop set default vars

	test -z "${issue_tracker_project:-}" && doParseConfFile
	test -z "$issue_tracker_project" || doSetUndefinedShellVarsFromCnfFile


	( set -o posix ; set ) | sort >"$tmp_dir/vars.after"


	doLog "INFO # --------------------------------------"
	doLog "INFO # -----------------------"
	doLog "INFO # ===		 START MAIN   === $run_unit"
	doLog "INFO # -----------------------"
	doLog "INFO # --------------------------------------"
   doRunLog 'e880f14d-38f1-4bce-968e-2dc6b0d7e461'
	
		exit_code=0
		doLog "INFO using the following vars:"
		cmd="$(comm -3 $tmp_dir/vars.before $tmp_dir/vars.after | perl -ne 's#\s+##g;print "\n $_ "' )"
		echo -e "$cmd"

		# and clear the screen
		printf "\033[2J";printf "\033[0;0H"
}
#eof func doSetVars


#------------------------------------------------------------------------------
# set vars from the cnf file, but only if they are not pre-set in the calling shell
#------------------------------------------------------------------------------
doSetUndefinedShellVarsFromCnfFile(){

	# set a default cnfiguration file
	cnf_file="$run_unit_bash_dir/$run_unit.cnf"

	# however if there is a host dependant cnf file override it
	test -f "$run_unit_bash_dir/$run_unit.$host_name.cnf" \
		&& cnf_file="$run_unit_bash_dir/$run_unit.$host_name.cnf"
	
	# if we have perl apps they will share the same cnfiguration settings with this one
	test -f "$product_instance_dir/$run_unit.$host_name.cnf" \
		&& cnf_file="$product_instance_dir/$run_unit.$host_name.cnf"
   
   # however if there is a host dependant and env-aware cnf file override it
	test -f "$product_instance_dir/$run_unit.$env_type.$host_name.cnf" \
		&& cnf_file="$product_instance_dir/$run_unit.$env_type.$host_name.cnf"

	INI_SECTION=MainSection

	vars_to_set=`sed -e 's/[[:space:]]*\=[[:space:]]*/=/g' \
		-e 's/#.*$//' \
		-e 's/[[:space:]]*$//' \
		-e 's/^[[:space:]]*//' \
      -e "s/^\(.*\)=\([^\"']*\)$/test -z \"\$\1\" \&\& export \1=\"\2\"/" \
		< $cnf_file \
		| sed -n -e "/^\[$INI_SECTION\]/,/^\s*\[/{/^[^#].*\=.*/p;}"`
   
   while IFS=' ' read -r var_to_set
   do
      echo "running: $var_to_set"
      eval "$var_to_set"
   done < "$vars_to_set"

   vars_to_set=""
}
#eof func doSetShellVarsFromCnfFile

# v1.2.5
#------------------------------------------------------------------------------
# parse the ini like $0.$host_name.cnf and set the variables
# cleans the unneeded during after run-time stuff. Note the MainSection
# courtesy of : http://mark.aufflick.com/blog/2007/11/08/parsing-ini-files-with-sed
#------------------------------------------------------------------------------
doParseConfFile(){
	# set a default cnfiguration file
	cnf_file="$run_unit_bash_dir/$run_unit.cnf"

	# however if there is a host dependant cnf file override it
	test -f "$run_unit_bash_dir/$run_unit.$host_name.cnf" \
		&& cnf_file="$run_unit_bash_dir/$run_unit.$host_name.cnf"
	
	# if we have perl apps they will share the same cnfiguration settings with this one
	test -f "$product_instance_dir/cnf/$run_unit.$host_name.cnf" \
		&& cnf_file="$product_instance_dir/cnf/$run_unit.$host_name.cnf"
	
   # if we have perl apps they will share the same cnfiguration settings with this one
	test -f "$product_instance_dir/cnf/$run_unit.$env_type.$host_name.cnf" \
		&& cnf_file="$product_instance_dir/cnf/$run_unit.$env_type.$host_name.cnf"

	# yet finally override if passed as argument to this function
	# if the the ini file is not passed define the default host independant ini file
	test -z "${1:-}" || cnf_file=$1;shift 1;
	#debug echo "@doParseConfFile cnf_file:: $cnf_file" 
	# coud be later on parametrized ... 
	INI_SECTION=MainSection

	eval `sed -e 's/[[:space:]]*\=[[:space:]]*/=/g' \
		-e 's/#.*$//' \
		-e 's/[[:space:]]*$//' \
		-e 's/^[[:space:]]*//' \
		-e "s/^\(.*\)=\([^\"']*\)$/\1=\"\2\"/" \
		< $cnf_file \
		| sed -n -e "/^\[$INI_SECTION\]/,/^\s*\[/{/^[^#].*\=.*/p;}"`
   
		
}
#eof func doParseConfFile



# Action !!!
main "$@"

#
#----------------------------------------------------------
# Purpose:
# a simplistic app stub with simplistic source control and 
# cloning or morphing functionalities ...
#----------------------------------------------------------
#
#----------------------------------------------------------
# Requirements: bash , perl , ctags
#
#----------------------------------------------------------
#
#----------------------------------------------------------
#  EXIT CODES
# 0 --- Successfull completion
# 1 --- required binary not installed 
# 2 --- Invalid options 
# 3 --- deployment file not found
# 4 --- perl syntax check error
#----------------------------------------------------------
#
# VersionHistory:
#------------------------------------------------------------------------------
# 1.0.0 --- 2016-09-11 12:24:15 -- init from bash-stub
#----------------------------------------------------------
#
#eof file: issue-tracker.sh v1.2.5
