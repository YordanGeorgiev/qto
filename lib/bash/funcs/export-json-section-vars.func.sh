#!/bin/bash
#------------------------------------------------------------------------------
# usage example:
# source $PRODUCT/lib/bash/funcs/export-json-section-vars.sh
# do_export_json_section_vars cnf/env/dev.env.json '.env.db'
#
# alias psql="PGPASSWORD=${postgres_sys_usr_admin_pw:-} psql -v -t -X -w -U \
#     ${postgres_sys_usr_admin:-} --port $postgres_rdbms_port --host $postgres_rdbms_host"
#------------------------------------------------------------------------------
do_export_json_section_vars(){

   json_file="$1"
   shift 1;
   test -f "$json_file" || echo "the json_file: $json_file does not exist !!! Nothing to do"
   test -f "$json_file" || exit 1

   section="$1"
   test -z "$section" && echo "the section in do_export_json_section_vars is empty !!! Nothing to do !!!"
   test -z "$section" && exit 1
   shift 1;

   echo "INFO exporting vars from cnf $json_file: "
   while read -r l ; do
      key=$(echo $l|cut -d'=' -f1|tr a-z A-Z)
      val=$(echo $l|cut -d'=' -f2)
      eval "$(echo -e 'export '$key=\"\"$val\"\")"
      echo "INFO $key=$val"
   done < <(cat "$json_file"| jq -r "$section"'|keys_unsorted[] as $key|"\($key)=\"\(.[$key])\""')
}
