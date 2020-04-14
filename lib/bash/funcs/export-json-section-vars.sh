#------------------------------------------------------------------------------
# usage example:
# source lib/bash/funcs/export-json-section-vars.sh
# do_export_json_section_vars cnf/env/dev.env.json '.env.db'
# alias psql="PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -t -X -w -U \
#     ${postgres_db_useradmin:-} --port $postgres_db_port --host $postgres_db_host"
#------------------------------------------------------------------------------
do_export_json_section_vars(){

   json_file="$1"
   shift 1;
   test -f "$json_file" || echo "the json_file: $json_file does not exist !!! Nothing to do"
   test -f "$json_file" || return

   section="$1"
   test -z "$section" && echo "the section in do_export_json_section_vars is empty !!! nothing to do !!!"
   test -z "$section" && return
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
