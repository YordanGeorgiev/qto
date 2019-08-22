#------------------------------------------------------------------------------
# usage example:
# doExportJsonSectionVars cnf/env/dev.env.json '.env.virtual.docker.spark_base'
#------------------------------------------------------------------------------
doExportJsonSectionVars(){

   json_file="$1"
   shift 1;
   test -f "$json_file" || exit 1 "the json_file: $json_file does not exist !!! Nothing to do"

   section="$1"
   test -z "$section" && exit 1 "the section in doExportJsonSectionVars is empty !!! nothing to do !!!"
   shift 1;

	printf "\033[2J";printf "\033[0;0H"

	echo "INFO exporting vars: "
   while read -r l ; do
     key=$(echo $l|cut -d'=' -f1)
     val=$(echo $l|cut -d'=' -f2)
     eval "$(echo -e 'export '$key=\"\"$val\"\")"
     echo "INFO $key=$val"
   done < <(cat "$json_file"| jq -r "$section"'|keys_unsorted[] as $key|"\($key)=\"\(.[$key])\""')
}
