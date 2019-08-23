#!/usr/bin/env bash
# file: src/bash/qto.sh doc at the eof file

# v0.6.9
#------------------------------------------------------------------------------
# the main function called
#------------------------------------------------------------------------------
main(){
   doInit

   args="$@"
   test -z "$args" && args='-a print-usage'

   doParseCmdArgs "$args"
   export exit_code=1 # assume a general error

   doSetVars
   doCheckReadyToStart
   doRunActions "$args"
   doExit $exit_code "# = STOP  MAIN = $run_unit "
}


# v0.6.9
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
doRunActions(){
	test -z ${PROJ_INSTANCE_DIR:-} && PROJ_INSTANCE_DIR=$product_instance_dir
	daily_backup_dir="$PROJ_INSTANCE_DIR/dat/mix/"$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")
   cd $product_instance_dir
   actions_to_run=''
   while read -d ' ' action ; do
      while read -r func_file ; do
         while read -r function_name ; do
            action_name=`echo $(basename $func_file)|sed -e 's/.func.sh//g'`
            test "$action_name" != "$action" && continue
            test "$action_name" == "$action" && actions_to_run=$(echo -e "$actions_to_run\n$function_name")
         done< <(get_function_list "$func_file")
      done < <(find "src/bash/$run_unit/funcs" -type f -name '*.sh')

      [[ $action == to-ver=* ]] && actions_to_run=$(echo -e "$actions_to_run\ndoChangeVersion $action")
      [[ $action == to-env=* ]] && actions_to_run=$(echo -e "$actions_to_run\ndoChangeEnvType $action")

   done < <(echo "$actions")

   while read -r action_to_run ; do
      cd $product_instance_dir
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


# v0.6.9 
#------------------------------------------------------------------------------
# register the run-time vars before the call of the $0
#------------------------------------------------------------------------------
doInit(){

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
   run_unit=${my_name_ext%.*}
   host_name=$(hostname -s)
   export sleep_interval="${sleep_interval:=0}"
   exit_code=1
}



# v0.6.9 
#------------------------------------------------------------------------------
# parse the single letter command line args
#------------------------------------------------------------------------------
doParseCmdArgs(){

   run_in_backround=0
   while getopts ":a:b:c:d:i:h:t:" opt; do
     case $opt in
      a)
         actions="${actions:-}""$OPTARG "
         ;;
      b)
         run_in_backround=1
         ;;
      c)
         export run_unit="$OPTARG "
         ;;
      d)
         export tgt_date="$OPTARG"
         ;;
      i)
         include_file="$OPTARG"
         ;;
      h)
         doPrintHelp
         ;;
      t)
         export tables="$OPTARG"
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


#------------------------------------------------------------------------------
# usage example:
# doExportJsonSectionVars cnf/env/dev.env.json '.env.virtual.docker.spark_base'
#------------------------------------------------------------------------------
doExportJsonSectionVars(){

   json_file="$1"
   shift 1;
   test -f "$json_file" || doExit 1 "the json_file: $json_file does not exist !!! Nothing to do"

   section="$1"
   test -z "$section" && doExit 1 "the section in doExportJsonSectionVars is empty !!! nothing to do !!!"
   shift 1;

	clearTheScreen
	doLog "INFO exporting vars: "
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
# doApplyShellExpansion /tmp/docker-compose.yml
#------------------------------------------------------------------------------
doApplyShellExpansion() {
   declare file="$1"
   shift 1;
   test -f "$file" || doExit 1 "doApplyShellExpansion: the file: $file does not exist !!! Nothing to do"
   perl -wpe 's#\${?(\w+)}?# $ENV{$1} // $& #ge;' $file
}




# v0.6.9 
# ------------------------------------------------------------------------------
# perform the checks to ensure that all the vars needed to run are set
# ------------------------------------------------------------------------------
doCheckReadyToStart(){

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


# v0.6.9
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
      doLog "FATAL STOP FOR $run_unit RUN with: "
      doLog "FATAL exit_code: $exit_code exit_msg: $exit_msg"
   else
      doLog "INFO  STOP FOR $run_unit RUN with: "
      doLog "INFO  STOP FOR $run_unit RUN: $exit_code $exit_msg"
   fi

   rm -rf "$run_unit_bash_dir/tmp" #clear the tmpdir
   cd $call_start_dir

   test $exit_code -ne 0 && kill -s TERM "$TOP_PID" && exit $exit_code
   test $exit_code -eq 0 && exit 0
}

# v0.6.9 
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
   test -t 1 && echo " [$type_of_msg] `date "+%Y.%m.%d-%H:%M:%S %Z"` [$run_unit][@$host_name] [$$] $msg "

   # define default log file none specified in cnf file
   test -z ${log_file:-} && \
		mkdir -p $PRODUCT_INSTANCE_DIR/dat/log/bash && \
			log_file="$PRODUCT_INSTANCE_DIR/dat/log/bash/$run_unit.`date "+%Y%m"`.log"
   echo " [$type_of_msg] `date "+%Y.%m.%d-%H:%M:%S %Z"` [$run_unit][@$host_name] [$$] $msg " >> $log_file
}


# v0.6.9 
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


#v0.6.9 
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


doSetVars(){

   cd $run_unit_bash_dir
   for i in {1..3} ; do cd .. ; done ; export PRODUCT_INSTANCE_DIR=`pwd`;
   environment_name=$(basename "$PRODUCT_INSTANCE_DIR")
   cd $PRODUCT_INSTANCE_DIR
   source $PRODUCT_INSTANCE_DIR/.env
   export product_version=$VERSION
   export env_type=$ENV_TYPE
   if [ "$environment_name" == "$run_unit" ]; then
      product_dir=$PRODUCT_INSTANCE_DIR
      test -z "$env_type" && export env_type='dev'
   else
      # this could be dev, tst , stg , qas , prd
      export product_owner=$(echo `basename "$PRODUCT_INSTANCE_DIR"`|cut -d'.' -f6)
      cd .. ; product_dir=`pwd`;
   fi

   cd .. ; product_base_dir=`pwd`;

   ( set -o posix ; set ) | sort >"$tmp_dir/vars.after"

   doLog "INFO # --------------------------------------"
   doLog "INFO # ===     START MAIN   === $run_unit"
   doLog "INFO # --------------------------------------"

   exit_code=0
   doLog "INFO using the following vars:"
   cmd="$(comm -3 $tmp_dir/vars.before $tmp_dir/vars.after | perl -ne 's#\s+##g;print "\n $_ "' )"
   echo -e "$cmd"

   while read -r func_file ; do source "$func_file" ; done < <(find $PRODUCT_INSTANCE_DIR -name "*func.sh")
   clearTheScreen

}





# v0.6.9
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
	test -f "$PRODUCT_INSTANCE_DIR/cnf/$run_unit.$host_name.cnf" \
		&& cnf_file="$PRODUCT_INSTANCE_DIR/cnf/$run_unit.$host_name.cnf"
	
   # if we have perl apps they will share the same cnfiguration settings with this one
	test -f "$PRODUCT_INSTANCE_DIR/cnf/$run_unit.$env_type.$host_name.cnf" \
		&& cnf_file="$PRODUCT_INSTANCE_DIR/cnf/$run_unit.$env_type.$host_name.cnf"

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
#
#eof file: qto.sh v0.6.9
