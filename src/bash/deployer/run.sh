#! /usr/bin/env bash


main(){
   do_set_vars "$@"
	if [[ $app_to_deploy == '--help' ]]; then
		usage
	fi
   do_check_setup_bash
   do_setup_vim
   do_check_install_ubuntu_packages
   do_check_install_postgres
    do_provision_postgres
   do_check_install_phantom_js
   do_check_install_perl_modules
   do_check_install_chromium_headless
   do_copy_git_hooks
   do_setup_tmux
   do_set_chmods
   do_create_multi_env_dir
   do_finalize
}

do_set_vars(){
   set -eu -o pipefail 
   app_to_deploy=${1:-} || 'qto'
   maybe_echo=${2:-} || ''
   app_name_owner=$USER || exit 1
   unit_run_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
   product_base_dir=$(cd $unit_run_dir/../../../..; echo `pwd`)
   product_dir=$(cd $unit_run_dir/../../..; echo `pwd`)
   product_instance_dir=$(cd $unit_run_dir/../../..; echo `pwd`)
   app_name=$(basename $product_dir|cut -d'.' -f1)
   app_to_deploy=$(basename $product_dir|cut -d'.' -f1)
   source "$unit_run_dir/../../../.env"
   PRODUCT_INSTANCE_DIR="$product_dir/$app_name.$VERSION.$ENV_TYPE.$app_name_owner"
   bash_opts_file=~/.bash_opts.$(hostname -s)
   host_name="$(hostname -s)"
   cd $product_instance_dir
}

do_check_setup_bash(){
   cp -v $product_instance_dir/cnf/bash/.profile_opts.host-name ~/.profile_opts.$host_name
   cp -v $product_instance_dir/cnf/bash/.bash_opts.host-name $bash_opts_file
   echo "source $bash_opts_file" >> ~/.bashrc
}

do_setup_vim(){
	cp -v $unit_run_dir/../../../.vimrc ~/.vimrc
}

do_copy_git_hooks(){
	cp -v $unit_run_dir/../../../cnf/git/hooks/* $unit_run_dir/../../../.git/hooks/
}

do_set_chmods(){
   find $product_instance_dir -type f -name '*.sh' -exec chmod 770 {} \;
}

usage(){

	cat << EOF_USAGE
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      $app_name deployer PURPOSE: 
      a generic deployer for os packages, perl modules and custom vim,tmux
      settings
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
     
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      $app_name deployer USAGE:
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

      # just the deploy the qto packages
      ./src/bash/deployer/run.sh

      # deploy actually another tool
      ./src/bash/deployer/run.sh another-tool

      # do not actually install but only print what will be installed
      ./src/bash/deployer/run.sh qto echo

      Note: when run for first time the required modules for the testing
      will be installed for the current OS user - and that WILL take 
		at least 10 minutes

   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


EOF_USAGE
	do_exit 0 'usage displayed'
}


# qto-190911215406 - minio , mc
do_check_install_ubuntu_packages(){
   
   packages_list_file="src/bash/deployer/$app_to_deploy/cnf/bin/ubuntu-18.04.lst"
   err_msg="the packages list file: $packages_list_file does not exist !"
   test -f $packages_list_file || do_exit 1 "$err_msg"
   packages="$(cat $packages_list_file)"

   sudo apt-get update      
	# sudo apt-get upgrade # probably not a good idea, but if yes ... this is the place ...
   while read -r package ; do 
      test "$(sudo dpkg -s $package | grep Status)" == "Status: install ok installed" || {
         $maybe_echo sudo apt-get install -y $package 
      }
   done < <(echo "$packages");
      
}

do_check_install_postgres(){
	which psql 2>/dev/null || {
		sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
		wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -
		sudo apt-get update
		sudo apt-get install -y postgresql postgresql-contrib libpq-dev pgadmin3
	}

	which psql 2>/dev/null || {
		echo "FATAL failed to install postgres !!!" ; exit 1
	}
	echo "check the postgres version:"
	sudo -u postgres psql postgres -c "SELECT version();" | grep PostgreSQL

   ## ensure the postresql starts on boot 
   sudo update-rc.d postgresql enable

}

do_check_install_phantom_js(){
   which phantomjs 2>/dev/null || { 
      sudo apt-get install -y build-essential chrpath libssl-dev libxft-dev
      sudo apt-get install -y libfreetype6 libfreetype6-dev
      sudo apt-get install -y libfontconfig1 libfontconfig1-dev
      export PHANTOM_JS="phantomjs-2.1.1-linux-x86_64"
      wget -O /tmp/$PHANTOM_JS.tar.bz2 https://github.com/Medium/phantomjs/releases/download/v2.1.1/$PHANTOM_JS.tar.bz2
      cd /tmp/
      sudo tar xvjf $PHANTOM_JS.tar.bz2
      sudo mv $PHANTOM_JS /usr/local/share
      sudo ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin
      phantomjs --version
   }
}

do_check_install_chromium_headless(){
   which chromium-browser 2>/dev/null || {
      sudo apt-get update
      sudo apt-get install -y software-properties-common
      sudo apt-get install -y chromium-browser 
      sudo apt-get update
   }
}

do_check_install_perl_modules(){
   cd $product_instance_dir
   modules="$(cat src/bash/deployer/qto/cnf/bin/perl-modules.lst)"
  
   while read -r module ; do
      use_modules="${use_modules:-} use $module ; "
   done < <(echo "$modules");

   perl -e "$use_modules" || {
      echo "deploying modules. This WILL take couple of min, but ONLY ONCE !!!"
      curl -L http://cpanmin.us | sudo perl - --self-upgrade -l ~/perl5 App::cpanminus \
         && sudo chown -R $USER:$(id -gn) ~/.cpanm && sudo chown -R $USER:$(id -gn) ~/perl5
      ~/perl5/bin/cpanm --local-lib=~/perl5 local::lib && eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)
      curl -L cpanmin.us | perl - Mojolicious
      test "$(grep -c 'Mlocal::lib' $bash_opts_file)" -eq 0 && \
         echo 'eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)' >> $bash_opts_file
		while read -r module ; do cpanm_modules="${cpanm_modules:-} $module " ; done < <(echo "$modules")
		cpanm --force --local-lib=~/perl5 'Net::Google::DataAPI' # does not install otherwise !!!
		cmd="cpanm --local-lib=~/perl5 $modules"
      $cmd

		# nasty workaround for the "Moo complainings" in the Net::Google::DataAPI::Oauth2 module
		find ~ -type f -name OAuth2.pm -exec perl -pi -e \
			"s/use Any::Moose;/no warnings 'deprecated'; use Any::Moose; use warnings 'deprecated';/g" {} \;
		}
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
      do_log "FATAL STOP FOR $app_to_deploy deployer RUN with: "
      do_log "FATAL exit_code: $exit_code exit_msg: $exit_msg"
   else
      do_log "INFO  STOP FOR $app_to_deploy deployer RUN with: "
      do_log "INFO  STOP FOR $app_to_deploy deployer RUN: $exit_code $exit_msg"
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
   [[ -t 1 ]] && echo " [$type_of_msg] `date "+%Y-%m-%d %H:%M:%S %Z"` [$app_name][@$host_name] [$$] $msg "
   log_dir="$product_dir/dat/log/bash" ; mkdir -p $log_dir && log_file="$log_dir/$app_name.`date "+%Y%m"`.log"
   echo " [$type_of_msg] `date "+%Y-%m-%d %H:%M:%S %Z"` [$app_name][@$host_name] [$$] $msg " >> $log_file
}


do_provision_postgres(){

   source $product_instance_dir/src/bash/qto/funcs/scramble-confs.func.sh
   doScrambleConfs
   source $product_instance_dir/lib/bash/funcs/export-json-section-vars.sh
   doExportJsonSectionVars $product_instance_dir/cnf/env/$ENV_TYPE.env.json '.env.db'

   sudo mkdir -p /etc/postgresql/11/main/
   sudo mkdir -p /var/lib/postgresql/11/main

   # echo "postgres:postgres" | chpasswd  # probably not needed ...
   echo 'export PS1="`date "+%F %T"` \u@\h  \w \\n\\n  "' | sudo tee -a /var/lib/postgresql/.bashrc
   
   sudo /etc/init.d/postgresql restart
   sudo -u postgres psql -c "
	DO \$\$DECLARE r record;
		BEGIN
			IF NOT EXISTS (
				SELECT 
				FROM   pg_catalog.pg_roles
				WHERE  rolname = '"$postgres_db_useradmin"') THEN
					CREATE ROLE "$postgres_db_useradmin" WITH SUPERUSER CREATEROLE 
               CREATEDB REPLICATION BYPASSRLS PASSWORD '"$postgres_db_useradmin_pw"' LOGIN ;
			END IF;
		END\$\$;
	ALTER ROLE "$postgres_db_useradmin" WITH SUPERUSER CREATEROLE 
   CREATEDB REPLICATION BYPASSRLS PASSWORD  '"$postgres_db_useradmin_pw"' LOGIN ; 
"
   
   sudo -u postgres psql -c "grant all privileges on database postgres to "$postgres_db_useradmin" ;"
   sudo -u postgres psql template1 -c 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp";'
   sudo -u postgres psql template1 -c 'CREATE EXTENSION IF NOT EXISTS "pgcrypto";'
   sudo -u postgres psql template1 -c 'CREATE EXTENSION IF NOT EXISTS "dblink";' 

   psql_cnf_dir='/etc/postgresql/11/main'
   test -f $psql_cnf_dir/pg_hba.conf && \
      sudo cp -v $psql_cnf_dir/pg_hba.conf $psql_cnf_dir/pg_hba.conf.orig.bak && \
      sudo cp -v $product_instance_dir/cnf/postgres/$psql_cnf_dir/pg_hba.conf $psql_cnf_dir/pg_hba.conf && \
      sudo chown postgres:postgres $psql_cnf_dir

   test -f $psql_cnf_dir/postgresql.conf && \
      sudo cp -v $psql_cnf_dir/postgresql.conf $psql_cnf_dir/postgresql.conf.orig && \
      sudo cp -v $product_instance_dir/cnf/postgres/$psql_cnf_dir/postgresql.conf $psql_cnf_dir/postgresql.conf

   sudo chown -R postgres:postgres "/etc/postgresql" && \
      sudo chown -R postgres:postgres "/var/lib/postgresql" && \
      sudo chown -R postgres:postgres "/etc/postgresql/11/main/pg_hba.conf" && \
      sudo chown -R postgres:postgres "/etc/postgresql/11/main/postgresql.conf"

   sudo /etc/init.d/postgresql restart
}

do_create_multi_env_dir(){
   test -d "$PRODUCT_INSTANCE_DIR" && \
      mv -v "$PRODUCT_INSTANCE_DIR" "$PRODUCT_INSTANCE_DIR"."$(date '+%Y%m%d_%H%M%S')"

   mv -v "$product_dir" "$product_dir"'_'
   mkdir -p "$product_dir" ;  mv -v "$product_dir"'_' "$PRODUCT_INSTANCE_DIR"; 
}


# later on multiser support ...
do_setup_tmux(){
   test -f ~/.tmux.conf && cp -v  ~/.tmux.conf ~/.tmux.conf.orig
   cp -v $product_dir/cnf/hosts/host-name/home/ysg/.tmux.conf ~/
   mkdir -p ~/.tmux/plugins
   test -d ~/.tmux/plugins/tpm || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   test -d ~/.tmux/plugins/tmux-copycat || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tmux-copycat
}

do_create_multi_env_dir(){
   test -d "$PRODUCT_INSTANCE_DIR" && \
      mv -v "$PRODUCT_INSTANCE_DIR" "$PRODUCT_INSTANCE_DIR"."$(date '+%Y%m%d_%H%M%S')"

   mv -v "$product_dir" "$product_dir"'_'
   mkdir -p "$product_dir" ;  mv -v "$product_dir"'_' "$PRODUCT_INSTANCE_DIR"; 
}

do_finalize(){

   mkdir -p $unit_run_dir/../../../dat/tmp/ ; touch $unit_run_dir/../../../dat/tmp/bootstrapping
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

