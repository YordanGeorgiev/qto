#
# ---------------------------------------------------------
# source this lib function by:
# source ./lib/bash/funcs/parse-cnf-env-vars.sh
# call by: doParseCnfEnvVars cnf/qto.dev.ip-172-31-18-13.cnf
# verify by: 
# echo $qto_project 
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
   while IFS=' ' read -d' ' setting ; do eval 'export '$setting ; done <<< $settins

   # and post-register for nice logging
   ( set -o posix ; set ) | sort >~/vars.after

   echo "INFO added the following vars from section: [$INI_SECTION]"
   comm -3 ~/vars.before ~/vars.after | perl -ne 's#\s+##g;print "\n $_ "'

}

#
# ---------------------------------------------------------
# call by: doParseIniEnvVars sfw/sh/isg-pub/isg-pub.mini-nz.ysg-ip-172-31-18-13.conf
#; file: mini-nz.sh.hostname.conf docs at the end
#[MainSection]
#; the name of the project
#project=mini-nz
#;
#; the alias of the project - used for the logical html link and the db names
#; eof file: mini-nz.sh.hostname.conf
#proj_alias=mini_nz
# ---------------------------------------------------------
doParseIniEnvVars(){
   ini_file=$1;shift 1;
   #debug ok   echo ini_file:: $ini_file
   #debug ok   sleep 2
   test -z "$ini_file" && ini_file="$component_dir/$component_name.$host_name.conf"
   test -f "$ini_file" || \
      cp -v $component_dir/$component_name.host_name.conf \
            $component_dir/$component_name.$host_name.conf
   eval `sed -e 's/[[:space:]]*\=[[:space:]]*/=/g' \
      -e 's/;.*$//' \
      -e 's/[[:space:]]*$//' \
      -e 's/^[[:space:]]*//' \
      -e "s/^\(.*\)=\([^\"']*\)$/export \1=\"\2\"/" \
      < $ini_file \
      | sed -n -e "/^\[MainSection\]/,/^\s*\[/{/^[^;].*\=.*/p;}"`
}
#eof func doParseIniEnvVars
