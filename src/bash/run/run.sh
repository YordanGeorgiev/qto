#!/usr/bin/env bash

main(){
   do_set_vars "$@"  # is inside, unless --help flag is present
   ts=$(date "+%Y%m%d_%H%M%S")
   main_log_dir=~/var/log/$RUN_UNIT/; mkdir -p $main_log_dir
   main_exec "$@" \
    > >(tee $main_log_dir/$RUN_UNIT.$ts.out.log) \
    2> >(tee $main_log_dir/$RUN_UNIT.$ts.err.log)
}

main_exec(){
   do_resolve_os
   do_check_install_min_req_bins
   do_load_functions

   test -z ${actions:-} || {
      do_run_actions "$actions"
   }
   do_finalize
}


#------------------------------------------------------------------------------
# the "reflection" func - identify the the funcs per file
#------------------------------------------------------------------------------
get_function_list () {
   env -i PATH=/bin:/usr/bin:/usr/local/bin bash --noprofile --norc -c '
      source "'"$1"'"
      typeset -f |
      grep '\''^[^{} ].* () $'\'' |
      awk "{print \$1}" |
      while read -r fnc_name; do
         type "$fnc_name" | head -n 1 | grep -q "is a function$" || continue
            echo "$fnc_name"
            done
            '
}


do_read_cmd_args() {

   while [[ $# -gt 0 ]]; do
      case "$1" in
         -a|--actions) shift && actions="${actions:-}${1:-} " && shift ;;
         -h|--help) actions=' do_print_usage ' && ENV=lde && shift ;;
         *) echo FATAL unknown "cmd arg: '$1' - invalid cmd arg, probably a typo !!!" && shift && exit 1
    esac
  done
   shift $((OPTIND -1))

}


do_run_actions(){
   actions=$1
      cd $PRODUCT_DIR
      actions="$(echo -e "${actions}"|sed -e 's/^[[:space:]]*//')"  #or how-to trim leading space
      run_funcs=''
      while read -d ' ' arg_action ; do
         while read -r fnc_file ; do
            #debug func fnc_file:$fnc_file
            while read -r fnc_name ; do
               #debug fnc_name:$fnc_name
               action_name=`echo $(basename $fnc_file)|sed -e 's/.func.sh//g'`
               action_name=`echo do_$action_name|sed -e 's/-/_/g'`
               # debug  action_name: $action_name
               test "$action_name" != "$arg_action" && continue
               source $fnc_file
               test "$action_name" == "$arg_action" && run_funcs="$(echo -e "${run_funcs}\n$fnc_name")"
            done< <(get_function_list "$fnc_file")
         done < <(find "src/bash/run/" -type f -name '*.func.sh'|sort)

      done < <(echo "$actions")

   run_funcs="$(echo -e "${run_funcs}"|sed -e 's/^[[:space:]]*//;/^$/d')"
   while read -r run_func ; do
      cd $PRODUCT_DIR
      do_log "INFO START ::: running action :: $run_func"
      $run_func
      if [[ "${exit_code:-}" != "0" ]]; then
        do_log "FATAL failed to run action: $run_func !!!"
         exit $exit_code
      fi
      do_log "INFO STOP ::: running function :: $run_func"
   done < <(echo "$run_funcs")

}


do_flush_screen(){
   # printf "\033[2J";printf "\033[0;0H"
   echo ""
}


#------------------------------------------------------------------------------
# echo pass params and print them to a log file and terminal
# usage:
# do_log "INFO some info message"
# do_log "DEBUG some debug message"
#------------------------------------------------------------------------------
do_log(){
   type_of_msg=$(echo $*|cut -d" " -f1)
   msg="$(echo $*|cut -d" " -f2-)"
   log_dir="${PRODUCT_DIR:-}/dat/log/bash" ; mkdir -p $log_dir
   log_file="$log_dir/${RUN_UNIT:-}.`date "+%Y%m%d"`.log"
   echo " [$type_of_msg] `date "+%Y-%m-%d %H:%M:%S %Z"` [${RUN_UNIT:-}][@${host_name:-}] [$$] $msg " | \
      tee -a $log_file
}


do_check_install_min_req_bins(){
   which perl > /dev/null 2>&1 || {
      run_os_func install_bins perl
   }
   which jq > /dev/null 2>&1 || {
      run_os_func install_bins jq
   }
   which make > /dev/null 2>&1 || {
      # this will not work properly - google how-to install make on <<my-operating-system>>
      run_os_func install_bins make
   }
}


do_set_vars(){
   set -u -o pipefail
   do_read_cmd_args "$@"
   # test $? -eq "0" && export exit_code='0'
   export exit_code=1 # assume failure for each action, enforce return code usage
   export host_name="$(hostname -s)"
   unit_run_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
   export RUN_UNIT=$(cd $unit_run_dir/../../.. ; basename `pwd`)
   export PRODUCT_DIR=$(cd $unit_run_dir/../../.. ; echo `pwd`)
   ENV="${ENV:=lde}" # https://stackoverflow.com/a/2013589/65706
   valid_envs=("lde dev prd stg all")
   [[ " ${valid_envs[*]} " =~ " ${ENV} " ]] || {
      echo -e "ENV must be one of the following : \n export ENV={lde dev stg prd all}" && exit 1
   }

   cd $PRODUCT_DIR
   # workaround for github actions running on docker
   test -z ${GROUP:-} && export GROUP=$(id -gn)
   test -z ${GROUP:-} && export GROUP=$(ps -o group,supgrp $$|tail -n 1|awk '{print $1}')
   test -z ${USER:-} && export USER=$(id -un)
   test -z ${UID:-} && export UID=$(id -u)
   test -z ${GID:-} && export GID=$(id -g)
}


do_finalize(){

   # do_flush_screen

   cat << EOF_FIN_MSG
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
         $RUN_UNIT run completed
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
EOF_FIN_MSG
}


do_load_functions(){
    while read -r f; do source $f; done < <(ls -1 $PRODUCT_DIR/lib/bash/funcs/*.sh)
    while read -r f; do source $f; done < <(ls -1 $PRODUCT_DIR/src/bash/run/*.func.sh)
 }

run_os_func(){
   func_to_run=$1 ; shift ;

   if [ $(uname -s) == *"Linux"* ]; then
       distro=$(cat /etc/os-release|egrep '^ID='|cut -d= -f2)
       if [ $distro == "ubuntu" ] || [ $distro == "pop" ]; then
      "do_ubuntu_""$func_to_run" "$@"
       elif [ $distro == "alpine" ]; then
      "do_alpine_""$func_to_run" "$@"
       else
          echo "your Linux distro is not supported !!!"
       fi
   elif [ $(uname -s) == *"Linux"* ]; then
      echo "you are running on mac"
      "do_mac_""$func_to_run" "$@"
   fi

}


do_resolve_os(){
   if [ $(uname -s) == *"Linux"* ]; then
       distro=$(cat /etc/os-release|egrep '^ID='|cut -d= -f2)
       if [ $distro == "ubuntu" ] || [ $distro == "pop" ]; then
         export OS=ubuntu
       elif [ $distro == "alpine" ]; then
         export OS=alpine
       else
          echo "your Linux distro is not supported !!!"
       fi
   elif [ $(uname -s) == *"Darwin"* ]; then
         export OS=mac
   fi

}

main "$@"
