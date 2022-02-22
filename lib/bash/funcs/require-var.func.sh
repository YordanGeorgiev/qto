#!/bin/bash
#------------------------------------------------------------------------------
# usage example:
# source lib/bash/funcs/require-var.func.sh
# do_require_var ENV $ENV ; do_require_var ORG $ORG ;
#------------------------------------------------------------------------------
do_require_var(){

  var_name="${1:-}"
  var="${2:-}"

  do_simple_log(){
    type_of_msg=$(echo $*|cut -d" " -f1)
    msg="$(echo $*|cut -d" " -f2-)"
    echo " [$type_of_msg] `date "+%Y-%m-%d %H:%M:%S %Z"` [$$] $msg "
  }

  test -z "${var:-}" && {
    do_simple_log 'FATAL The environment variable "'$var_name'" does not have a value !!!'
    do_simple_log 'INFO In the calling shell do "export '$var_name'=your-'$var_name'-value"'
    exit 1
  }
}
