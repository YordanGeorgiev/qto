#! /usr/bin/env bash


main(){
   do_set_vars "$@"
	if [[ $APP_TO_DEPLOY == '--help' ]]; then
		usage
	fi
   do_source_funtions
   do_check_setup_bash
   do_check_install_ubuntu_packages
   do_check_install_postgres
   do_check_install_chromium_headless
   do_check_install_phantom_js
   do_check_install_perl_modules
   do_check_install_python_modules
   do_provision_postgres
   do_provision_nginx
   do_copy_git_hooks
   do_set_chmods
   do_create_multi_env_dir
   do_finalize
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

      Note: when run for first time the required modules for the testing
      will be installed for the current OS user - and that WILL take 
		at least 10 minutes

   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


EOF_USAGE
	do_exit 0 'usage displayed'
}


do_source_funtions(){
   source $DEPLOY_DIR/src/bash/deployer/export-json-section-vars.func.sh
   source $DEPLOY_DIR/src/bash/deployer/check-setup-bash.func.sh
   source $DEPLOY_DIR/src/bash/deployer/check-install-ubuntu-packages.func.sh
   source $DEPLOY_DIR/src/bash/deployer/check-install-postgres.func.sh
   source $DEPLOY_DIR/src/bash/deployer/check-install-phantom-js.func.sh
   source $DEPLOY_DIR/src/bash/deployer/check-install-perl-modules.func.sh
   source $DEPLOY_DIR/src/bash/deployer/check-install-chromium-headless.func.sh
   source $DEPLOY_DIR/src/bash/deployer/provision-postgres.func.sh
   source $DEPLOY_DIR/src/bash/deployer/provision-nginx.func.sh
   source $DEPLOY_DIR/src/bash/deployer/scramble-confs.func.sh
}


do_set_vars(){
   set -eu -o pipefail 
   set +e
   export APP_TO_DEPLOY=${1:-qto}
   maybe_echo=${2:-} || ''
   app_owner=$USER || exit 1
   unit_run_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
   export DEPLOY_DIR=$(cd $unit_run_dir/../../..; echo `pwd`)
   source "$DEPLOY_DIR/.env"
   product_base_dir=$(cd $unit_run_dir/../../../..; echo `pwd`)
   product_dir=$(cd $unit_run_dir/../../..; echo `pwd`)
   # ALWAYS !!! bootstrap a dev instance, for tst and prd use -a to-env=tst , -a to-env=prd 
   perl -pi -e 's|ENV_TYPE=tst|ENV_TYPE=dev|g' "$DEPLOY_DIR/.env"
   perl -pi -e 's|ENV_TYPE=prd|ENV_TYPE=dev|g' "$DEPLOY_DIR/.env"
   source "$DEPLOY_DIR/.env"
   PRODUCT_INSTANCE_DIR="$product_dir/$APP_TO_DEPLOY.$VERSION.$ENV_TYPE.$app_owner"
   bash_opts_file=~/.bash_opts.$(hostname -s)
   host_name="$(hostname -s)"
   cd $DEPLOY_DIR
}


do_copy_git_hooks(){
	cp -v $unit_run_dir/../../../cnf/git/hooks/* $unit_run_dir/../../../.git/hooks/
}

do_set_chmods(){
   find $DEPLOY_DIR -type f -name '*.sh' -exec chmod 770 {} \;
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
      >&2 echo "$exit_msg"
      do_log "FATAL STOP FOR $APP_TO_DEPLOY deployer RUN with: "
      do_log "FATAL exit_code: $exit_code exit_msg: $exit_msg"
   else
      do_log "INFO  STOP FOR $APP_TO_DEPLOY deployer RUN with: "
      do_log "INFO  STOP FOR $APP_TO_DEPLOY deployer RUN: $exit_code $exit_msg"
   fi

   exit $exit_code
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
   [[ -t 1 ]] && echo " [$type_of_msg] `date "+%Y-%m-%d %H:%M:%S %Z"` [$APP_TO_DEPLOY][@$host_name] [$$] $msg "
   log_dir="$product_dir/dat/log/bash" ; mkdir -p $log_dir && log_file="$log_dir/$APP_TO_DEPLOY.`date "+%Y%m"`.log"
   echo " [$type_of_msg] `date "+%Y-%m-%d %H:%M:%S %Z"` [$APP_TO_DEPLOY][@$host_name] [$$] $msg " >> $log_file
}


do_create_multi_env_dir(){
   test -d "$PRODUCT_INSTANCE_DIR" && \
      mv -v "$PRODUCT_INSTANCE_DIR" "$PRODUCT_INSTANCE_DIR"."$(date '+%Y%m%d_%H%M%S')"

   mv -v "$product_dir" "$product_dir"'_'
   mkdir -p "$product_dir" ;  mv -v "$product_dir"'_' "$PRODUCT_INSTANCE_DIR"; 
}

do_finalize(){

   touch $PRODUCT_INSTANCE_DIR/bootstraping # tell the backup db automate to not trigger yet
   printf "\033[2J";printf "\033[0;0H"
   echo -e "\n\n"
   echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
   echo "DONE"
   echo -e "\n"
   echo "# go to your PRODUCT_INSTANCE_DIR by: "
   echo " cd $PRODUCT_INSTANCE_DIR"
   echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
}

main "$@"

