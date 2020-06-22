#!/usr/bin/env bash 
# file: src/bash/qto/test-qto.sh

umask 022    ;

# print the commands
# set -x
# print each input line as well
# set -v
# exit the script if any statement returns a non-true return value. gotcha !!!
# set -e
trap 'do_exit $LINENO $BASH_COMMAND; exit' SIGHUP SIGINT SIGQUIT
trap "exit $exit_code" TERM
export TOP_PID=$$

# v1.2.8 
#------------------------------------------------------------------------------
# the main function called
#------------------------------------------------------------------------------
main(){
   doInit
  	doSetVars
	doRunTests "$@"
  	do_exit 0 "# = STOP  MAIN = $RUN_UNIT_TESTER "

}
#eof main


# v1.2.8 
#------------------------------------------------------------------------------
# the "reflection" func
#------------------------------------------------------------------------------
get_function_list() {
    env -i bash --noprofile --norc -c '
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


#
# v1.2.8
#------------------------------------------------------------------------------
# run all the actions
#------------------------------------------------------------------------------
doRunTests(){
	cd $product_instance_dir

   do_logTestRunEntry 'INIT'
   do_log "INFO actions list file:
   $product_instance_dir/src/bash/qto/tests/run-qto-tests.lst"
   do_log "INFO running the following actions : "
   cat $product_instance_dir/src/bash/qto/tests/run-qto-tests.lst | grep -v '#'
   sleep 1

	while read -r action ; do (

		# exit as soon as ## is found
		[[ ${action:0:2} = \#\# ]] && break
		# do not run a test if it is commented out ( starts with # )
		[[ ${action:0:1} = \# ]] && continue

		do_log "INFO START :: testing action: \"$action\""
      do_logTestRunEntry 'START'
		while read -r test_file ; do (
			# do_log "test_file: \"$test_file\""
			while read -r function_name ; do (
				action_name=`echo $(basename $test_file)|sed -e 's/.test.sh//g'`
            
            if [ "$action_name" != "$action" ]
            then
               continue
            else
				   do_log "INFO START ::: calling function":"$function_name"
               do_logTestRunEntry 'INFO' ' '$(date "+%H:%M:%S")
               $function_name
               do_log "INFO test-qto loop exit_code: $exit_code" 
               do_logTestRunEntry 'INFO' ' '$(date "+%H:%M:%S")
               do_logTestRunEntry 'INFO' ' '"$action_name"
               # all testing functions should export their exit code
               do_logTestRunEntry 'STOP' $exit_code
				   # and clear the screen
		         do_log "INFO STOP :: testing action: \"$action\""
               # test $exit_code -ne 0 && do_exit $exit_code "FATAL $function_name"
				   sleep $sleep_interval
				   printf "\033[2J";printf "\033[0;0H"
            fi
			);
			done< <(get_function_list "$test_file")
		); 
		done < <(find src/bash/qto/tests -type f -name '*.sh')

	);
	done < <(cat $product_instance_dir/src/bash/qto/tests/run-qto-tests.lst)

   do_logTestRunEntry 'STATUS'
}
#eof fun doRunTests


# v1.2.8 
#------------------------------------------------------------------------------
# register the run-time vars before the call of the $0
#------------------------------------------------------------------------------
doInit(){
   call_start_dir=`pwd`
   wrap_bash_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
   tmp_dir="$wrap_bash_dir/tmp/.tmp.$$"
   mkdir -p "$tmp_dir"
   ( set -o posix ; set ) | sort >"$tmp_dir/vars.before"
   my_name_ext=`basename $0`
   RUN_UNIT_TESTER=${my_name_ext%.*}
   host_name=$(hostname -s)
   export sleep_interval=${sleep_interval:=0}   # to slow down during debuging export sleep_iterval=3
}
#eof doInit


# v1.0.8
#------------------------------------------------------------------------------
# clean and exit with passed status and message
#------------------------------------------------------------------------------
do_exit(){
   exit_code=0
   exit_msg="$*"

   echo -e "\n\n"
	cd $call_start_dir

   case $1 in [0-9])
      exit_code="$1";
      shift 1;
   esac

   if (( $exit_code != 0 )); then
      exit_msg=" ERROR --- exit_code $exit_code --- exit_msg : $exit_msg"
      >&2 echo "$exit_msg"
      # doSendReport
      do_log "FATAL STOP FOR $RUN_UNIT_TESTER RUN with: "
      do_log "FATAL exit_code: $exit_code exit_msg: $exit_msg"
   else
      do_log "INFO  STOP FOR $RUN_UNIT_TESTER RUN with: "
      do_log "INFO  STOP FOR $RUN_UNIT_TESTER RUN: $exit_code $exit_msg"
   fi

   doCleanAfterRun

   #src: http://stackoverflow.com/a/9894126/65706
   test $exit_code -ne 0 && kill -s TERM $TOP_PID
   test $exit_code -eq 0 && exit 0

}
#eof func do_exit

# v1.2.8 
#------------------------------------------------------------------------------
# echo pass params and print them to a log file and terminal
# with timestamp and $host_name and $0 PID
# usage:
# do_log "INFO some info message"
# do_log "DEBUG some debug message"
#------------------------------------------------------------------------------
do_log(){
   type_of_msg=$(echo $*|cut -d " " -f1)
   msg="$(echo $*|cut -d " " -f2-)"
   [[ $type_of_msg == DEBUG ]] && [[ $do_print_debug_msgs -ne 1 ]] && return
   [[ $type_of_msg == INFO ]] && type_of_msg="INFO "

   # print to the terminal if we have one
   test -t 1 && echo " [$type_of_msg] `date "+%Y.%m.%d-%H:%M:%S"` [qto][@$host_name] [$$] $msg "

   # define default log file none specified in cnf file
   test -z $log_file && \
		mkdir -p $product_instance_dir/dat/log/bash && \
			log_file="$product_instance_dir/dat/log/bash/$RUN_UNIT_TESTER.`date "+%Y%m"`.log"
   echo " [$type_of_msg] `date "+%Y.%m.%d-%H:%M:%S"` [$RUN_UNIT_TESTER][@$host_name] [$$] $msg " >> $log_file
}
#eof func do_log


#v1.2.8
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
#   done < <(find "$wrap_bash_dir" -type f -name '*.bak')
}
#eof func doCleanAfterRun


# v1.2.8 
#------------------------------------------------------------------------------
# run a command and log the call and its output to the log_file
# doPrintHelp: doRunCmdAndLog "$cmd"
#------------------------------------------------------------------------------
doRunCmdAndLog(){
  cmd="$*" ;
  do_log "DEBUG running cmd and log: \"$cmd\""

   msg=$($cmd 2>&1)
   ret_cmd=$?
   error_msg=": Failed to run the command:
		\"$cmd\" with the output:
		\"$msg\" !!!"

   [ $ret_cmd -eq 0 ] || do_log "$error_msg"
   do_log "DEBUG : cmdoutput : \"$msg\""
}
#eof func doRunCmdAndLog


# v1.2.8 
#------------------------------------------------------------------------------
# run a command on failure exit with message
# doPrintHelp: doRunCmdOrExit "$cmd"
# call by:
# set -e ; doRunCmdOrExit "$cmd" ; set +e
#------------------------------------------------------------------------------
doRunCmdOrExit(){
   cmd="$*" ;

   do_log "DEBUG running cmd or exit: \"$cmd\""
   msg=$($cmd 2>&1)
   ret_cmd=$?
   # if occured during the execution exit with error
   error_msg=": FATAL : Failed to run the command \"$cmd\" with the output \"$msg\" !!!"
   [ $ret_cmd -eq 0 ] || do_exit "$ret_cmd" "$error_msg"

   #if no occured just log the message
   do_log "DEBUG : cmdoutput : \"$msg\""
}
#eof func doRunCmdOrExit


# v1.2.8 
#------------------------------------------------------------------------------
# set the variables from the $0.$host_name.cnf file which has ini like syntax
#------------------------------------------------------------------------------
doSetVars(){
   cd $wrap_bash_dir
   for i in {1..3} ; do cd .. ; done ;
   export product_instance_dir=`pwd`;
   
   # add the do_logTestRunEntry func
   . "$product_instance_dir/src/bash/qto/funcs/log-test-run-entry.func.sh"

	# include all the func files to fetch their funcs 
	while read -r test_file ; do . "$test_file" ; done < <(find . -name "*test.sh")
	#while read -r test_file ; do echo "$test_file" ; done < <(find . -name "*test.sh")

	while read -r spec_file ; do . "$spec_file" ; done < <(find . -name "*spec.sh")
	#while read -r test_file ; do echo "$test_file" ; done < <(find . -name "*test.sh")
	
	while read -r help_file ; do . "$help_file" ; done < <(find . -name "*help.sh")
	#while read -r test_file ; do echo "$test_file" ; done < <(find . -name "*test.sh")
   
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

	cd "$wrap_bash_dir/"

   # start settiing default vars
   do_print_debug_msgs=0
   # stop settiing default vars


	doParseConfFile
	( set -o posix ; set ) | sort >"$tmp_dir/vars.after"


	do_log "INFO # --------------------------------------"
	do_log "INFO # -----------------------"
	do_log "INFO # ===		 START MAIN   === $RUN_UNIT_TESTER"
	do_log "INFO # -----------------------"
	do_log "INFO # --------------------------------------"
		
	exit_code=0
	do_log "INFO using the following vars:"
	cmd="$(comm -3 $tmp_dir/vars.before $tmp_dir/vars.after | perl -ne 's#\s+##g;print "\n $_ "' )"
	echo -e "$cmd"

	# and clear the screen
	printf "\033[2J";printf "\033[0;0H"
}
#eof func doSetVars


# v1.2.8
#------------------------------------------------------------------------------
# parse the ini like $0.$host_name.cnf and set the variables
# cleans the unneeded during after run-time stuff. Note the MainSection
# courtesy of : http://mark.aufflick.com/blog/2007/11/08/parsing-ini-files-with-sed
#------------------------------------------------------------------------------
doParseConfFile(){
	# set a default cnfiguration file
	cnf_file="$wrap_bash_dir/$RUN_UNIT_TESTER.cnf"

	# however if there is a host dependant cnf file override it
	test -f "$wrap_bash_dir/$RUN_UNIT_TESTER.$host_name.cnf" \
		&& cnf_file="$wrap_bash_dir/$RUN_UNIT_TESTER.$host_name.cnf"
	
	# if we have perl apps they will share the same cnfiguration settings with this one
	test -f "$product_instance_dir/$RUN_UNIT_TESTER.$host_name.cnf" \
		&& cnf_file="$product_instance_dir/$RUN_UNIT_TESTER.$host_name.cnf"

	# yet finally override if passed as argument to this function
	# if the the ini file is not passed define the default host independant ini file
	test -z "$1" || cnf_file=$1;shift 1;
	#debug echo "@doParseConfFile cnf_file:: $cnf_file" ; sleep 6
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
# a simplistic tester for the qto
#----------------------------------------------------------
#
#----------------------------------------------------------
# Requirements: bash , perl , [ ctags ] , [ mutt ]
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
# 1.1.0 --- 2017-03-05 16:48:13 -- change to do_exit , added testing report
# 1.0.0 --- 2016-09-11 12:24:15 -- init from bash-stub
#----------------------------------------------------------
#
# eof file: src/bash/qto/test-qto.sh
