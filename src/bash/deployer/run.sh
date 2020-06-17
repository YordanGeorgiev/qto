#!/usr/bin/env bash

main(){
   do_initial_message
      
   installation_steps=(do_check_sudo_rights
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
	
   if [ $APP_TO_DEPLOY == '--help' ]
   then
      installation_steps+=("usage")
   fi

   counter=0;
   for i in ${!installation_steps[*]}
   do
	  ((counter+=1))
	  set +x
      printf "$counter/${#installation_steps[*]}) ${installation_steps[$i]}\n";
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
   export APP_TO_DEPLOY=${1:-qto}
   maybe_echo=${2:-} || ''
   export HOST_NAME="$(hostname -s)"
   export USER_AT_HOST=$USER@$HOST_NAME || exit 1
   export UNIT_RUN_DIR=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
   export PRODUCT_DIR=$(cd $UNIT_RUN_DIR/../../..; echo `pwd`)
   # ALWAYS !!! bootstrap a dev instance, for tst and prd use -a to-env=tst , -a to-env=prd 
   perl -pi -e 's|ENV_TYPE=tst|ENV_TYPE=dev|g' "$PRODUCT_DIR/.env"
   perl -pi -e 's|ENV_TYPE=prd|ENV_TYPE=dev|g' "$PRODUCT_DIR/.env"
   source "$PRODUCT_DIR/.env"
   export PRODUCT_INSTANCE_DIR="$PRODUCT_DIR/$APP_TO_DEPLOY.$VERSION.$ENV_TYPE.$USER_AT_HOST"
   printf "#!/usr/bin/env bash\nmain(){\nQtoDir\n}\nQtoDir(){\ncd $PRODUCT_INSTANCE_DIR\n}\nmain" > $PRODUCT_DIR/src/bash/deployer/change-to-instance-dir.sh
   BASH_OPTS_FILE=~/.bash_opts.$HOST_NAME
}


do_check_sudo_rights(){
   cd $PRODUCT_DIR
   printf "\nChecking sudo rights.\n"
   set -x
   
   # msg='is not allowed to run sudo'
   # test $(sudo -l -U $USER 2>&1 | grep "$msg") -eq 1 && echo "$USER $msg !!!" && exit 1
   sudo -l
}


do_set_time(){
   printf "\nSynchronising time.\n"
   set -x
   sudo ntpdate 'pool.ntp.org' # ensure the box has the correct time 
   sudo apt-get install ntp -y
   sudo timedatectl set-ntp on
   sudo service ntp stop
   # sudo ntpdate -s time.nist.gov
   sudo service ntp start
}


do_add_dns(){
	printf "\nAdding DNS to /etc/resolv.conf\n"
	set -x
	sudo bash -c 'cat >> /etc/resolv.conf << EOF_ADD_DNS
nameserver 10.1.2.1
nameserver 10.1.2.2
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF_ADD_DNS'
}


do_add_nginx_repositories(){
	printf "\nAdding nginx repositories to install the latest nginx version.\n"
	set -x
	sudo bash -c 'cat >> /etc/apt/sources.list << EOF_NGINX_REPOS
# nginx repos
deb https://nginx.org/packages/ubuntu/ bionic nginx
deb-src https://nginx.org/packages/ubuntu/ bionic nginx
EOF_NGINX_REPOS'
	wget http://nginx.org/keys/nginx_signing.key
	sudo apt-key add nginx_signing.key
	sudo apt-get update
}


usage(){

	cat << EOF_USAGE
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      $APP_TO_DEPLOY deployer PURPOSE: 
      a generic deployer for os packages, perl modules and custom vim,tmux
      settings
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
     
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      $APP_TO_DEPLOY deployer USAGE:
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      # just the deploy the qto packages
      ./src/bash/deployer/run.sh
      Note: when run for the first time the required modules for the testing
      will be installed for the current OS user - and that will take 
		at least 10 minutes
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
EOF_USAGE
	do_exit 0 'usage displayed'
}


do_load_functions(){
   printf "\nLoading scripts to install Postgres, Perl, PhantomJS, Chromium, Python, Redis, nginx.\n"
   set -x
   source $PRODUCT_DIR/src/bash/deployer/export-json-section-vars.func.sh
   source $PRODUCT_DIR/src/bash/deployer/check-setup-bash.func.sh
   source $PRODUCT_DIR/src/bash/deployer/check-install-ubuntu-packages.func.sh
   source $PRODUCT_DIR/src/bash/deployer/check-install-postgres.func.sh
   source $PRODUCT_DIR/src/bash/deployer/check-install-phantom-js.func.sh
   source $PRODUCT_DIR/src/bash/deployer/check-install-perl-modules.func.sh
   source $PRODUCT_DIR/src/bash/deployer/check-install-chromium-headless.func.sh
   source $PRODUCT_DIR/src/bash/deployer/check-install-python-modules.func.sh
   source $PRODUCT_DIR/src/bash/deployer/check-install-redis.func.sh
   source $PRODUCT_DIR/src/bash/deployer/provision-postgres.func.sh
   source $PRODUCT_DIR/src/bash/deployer/provision-nginx.func.sh
   source $PRODUCT_DIR/src/bash/deployer/provision-ssh-keys.func.sh
   source $PRODUCT_DIR/src/bash/deployer/scramble-confs.func.sh
}


do_copy_git_hooks(){
	cp -v $UNIT_RUN_DIR/../../../cnf/git/hooks/* $UNIT_RUN_DIR/../../../.git/hooks/
}


do_set_chmods(){
   find $PRODUCT_DIR -type f -name '*.sh' -exec chmod 770 {} \;
}


do_create_multi_env_dir(){
   printf "\nMoving the QTO directory.\n"
   set -x
   test -d "$PRODUCT_INSTANCE_DIR" && \
   mv -v "$PRODUCT_INSTANCE_DIR" "$PRODUCT_INSTANCE_DIR"."$(date '+%Y%m%d_%H%M%S')"

   mv -v "$PRODUCT_DIR" "$PRODUCT_DIR"'_'
   mkdir -p "$PRODUCT_DIR" ;  mv -v "$PRODUCT_DIR"'_' "$PRODUCT_INSTANCE_DIR"; 
}


do_finalize(){
   set +x
   touch $PRODUCT_INSTANCE_DIR/bootstraping # tell the backup db automate to not trigger yet
   printf "\033[2J";printf "\033[0;0H";
   printf "\n\n:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::\n"
   printf "Going to $APP_TO_DEPLOY directory:\n$PRODUCT_INSTANCE_DIR/\n\n"

   # ln -s /home/$USER/opt/qto/qto.$VERSION.$ENV_TYPE.$USER@`hostname -s` link_to_qto
   source $PRODUCT_INSTANCE_DIR/src/bash/deployer/change-to-instance-dir.sh
   
   printf "$APP_TO_DEPLOY deployment completed successfully.\n\nPlease continue database creation by running these commands one by one: \n\n"
   printf "bash ;\n./src/bash/qto/qto.sh -a provision-db-admin -a run-qto-db-ddl -a load-db-data-from-s3\n"
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
   [[ -t 1 ]] && echo " [$type_of_msg] `date "+%Y-%m-%d %H:%M:%S %Z"` [$APP_TO_DEPLOY][@$HOST_NAME] [$$] $msg "
   log_dir="$PRODUCT_DIR/dat/log/bash" ; mkdir -p $log_dir && log_file="$log_dir/$APP_TO_DEPLOY.`date "+%Y%m"`.log"
   printf " [$type_of_msg] `date "+%Y-%m-%d %H:%M:%S %Z"` [$APP_TO_DEPLOY][@$HOST_NAME] [$$] $msg " >> $log_file
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

   if (( ${exit_code:-} != 0 )); then
      exit_msg=" ERROR --- exit_code $exit_code --- exit_msg : $exit_msg"
      >&2 printf "$exit_msg"
      do_log "FATAL STOP FOR $APP_TO_DEPLOY deployer RUN with: "
      do_log "FATAL exit_code: $exit_code exit_msg: $exit_msg"
   else
      do_log "INFO STOP FOR $APP_TO_DEPLOY deployer RUN with: "
      do_log "INFO STOP FOR $APP_TO_DEPLOY deployer RUN: $exit_code $exit_msg"
   fi

   exit $exit_code
}


main "$@"