#!/bin/bash

usage(){
   echo provide the PROJ_CONF_FILE as the first cmd arg - \$1
   echo source $0 ~/opt/csitea/csitea.0.8.2.prd.ubuntu@csitea.net/cnf/env/prd.env.json
}

do_set_vars(){
   set -eu -o pipefail
   shopt -s expand_aliases #src: http://chiefsandendians.blogspot.com/2010/07/linux-scripts-and-alias.html
   unit_run_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
   export PRODUCT_DIR=$(cd $unit_run_dir; echo `pwd`)
   cd $PRODUCT_DIR
}

main(){
   do_set_vars
   test -z ${1:-} && usage
   test -z ${1:-} || {
      export PROJ_CONF_FILE=$1
      export PROJ_INSTANCE_DIR=$(cd `dirname $PROJ_CONF_FILE`/../..; echo `pwd`)
      source $PRODUCT_DIR/lib/bash/funcs/export-json-section-vars.sh
      do_export_json_section_vars $PROJ_CONF_FILE '.env.db'; printf "\033[2J";printf "\033[0;0H"
      sleep 1
      alias psql="PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -t -X -w -U ${postgres_db_useradmin:-} --port $postgres_db_port --host $postgres_db_host"
      alias|sort ; sleep 1 ; printf "\033[2J";printf "\033[0;0H"
   }
}

main "$@" #Action !!!
