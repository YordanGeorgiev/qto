#!/usr/bin/env bash
# file: src/bash/qto.sh doc at the eof file

# v0.7.1
#------------------------------------------------------------------------------
# the main shell entry point of the qto application
#------------------------------------------------------------------------------
main(){
   do_init

   is_daemon=0

	while getopts "a:d:t:" opt; do
		 case $opt in
			  a) actions+=("$OPTARG ");;
			  t) table+=("$OPTARG ");;
			  d) is_daemon+=("$OPTARG ");;
			  \?) doExit 2 "Invalid option: -$OPTARG";;
			  :) doExit 2 "Option -$OPTARG requires an argument."
		 esac
	done
	shift $((OPTIND -1))

   do_set_vars
   do_check_ready_to_start
   test -z "${actions:-}" && actions=' print-usage '
   do_run_actions "$actions"
   do_check_git_hooks
   doExit $exit_code "# = STOP  MAIN = $RUN_UNIT "
}


# v0.7.1
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


#
#------------------------------------------------------------------------------
# run only the actions passed with the -a <<action-name-arg>>
#------------------------------------------------------------------------------
do_run_actions(){
   actions=$1 ; shift 1
      test -z ${PROJ_INSTANCE_DIR:-} && PROJ_INSTANCE_DIR=$PRODUCT_INSTANCE_DIR
      daily_backup_dir="$PROJ_INSTANCE_DIR/dat/mix/"$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")
      cd $PRODUCT_INSTANCE_DIR
      actions="$(echo -e "${actions}" | sed -e 's/^[[:space:]]*//')" #or how-to trim leading space
      actions_to_run=''
      while read -d ' ' arg_action ; do
         # debug  arg_action:$arg_action
         while read -r func_file ; do
            # debug func func_file:$func_file
            while read -r function_name ; do
               # debug  function_name:$function_name
               action_name=`echo $(basename $func_file)|sed -e 's/.func.sh//g'`
               # debug  action_name: $action_name
               test "$action_name" != "$arg_action" && continue
               test "$action_name" == "$arg_action" && actions_to_run=$(echo -e "$actions_to_run\n$function_name")
               # debug actions_to_run: $actions_to_run
            done< <(get_function_list "$func_file")
         done < <(find "src/bash/$RUN_UNIT/funcs" -type f -name '*.sh'|sort)

      [[ $arg_action == to-ver=* ]] && actions_to_run=$(echo -e "$actions_to_run\ndoChangeVersion $arg_action")
      [[ $arg_action == to-env=* ]] && actions_to_run=$(echo -e "$actions_to_run\ndoChangeEnvType $arg_action")

      done < <(echo "$actions")

   while read -r action_to_run ; do
      cd $PRODUCT_INSTANCE_DIR
      doLog "INFO start running action :: $action_to_run"
      $action_to_run
      exit_code=$?
      if [[ "$exit_code" != "0" ]]; then
         exit $exit_code
      fi
      doLog "INFO stop  running action :: $action_to_run"
   done < <(echo $actions_to_run)

	test -d "$daily_backup_dir" || doBackupPostgresDb

}


# v0.7.1 
#------------------------------------------------------------------------------
# register the run-time vars before the call of the $0
#------------------------------------------------------------------------------
do_init(){

   # set -x # print the commands
   # set -v # print each input line as well
   # exit the script if any statement returns a non-true return value. gotcha !!!
   # set -e # src: http://mywiki.wooledge.org/BashFAQ/105
   umask 022    ;
   set -u -o pipefail 
   call_start_dir=`pwd`
   run_unit_bash_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
   tmp_dir="$run_unit_bash_dir/tmp/.tmp.$$"
   mkdir -p "$tmp_dir"
   ( set -o posix ; set )| sort >"$tmp_dir/vars.before"
   my_name_ext=`basename $0`
   RUN_UNIT=${my_name_ext%.*}
   host_name=$(hostname -s)
   export sleep_interval="${sleep_interval:=0}"
   export exit_code=1
}


#------------------------------------------------------------------------------
# usage example:
# doExportJsonSectionVars cnf/env/dev.env.json '.env.app'
#------------------------------------------------------------------------------
doExportJsonSectionVars(){

   json_file="$1"
   shift 1;
   test -f "$json_file" || doExit 1 "the json_file: $json_file does not exist !!! Nothing to do"

   section="$1"
   test -z "$section" && doExit 1 "the section in doExportJsonSectionVars is empty !!! nothing to do !!!"
   shift 1;

	clearTheScreen
	doLog "INFO exporting vars from cnf $json_file: "
   while read -r l ; do
     key=$(echo $l|cut -d'=' -f1)
     val=$(echo $l|cut -d'=' -f2)
     eval "$(echo -e 'export '$key=\"\"$val\"\")"
     doLog "INFO $key=$val"
   done < <(cat "$json_file"| jq -r "$section"'|keys_unsorted[] as $key|"\($key)=\"\(.[$key])\""')
}


#
#------------------------------------------------------------------------------
# usage example:
# do_apply_shell_expansion /tmp/docker-compose.yml
#------------------------------------------------------------------------------
do_apply_shell_expansion() {
   declare file="$1"
   shift 1;
   test -f "$file" || doExit 1 "do_apply_shell_expansion: the file: $file does not exist !!! Nothing to do"
   perl -wpe 's#\${?(\w+)}?# $ENV{$1} // $& #ge;' $file
}




# v0.7.1 
# ------------------------------------------------------------------------------
# perform the checks to ensure that all the vars needed to run are set
# ------------------------------------------------------------------------------
do_check_ready_to_start(){

   test -f ${cnf_file-} || doCreateDefaultConfFile 

   echo 'checking for the required binaries ...'
	command -v zip 2>/dev/null || { echo >&2 "The zip binary is missing ! Aborting ..."; exit 1; }
	command -v unzip 2>/dev/null || { echo >&2 "The unzip binary is missing ! Aborting ..."; exit 1; }
	which perl 2>/dev/null || { echo >&2 "The perl binary is missing ! Aborting ..."; exit 1; }
	which grep 2>/dev/null || { echo >&2 "The grep binary is missing ! Aborting ..."; exit 1; }
	which sed 2>/dev/null || { echo >&2 "The sed binary is missing ! Aborting ..."; exit 1; }
	which awk 2>/dev/null || { echo >&2 "The awk binary is missing ! Aborting ..."; exit 1; }
	which jq 2>/dev/null || { echo >&2 "The jq binary is missing ! Aborting ..."; exit 1; }
   echo 'ok' ; printf "\n"

   if [[ "$OSTYPE" == "darwin"* ]]; then
		export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
		export PATH="/usr/local/opt/grep/libexec/gnubin/:$PATH"
   fi
}



trap "exit 1" TERM
export TOP_PID=$$


# v0.7.1
# ------------------------------------------------------------------------------
# clean and exit with passed status and message
# call by:
# doExit 0 "ok msg"
# doExit 1 "NOK msg"
# ------------------------------------------------------------------------------
doExit(){
   exit_code=$1 ; shift
   exit_msg="$*"

   if (( ${exit_code:-} != 0 )); then
      exit_msg=" ERROR --- exit_code $exit_code --- exit_msg : $exit_msg"
      >&2 echo "$exit_msg"
      doLog "FATAL STOP FOR $RUN_UNIT RUN with: "
      doLog "FATAL exit_code: $exit_code exit_msg: $exit_msg"
   else
      doLog "INFO  STOP FOR $RUN_UNIT RUN with: "
      doLog "INFO  STOP FOR $RUN_UNIT RUN: $exit_code $exit_msg"
   fi

   rm -rf "$run_unit_bash_dir/tmp" #clear the tmpdir
   cd $call_start_dir

   test $exit_code -ne 0 && kill -s TERM "$TOP_PID" && exit $exit_code
   test $exit_code -eq 0 && exit 0
}


# v0.7.1 
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

   [[ $type_of_msg == DEBUG ]] && [[ ${do_print_debug_msgs-} -ne 1 ]] && return
   [[ $type_of_msg == INFO ]] && type_of_msg="INFO "

   # print to the terminal if we have one
   test -t 1 && echo " [$type_of_msg] `date "+%Y.%m.%d-%H:%M:%S %Z"` [$RUN_UNIT][@$host_name] [$$] $msg "

   # define default log file none specified in cnf file
   test -z ${log_file:-} && \
		mkdir -p $PRODUCT_INSTANCE_DIR/dat/log/bash && \
			log_file="$PRODUCT_INSTANCE_DIR/dat/log/bash/$RUN_UNIT.`date "+%Y%m"`.log"
   echo " [$type_of_msg] `date "+%Y.%m.%d-%H:%M:%S %Z"` [$RUN_UNIT][@$host_name] [$$] $msg " >> $log_file
}


# v0.7.1 
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


# v0.7.1 
#------------------------------------------------------------------------------
# run a command on failure exit with message
# doPrintHelp: doRunCmdOrExit "$cmd"
# call by:
# set -e ; doRunCmdOrExit "$cmd" ; set +e
#------------------------------------------------------------------------------
doRunCmdOrExit(){
   cmd=$* ;

   doLog "DEBUG running cmd or exit: "$cmd
   msg=$($cmd 2>&1)
   export exit_code=$?

   # if occured during the execution exit with error
   error_msg="Failed to run the command: 
		\"$cmd\" with the output: 
		\"$msg\" !!!"

	if [ $exit_code -ne 0 ] ; then
		doLog "ERROR $msg"
		doLog "FATAL $msg"
		doExit "$exit_code" "$error_msg"
	else
   	#if no errors occured just log the message
   	doLog "DEBUG : cmdoutput : "$msg
		doLog "INFO  "$msg
	fi

}


clearTheScreen(){
	printf "\033[2J";printf "\033[0;0H"
}


do_set_vars(){

   cd $run_unit_bash_dir
   for i in {1..3} ; do cd .. ; done ; export PRODUCT_INSTANCE_DIR=`pwd`;
   environment_name=$(basename "$PRODUCT_INSTANCE_DIR")
   cd $PRODUCT_INSTANCE_DIR
   source $PRODUCT_INSTANCE_DIR/.env
   export product_version=$VERSION
   export env_type=$ENV_TYPE

   if [ "$environment_name" == "$RUN_UNIT" ]; then
      product_dir=$PRODUCT_INSTANCE_DIR
      test -z "$env_type" && export env_type='dev'
   else
      # this could be dev, tst , stg , qas , prd
      export product_owner=$(echo `basename "$PRODUCT_INSTANCE_DIR"`|cut -d'.' -f6)
      cd .. ; product_dir=`pwd`;
   fi

   cd .. ; product_base_dir=`pwd`; org_name=$(basename `pwd`)

   ( set -o posix ; set ) | sort >"$tmp_dir/vars.after"

   doLog "INFO # --------------------------------------"
   doLog "INFO # ===     START MAIN   === $RUN_UNIT"
   doLog "INFO # --------------------------------------"

   exit_code=0
   doLog "INFO using the following vars:"
   cmd="$(comm -3 $tmp_dir/vars.before $tmp_dir/vars.after | perl -ne 's#\s+##g;print "\n $_ "' )"
   echo -e "$cmd"

   while read -r func_file ; do source "$func_file" ; done < <(find $PRODUCT_INSTANCE_DIR -name "*func.sh")
   clearTheScreen

}

do_check_git_hooks(){
   test "$(grep -c 'run-functional-tests' $PRODUCT_INSTANCE_DIR/.git/hooks/pre-commit)" -lt 1 && {
      echo "
         ./src/bash/qto/qto.sh -a run-functional-tests
      " >> $PRODUCT_INSTANCE_DIR/.git/hooks/pre-commit
   }
   test "$(grep -c 'unscramble-confs' $PRODUCT_INSTANCE_DIR/.git/hooks/pre-push)" -lt 1 && {
      echo "
         ./src/bash/qto/qto.sh -a unscramble-confs
      " >> $PRODUCT_INSTANCE_DIR/.git/hooks/pre-push
   }

}


# Action !!!
main "$@"

#
#----------------------------------------------------------
# Purpose:
# the main entry point of the app - runs shell actions 
# -a <<run-shell-action>> which a doRunShellAction func
# stored in the src/bash/qto/funcs/run-shell-action.func.sh
#----------------------------------------------------------
#
#----------------------------------------------------------
#  EXIT CODES
# 0 --- Successfull completion
# 1 --- error 
#----------------------------------------------------------
#
#
#eof file src/bash/qto/qto.sh
