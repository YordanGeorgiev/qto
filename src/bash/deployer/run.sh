#!/usr/bin/env bash

main(){
   do_initial_message
   do_set_vars "$@"
      
   installation_steps=(usage
   do_check_sudo_rights
   do_set_time
   do_load_functions
   do_check_setup_bash
   do_check_install_ubuntu_packages
   do_check_install_postgres
   do_check_install_chromium_headless
   do_check_install_phantom_js
   do_check_install_perl_modules
   do_check_install_python_modules
   do_check_install_redis
   do_provision_postgres   
   do_add_nginx_repositories
   do_provision_nginx
   do_add_dns
   do_provision_ssh_keys
   do_copy_git_hooks
   do_set_chmods
   do_create_multi_env_dir
   do_finalize)

   counter=0;
   for i in ${!installation_steps[*]}
   do
	  ((counter+=1))
	  set +x
      printf "$counter/${#installation_steps[*]} ${installation_steps[$i]}\n";
      ${installation_steps[$i]}
   done
}


do_initial_message(){
   printf "\n:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::\n     QTO installation has started.\n     You can abort it at any time using Ctrl+C.\n\n     After the installation please go to the QTO folder and run this command to continue with the database creation:\n\n     ./src/bash/qto/qto.sh -a provision-db-admin -a run-qto-db-ddl -a load-db-data-from-s3\n:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::\n"
}


do_set_vars(){
   set -eu -o pipefail
   printf "\nEntering verbose mode to display all technical messages.\n"
   set +e
   set -x
   export app_to_deploy=${1:-qto}
   maybe_echo=${2:-} || ''
   export host_name="$(hostname -s)"
   export bash_opts_file=~/.bash_opts.$host_name
   export user_at_host=$USER@$host_name || exit 1
   export unit_run_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
   
   # check on where the installation was started from
   # if started via opt/qto/src/bash/deployer/run.sh, then go 3 directory levels up
   # otherwise assume that op/setup.sh was used and go to opt/qto
   if [ ! "$unit_run_dir" == *"deployer"* ] ;
   then
      export product_dir=$(cd $unit_run_dir/$app_to_deploy; echo `pwd`)
   else 
      export product_dir=$(cd $unit_run_dir/../../..; echo `pwd`)
   fi

   # ALWAYS !!! bootstrap a dev instance, for tst and prd use -a to-env=tst , -a to-env=prd 
   perl -pi -e 's|ENV_TYPE=tst|ENV_TYPE=dev|g' "$product_dir/.env"
   perl -pi -e 's|ENV_TYPE=prd|ENV_TYPE=dev|g' "$product_dir/.env"
   source "$product_dir/.env"
   export product_instance_dir="$product_dir/$app_to_deploy.$VERSION.$ENV_TYPE.$user_at_host"

   # creating a redirect file with QtoDir function leading to product_instance_dir
   printf "#!/usr/bin/env bash\nmain(){\nQtoDir\n}\nQtoDir(){\ncd $product_instance_dir\n}\nmain\n" > $product_dir/src/bash/deployer/change-to-instance-dir.sh
   
   cd $product_dir
}


usage(){
   # if run with the --help flag, then display the message and exit, otherwise this module is skipped
   if [ $app_to_deploy == '--help' ] ;
   then
      cat << EOF_USAGE
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      $app_to_deploy deployer PURPOSE: 
      A generic deployer for OS packages, Perl modules and custom vim, tmux
      settings
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
     
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      $app_to_deploy deployer USAGE:
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      # just the deploy the qto packages
      # ./src/bash/deployer/run.sh
	  . ./$app_to_deploy/setup.sh
      Note: when run for the first time the required modules for the testing
      will be installed for the current OS user - and that will take 
      at least 10 minutes
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
EOF_USAGE
      do_exit 0 'usage displayed'
   fi
}


do_check_sudo_rights(){
   printf "\nChecking sudo rights.\n\n"
   msg='is not allowed to run sudo'
   test $(sudo -l -U $USER 2>&1 | grep -c "$msg") -eq 1 && echo "$USER $msg !!!" && exit 1
}


do_set_time(){
   printf "\nSynchronising time.\n\n"
   set -x
   sudo ntpdate 'pool.ntp.org'  # ensure the box has the correct time 
   sudo apt-get install ntp -y
   sudo timedatectl set-ntp on
   sudo service ntp stop
   # sudo ntpdate -s time.nist.gov
   sudo service ntp start
}


do_add_dns(){
	if [ ! "grep -q 'nameserver 8.8.8.8' /etc/resolv.conf"] ;  # skip adding, if resolve.conf already contains 8.8.8.8
	then
		printf "\nAdding DNS to /etc/resolv.conf\n\n"
		set -x
		sudo bash -c 'cat >> /etc/resolv.conf << EOF_ADD_DNS
nameserver 10.1.2.1
nameserver 10.1.2.2
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF_ADD_DNS'
	fi
}


do_add_nginx_repositories(){
	if [ ! "grep -q nginx /etc/apt/sources.list" ] ;	 # check to avoid adding lines multiple times, if this record already exists
	then
		printf "\nAdding nginx repositories to install the latest nginx version.\n\n"
		set -x
		sudo bash -c 'cat >> /etc/apt/sources.list << EOF_NGINX_REPOS
# nginx repos
deb https://nginx.org/packages/ubuntu/ bionic nginx
deb-src https://nginx.org/packages/ubuntu/ bionic nginx
EOF_NGINX_REPOS'
		wget http://nginx.org/keys/nginx_signing.key
		sudo apt-key add nginx_signing.key
		sudo apt-get update
	fi
}


do_load_functions(){
   printf "\nLoading scripts to install Postgres, Perl, PhantomJS, Chromium, Python, Redis, nginx, etc.\n\n"
   set -x
   source $product_dir/src/bash/deployer/export-json-section-vars.func.sh
   source $product_dir/src/bash/deployer/check-setup-bash.func.sh
   source $product_dir/src/bash/deployer/check-install-ubuntu-packages.func.sh
   source $product_dir/src/bash/deployer/check-install-postgres.func.sh
   source $product_dir/src/bash/deployer/check-install-phantom-js.func.sh
   source $product_dir/src/bash/deployer/check-install-perl-modules.func.sh
   source $product_dir/src/bash/deployer/check-install-chromium-headless.func.sh
   source $product_dir/src/bash/deployer/check-install-python-modules.func.sh
   source $product_dir/src/bash/deployer/check-install-redis.func.sh
   source $product_dir/src/bash/deployer/provision-postgres.func.sh
   source $product_dir/src/bash/deployer/provision-nginx.func.sh
   source $product_dir/src/bash/deployer/provision-ssh-keys.func.sh
   source $product_dir/src/bash/deployer/scramble-confs.func.sh
   source $product_dir/src/bash/deployer/change-to-instance-dir.sh
}


do_copy_git_hooks(){
	cp -v $unit_run_dir/../../../cnf/git/hooks/* $unit_run_dir/../../../.git/hooks/
}


do_set_chmods(){
   find $product_dir -type f -name '*.sh' -exec chmod 770 {} \;
}


do_create_multi_env_dir(){
   printf "\nCreating the $app_to_deploy.$ENV_TYPE directory:\n$product_instance_dir/\n\n"
   set -x
   
   test -d "$product_instance_dir" && \
      mv -v "$product_instance_dir" "$product_instance_dir"."$(date +%Y%m%d_%H%M%S)"

   mv -v "$product_dir" "$product_dir"'_'
   mkdir -p "$product_dir" ;  mv -v "$product_dir"'_' "$product_instance_dir"; 
}


do_finalize(){
   set +x
   touch $product_instance_dir/bootstraping # tell the backup db automate to not trigger yet
   
   # ln -s /home/$USER/opt/qto/qto.$VERSION.$ENV_TYPE.$USER@`hostname -s` link_to_qto

   export -f QtoDir
   
   printf "\033[2J";printf "\033[0;0H";
   printf "\n\n:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::\n\n"   
   printf "$app_to_deploy deployment completed successfully.\n\nPlease continue database creation by running these commands one by one: \n\n"
   printf "bash ;\n./src/bash/qto/qto.sh -a provision-db-admin -a run-qto-db-ddl -a load-db-data-from-s3\n\n"   
   printf "\n:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::\n"
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
   [[ -t 1 ]] && echo " [$type_of_msg] `date "+%Y-%m-%d %H:%M:%S %Z"` [$app_to_deploy][@$host_name] [$$] $msg "
   log_dir="$product_dir/dat/log/bash" ; mkdir -p $log_dir && log_file="$log_dir/$app_to_deploy.`date "+%Y%m"`.log"
   printf " [$type_of_msg] `date "+%Y-%m-%d %H:%M:%S %Z"` [$app_to_deploy][@$host_name] [$$] $msg " >> $log_file
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
      do_log "FATAL STOP FOR $app_to_deploy deployer RUN with: "
      do_log "FATAL exit_code: $exit_code exit_msg: $exit_msg"
   else
      do_log "INFO STOP FOR $app_to_deploy deployer RUN with: "
      do_log "INFO STOP FOR $app_to_deploy deployer RUN: $exit_code $exit_msg"
   fi

   exit $exit_code
}


main "$@"