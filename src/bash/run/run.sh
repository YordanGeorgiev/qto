#!/usr/bin/env bash

main(){

   do_set_vars "$@"  # is inside, unless --help flag is present
   
   deploy_step_funcs=(
      do_load_functions
#      do_chk_sudo_rights
#      do_chk_setup_bash
#      do_chk_install_os_packages
#      do_chk_install_postgres
#      do_chk_install_perl_modules
#      do_chk_install_python_modules
#     do_chk_install_redis
      do_scramble_confs
#     do_chk_provision_postgres   
#      do_chk_provision_db_users
#      do_create_app_db
#      do_run_ddls
#      do_create_app_user
#      do_configure_aws_keys
#      do_create_ssh_keys
#      do_chk_install_python_modules
#      do_chk_install_nginx
#      do_chk_provision_nginx
#      do_add_dns
#      do_change_file_permissions
#      do_sync_time
      # do_chk_install_terraform
      # do_chk_install_phantom_js
      do_finalize
   )

   counter=0;
   for i in ${!deploy_step_funcs[*]}
   do
	  ((counter+=1))
     run_step=`echo ${deploy_step_funcs[$i]}|cut -c 4-`
     do_log "INFO START $run_step"
     printf "$counter/${#deploy_step_funcs[*]} $run_step \n\n";
     ${deploy_step_funcs[$i]}
     do_log "INFO STOP $run_step"
     sleep 1 ; do_flush_screen
   done
}

do_flush_screen(){
   printf "\033[2J";printf "\033[0;0H"
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
   [[ -t 1 ]] && echo " [$type_of_msg] `date "+%Y-%m-%d %H:%M:%S %Z"` [$run_unit][@$host_name] [$$] $msg "
   log_dir="$PRODUCT_DIR/dat/log/bash" ; mkdir -p $log_dir && log_file="$log_dir/$run_unit.`date "+%Y%m"`.log"
   printf " [$type_of_msg] `date "+%Y-%m-%d %H:%M:%S %Z"` [$run_unit][@$host_name] [$$] $msg " >> $log_file
}


do_set_vars(){
   set -eu -o pipefail
   export run_unit=${1:-qto}
   maybe_echo=${2:-} || ''
   export host_name="$(hostname -s)"
   unit_run_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
   export PRODUCT_DIR=$(cd $unit_run_dir/../../../../..; echo `pwd`)
   bash_opts_file=~/.bash_opts.`hostname -s`
   cd $PRODUCT_DIR
}


usage_info(){
   # if $run_unit is --help, then message will be "--help deployer PURPOSE"
   cat << EOF_USAGE
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      qto deployer PURPOSE: 
      to create the qto backend base image from an Ubuntu 18.04 with 
      a single shell call by deploying and configuring : 
       - OS packages and utils
       - Perl and Python modules
       - NodeJS runtime and npm modules
       - Postgres db enginge
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
     
EOF_USAGE
   do_exit 0 'usage displayed'
}


do_chk_sudo_rights(){
   printf "\nChecking sudo rights.\n\n"
   msg='is not allowed to run sudo'
   test $(sudo -l -U $USER 2>&1 | grep -c "$msg") -eq 1 && echo "$USER $msg !!!" && exit 1
   printf "OK\n"
}


do_sync_time(){
   printf "\nSynchronising time.\n\n"
   # note ntpdate is deprecated : https://askubuntu.com/a/998449/251228
   sudo apt-get install -y ntp
   sudo timedatectl set-ntp on
   sudo service ntp restart
   sudo service ntp status | cat
}


do_add_dns(){
	if [[ ! "grep -q 'nameserver 8.8.8.8' /etc/resolv.conf" ]] ;  # skip adding, if resolve.conf already contains 8.8.8.8
	then
		printf "\nAdding DNS to /etc/resolv.conf\n\n"
		set -x
      cat << EOF_ADD_DNS | sudo tee -a /etc/resolv.conf > /dev/null
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF_ADD_DNS
	fi
}


do_load_functions(){
   while read -r f; do source $f; done < <(ls -1 $PRODUCT_DIR/lib/bash/funcs/*.sh)
   export -f do_flush_screen
   export -f do_export_json_section_vars
   while read -r f; do source $f; done < <(ls -1 $PRODUCT_DIR/src/bash/qto/deploy/single-ubuntu-18.04/*func.sh)
}




do_change_file_permissions(){
   find $PRODUCT_DIR -type f -name '*.sh' -exec chmod 770 {} \;
}


do_finalize(){
   set +x
   
   do_flush_screen
   
   cat << EOF_INIT_MSG
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
         qto binary deployment completed successfully. Continue by : 
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
EOF_INIT_MSG
}



# ------------------------------------------------------------------------------
# clean and exit with passed status and message
# call by:
# do_exit 0 "ok msg"
# do_exit 1 "NOK msg"
# ------------------------------------------------------------------------------
do_exit(){
   exit_code=$1 ; shift
   exit_msg="$*"

   if (( ${exit_code:-} != 0 ));
   then
      exit_msg=" ERROR --- exit_code $exit_code --- exit_msg : $exit_msg"
      >&2 printf "$exit_msg"
      do_log "FATAL STOP FOR $run_unit deployer RUN with: "
      do_log "FATAL exit_code: $exit_code exit_msg: $exit_msg"
   else
      do_log "INFO STOP FOR $run_unit deployer RUN with: "
      do_log "INFO STOP FOR $run_unit deployer RUN: $exit_code $exit_msg"
   fi

   exit $exit_code
}


main "$@"
