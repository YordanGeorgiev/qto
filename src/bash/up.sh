#! /usr/bin/env bash


main(){
   do_set_vars "$@"
	if [[ $APP_TO_DEPLOY == '--help' ]]; then
		usage
	fi
	do_run_vagrant_up
   do_finalize
}


usage(){

	cat << EOF_USAGE
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      $APP_TO_DEPLOY up.sh PURPOSE: 
	to setup the needed binary configuration for the qto project
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
     
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      $APP_TO_DEPLOY up.sh USAGE:
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

      # just the deploy the qto packages
      ./src/bash/up.sh

   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


EOF_USAGE
	do_exit 0 'usage displayed'
}


do_run_vagrant_up(){

   # kill all the hanging VBoxHeadless
   while read -r pid ; do kill -9 $pid ; done < <(sudo ps -ef | grep -i vbox | grep -i qto_dev | awk '{print $2}')

	# because idempotence in binary configuration !!!
	test -d $DEPLOY_DIR/.vagrant && sudo rm -r $DEPLOY_DIR/.vagrant

	# keep the root dir of the project clean	
   cp -v $DEPLOY_DIR/cnf/tpl/vagrant/Vagrantfile $DEPLOY_DIR/Vagrantfile
	
	# get the vars to interpolate from the .env and the deploy dir
	perl -pi -e 's|\%DEPLOY_DIR\%|'"$DEPLOY_DIR"'|g' "$DEPLOY_DIR/Vagrantfile"
	perl -pi -e 's|\%ENV_TYPE\%|'"$ENV_TYPE"'|g' "$DEPLOY_DIR/Vagrantfile"

   # Action !!!
	vagrant up
}


do_set_vars(){
   set -eu -o pipefail 
   set +e
   export APP_TO_DEPLOY=${1:-qto}
   app_owner=$USER || exit 1
   unit_run_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
   export DEPLOY_DIR=$(cd $unit_run_dir/../..; echo `pwd`)
   source "$DEPLOY_DIR/.env"
   product_base_dir=$(cd $unit_run_dir/../../..; echo `pwd`)
   product_dir=$(cd $unit_run_dir/../..; echo `pwd`)
   source "$DEPLOY_DIR/.env"
   PRODUCT_INSTANCE_DIR="$product_dir/$APP_TO_DEPLOY.$VERSION.$ENV_TYPE.$app_owner"
   bash_opts_file=~/.bash_opts.$(hostname -s)
   host_name="$(hostname -s)"
   cd $DEPLOY_DIR
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


do_finalize(){

   printf "\033[2J";printf "\033[0;0H"
	cat << EOF_END
			:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
			DONE
			:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		you can: now
		vagrant halt
		vagrant reload

EOF_END
}

main "$@"
