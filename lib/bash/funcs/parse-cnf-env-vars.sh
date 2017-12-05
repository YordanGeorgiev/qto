#
# ---------------------------------------------------------
# source this lib function by:
# source ./lib/bash/funcs/parse-cnf-env-vars.sh
# call by: doParseCnfEnvVars cnf/issue-tracker.dev.host-name.cnf
# verify by: 
# echo $issue_tracker_project 
# should echo:
# ysg-issues
# ---------------------------------------------------------
doParseCnfEnvVars(){

   cnf_file=$1;shift 1;
   test -z "$cnf_file" && echo " you should set the cnf_file !!!"
	
   INI_SECTION=MainSection

   ( set -o posix ; set ) | sort >~/vars.before
   settings=`sed -e 's/[[:space:]]*\=[[:space:]]*/=/g' \
      -e 's/#.*$//' \
      -e 's/[[:space:]]*$//' \
      -e 's/^[[:space:]]*//' \
      -e "s/^\(.*\)=\([^\"']*\)$/\1=\"\2\"/" \
      < $cnf_file \
      | sed -n -e "/^\[$INI_SECTION\]/,/^\s*\[/{/^[^#].*\=.*/p;}"`

   # export the var_name=var_value pairs
   # debug set -x
   while IFS=' ' read -d' ' s ; do eval 'export '$s ; done <<< $settings
   s=''

   # and post-register for nice logging
   ( set -o posix ; set ) | sort >~/vars.after

   echo "INFO added the following vars from section: [$INI_SECTION]"
   comm -3 ~/vars.before ~/vars.after | perl -ne 's#\s+##g;print "\n $_ "'

}
