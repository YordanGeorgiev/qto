#! /usr/bin/env bash

set -x
main(){
   do_set_vars "$@"
	if [[ $APP_TO_DEPLOY == '--help' ]]; then
		usage
	fi
	do_vagrant_up
   do_finalize
}


usage(){

	cat << EOF_USAGE
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      $APP_TO_DEPLOY deploy-vagrant-vm PURPOSE: 
	to setup the needed binary configuration for the qto project
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
     
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      $APP_TO_DEPLOY deploy-vagrant-vm USAGE:
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

      # just the deploy the qto packages
      ./src/bash/deploy-vagrant-vm.sh

   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


EOF_USAGE
	do_exit 0 'usage displayed'
}


do_vagrant_up(){

   # kill all the hanging VBoxHeadless
   #while read -r pid ; do kill -9 $pid ; done < <(sudo ps -ef | grep -i vbox | grep -i qto_$ENV_TYPE | awk '{print $2}')

	# because idempotence in binary configuration !!!
	test -d $PRODUCT_DIR/.vagrant && sudo rm -r $PRODUCT_DIR/.vagrant

	# keep the root dir of the project clean	
   cp -v $PRODUCT_DIR/cnf/tpl/vagrant/Vagrantfile $vagrant_file
   source $PRODUCT_DIR/lib/bash/funcs/export-json-section-vars.sh

   for env in `echo dev tst prd`; do 
      do_export_json_section_vars $PRODUCT_DIR/cnf/env/$env.env.json '.env.app'
      if [[ $env == 'dev' ]]; then
         perl -pi -e 's/\%dev_mojo_morbo_port\%/'$mojo_morbo_port'/g' "$vagrant_file"
         perl -pi -e 's/\%dev_mojo_hypnotoad_port\%/'$mojo_hypnotoad_port'/g' "$vagrant_file"
      fi
      if [[ $env == 'tst' ]]; then
         perl -pi -e 's/\%tst_mojo_morbo_port\%/'$mojo_morbo_port'/g' "$vagrant_file"
         perl -pi -e 's/\%tst_mojo_hypnotoad_port\%/'$mojo_hypnotoad_port'/g' "$vagrant_file"
      fi
      if [[ $env == 'prd' ]]; then
         perl -pi -e 's/\%prd_mojo_morbo_port\%/'$mojo_morbo_port'/g' "$vagrant_file"
         perl -pi -e 's/\%prd_mojo_hypnotoad_port\%/'$mojo_hypnotoad_port'/g' "$vagrant_file"
      fi
   done
	
   # get the vars to interpolate from the .env and the deploy dir
	perl -pi -e 's|\%PRODUCT_BASE_DIR\%|'"$PRODUCT_BASE_DIR"'|g' "$vagrant_file"
	perl -pi -e 's|\%PRODUCT_DIR\%|'"$PRODUCT_DIR"'|g' "$vagrant_file"
	perl -pi -e 's|\%ENV_TYPE\%|'"$ENV_TYPE"'|g' "$vagrant_file"
      
   # Action !!!
	vagrant up
}


do_set_vars(){
   set -eu -o pipefail 
   set +e
   printf "\033[2J";printf "\033[0;0H"
   export APP_TO_DEPLOY=${1:-qto}
   app_owner=$USER || exit 1
   unit_run_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
   export PRODUCT_BASE_DIR=$(cd $unit_run_dir/../../..; echo `pwd`)
   export PRODUCT_DIR=$(cd $unit_run_dir/../..; echo `pwd`)
   source "$PRODUCT_DIR/.env"
   product_base_dir=$(cd $unit_run_dir/../../..; echo `pwd`)
   product_dir=$(cd $unit_run_dir/../..; echo `pwd`)
   source "$PRODUCT_DIR/.env"
   PRODUCT_INSTANCE_DIR="$product_dir/$APP_TO_DEPLOY.$VERSION.$ENV_TYPE.$app_owner"
   bash_opts_file=~/.bash_opts.$(hostname -s)
   host_name="$(hostname -s)"
   vagrant_file=$PRODUCT_DIR/Vagrantfile
   cd $PRODUCT_DIR
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

   test -f $vagrant_file && rm -v $vagrant_file
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
		to remove completely the vagrant box do:
		vagrant halt
		vagrant reload

EOF_END
}


main "$@"
