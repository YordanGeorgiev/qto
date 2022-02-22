#!/bin/bash
# ---------------------------------------------------------
# cat cnf/qto.dev.host-name.cnf
# [MainSection]
# postgres_db_name     = dev_qto
# postgres_db_host     = host-name
#
# call by:
# source lib/bash/funcs/parse-ini-section-vars.func.sh ; do_parse_ini_section_vars $AWS_SHARED_CREDENTIALS_FILE "profile $AWS_PROFILE"
# ---------------------------------------------------------
do_parse_ini_section_vars(){

   cnf_file=$1;shift 1;
   INI_SECTION=$1;shift 1;

   test -z "$cnf_file" && echo " you should set the cnf_file !!!"

   ( set -o posix ; set ) | sort >~/vars.before

   eval `sed -e 's/[[:space:]]*\=[[:space:]]*/=/g' \
      -e 's/#.*$//' \
      -e 's/[[:space:]]*$//' \
      -e 's/^[[:space:]]*//' \
      -e "s/^\(.*\)=\([^\"']*\)$/export \1=\"\2\"/" \
      < $cnf_file \
      | sed -n -e "/^\[$INI_SECTION\]/,/^\s*\[/{/^[^#].*\=.*/p;}"`

   # and post-register for nice logging
   ( set -o posix ; set ) | sort >~/vars.after


   echo "INFO added the following vars from section: [$INI_SECTION]"
   comm -3 ~/vars.before ~/vars.after | perl -ne 's#\s+##g;print "\n $_ "'
}
