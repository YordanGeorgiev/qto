#! /usr/bin/env bash


do_create_multi_env_dir(){
   test -d "$PRODUCT_INSTANCE_DIR" && \
      mv -v "$PRODUCT_INSTANCE_DIR" "$PRODUCT_INSTANCE_DIR"."$(date '+%Y%m%d_%H%M%S')"

   mv -v "$product_dir" "$product_dir"'_'
   mkdir -p "$product_dir" ;  mv -v "$product_dir"'_' "$PRODUCT_INSTANCE_DIR"; 

   cp -v $PRODUCT_INSTANCE_DIR/cnf/git/hooks/* $PRODUCT_INSTANCE_DIR/.git/hooks/
   chmod 770 $PRODUCT_INSTANCE_DIR/.git/hooks/*

   echo "GO TO YOUR PRODUCT_INSTANCE_DIR by"
   echo "cd $PRODUCT_INSTANCE_DIR"
   cd $PRODUCT_INSTANCE_DIR
}




main(){
   do_set_vars "$@"
   do_check_install_prereqs
   do_create_multi_env_dir
}

do_set_vars(){
   set -eu -o pipefail 
   RUN_UNIT='qto'
   run_unit_owner=$USER || exit 1
   unit_run_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
   product_base_dir=$(cd $unit_run_dir/../../../..; echo `pwd`)
   product_dir="$product_base_dir/$RUN_UNIT" 
   product_tmp_install_dir="$product_base_dir"/""'-tmp-install'
   source "$product_dir/.env"
   PRODUCT_INSTANCE_DIR="$product_dir/$RUN_UNIT.$VERSION.$ENV_TYPE.$run_unit_owner"
}

usage(){

cat << EOF_DOC
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      $RUN_UNIT PURPOSE: 
      bootstrap the qto app
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
     
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      $RUN_UNIT USAGE:
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

      $0 

      example call
      clear ; bash $0 

      Note: when run for first time the required modules for the testing
      will be installed for the current OS user - and that WILL take 
		couple of minutes

   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


EOF_DOC
}

do_check_install_prereqs(){
      do_check_install_chromium_headless
      do_check_install_phantom_js
      do_check_install_perl_modules
      do_check_git_hooks
      cd $call_start_dir
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

   eval `perl -I ~/perl5/lib/perl5 -Mlocal::lib`
   local perl_modules=$(cat << EOF
      JSON  
      Data::Printer
      Test::Most 
      Data::Printer 
      FindBin
      JSON::Parse 
      IPC::System::Simple 
      Mojolicious 
      IO::Socket::SSL  
      Mojo::Phantom 
      URL::Encode
      ExtUtils::Installed
      Carp::Always
      Data::Printer
      File::Copy
      File::Find
      File::Path
      Excel::Writer::XLSX
      Spreadsheet::ParseExcel
      Spreadsheet::XLSX
      Spreadsheet::ParseExcel::FmtJapan
      Text::CSV_XS
      Module::Build::Tiny
      Carp::Always
      URL::Encode
      Carp::Always
      Data::Printer
      File::Copy::Recursive
      Spreadsheet::ParseExcel
      Spreadsheet::XLSX
      JSON
      Text::CSV_XS
      Test::Trap
      Test::More
      Test::Most
      DBD::Pg
      Tie::Hash::DBD
      Scalar::Util::Numeric
      IPC::System::Simple
      Time::HiRes
      Mojolicious::Plugin::BasicAuthPlus
      Mojolicious::Plugin::StaticCache
      Mojolicious::Plugin::RenderFile
      Mojolicious::Plugin::Authentication
      Mojo::JWT
      Mojo::Pg
      Test::Mojo
      Authen::Passphrase::BlowfishCrypt
      Selenium::Remote::Driver
      Selenium::Chrome
      Net::Google::DataAPI::Auth::OAuth2
      Net::Google::Spreadsheets::V4
      Net::Google::Spreadsheets
      Net::Google::DataAPI::Auth::OAuth2
      Net::Google::Spreadsheets::V4
      Net::Google::Spreadsheets
      Term::ReadKey
      Term::Prompt
      DBIx::ProcedureCall
      JSON::Parse
EOF
   
      
      while read -r module ; do perl -e modules="$modules; use $module ; " ; done ; 
      
         perl -e "$modules" || {
         echo "deploying modules. This WILL take couple of min, but ONLY ONCE !!!"
         curl -L http://cpanmin.us | perl - -l ~/perl5 App::cpanminus local::lib
         eval `perl -I ~/perl5/lib/perl5 -Mlocal::lib`
         echo 'eval `perl -I ~/perl5/lib/perl5 -Mlocal::lib`' >> ~/.bashrc
         cpanm --local-lib=~/perl5 local::lib && eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)
         export PERL_MM_USE_DEFAULT=1
         modules=""
         while read -r module ; do modules="$modules $module " ; done ; 
         cmd="cpanm $modules"
         $cmd
         sudo curl -L cpanmin.us | perl - Mojolicious
   }
}

do_check_git_hooks(){
   test $(grep -c 'run-functional-tests' $PRODUCT_INSTANCE_DIR/.git/hooks/pre-commit) -lt 1 && {
      echo "
         ./src/bash/qto/qto.sh -a run-functional-tests
      " >> $PRODUCT_INSTANCE_DIR/.git/hooks/pre-commit
   }
   test $(grep -c 'un-scramble-confs.sh' $PRODUCT_INSTANCE_DIR/.git/hooks/pre-commit) -lt 1 && {
      echo "
         $PRODUCT_INSTANCE_DIR/scripts/testing/ua-at-teser/un-scramble-confs.sh
      " >> $PRODUCT_INSTANCE_DIR/.git/hooks/pre-push
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
      do_log "FATAL STOP FOR $RUN_UNIT RUN with: "
      do_log "FATAL exit_code: $exit_code exit_msg: $exit_msg"
   else
      do_log "INFO  STOP FOR $RUN_UNIT RUN with: "
      do_log "INFO  STOP FOR $RUN_UNIT RUN: $exit_code $exit_msg"
   fi

   test $exit_code -eq 0 && exit 0
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
   test -t 1 && echo " [$type_of_msg] `date "+%Y.%m.%d-%H:%M:%S %Z"` [$RUN_UNIT][@$host_name] [$$] $msg "
}


main "$@"
# eof file src/bash/qto/bootstrap-qto.sh
