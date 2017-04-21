#
# ---------------------------------------------------------
# source this lib function by:
# source lib/bash/funcs/parse-cnf-env-vars.sh
# call by: doParseCnfEnvVars cnf/ysg-issues.prd.doc-pub-host.cnf
# verify by: 
# echo $issue_tracker_project 
# should echo:
# ysg-issues
# ---------------------------------------------------------
doParseCnfEnvVars(){

   cnf_file=$1;shift 1;
   test -z "$cnf_file" && echo " you should set the cnf_file !!!"
	
   INI_SECTION=MainSection

	eval `sed -e 's/[[:space:]]*\=[[:space:]]*/=/g' \
		-e 's/#.*$//' \
		-e 's/[[:space:]]*$//' \
		-e 's/^[[:space:]]*//' \
		-e "s/^\(.*\)=\([^\"']*\)$/export \1=\"\2\"/" \
		< $cnf_file \
		| sed -n -e "/^\[$INI_SECTION\]/,/^\s*\[/{/^[^#].*\=.*/p;}"`
}
