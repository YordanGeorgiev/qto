#!/bin/bash
#------------------------------------------------------------------------------
# @description Exports key-value pairs from a specific JSON section as environment variables.
# @description Only string values are exported. Keys are converted to UPPERCASE.
# @param JSON_FILE (required) - Path to the JSON file to parse
# @param SECTION (required) - jq filter for the section to export (e.g., '.env.vars')
# @param SENSITIVENESS (optional) - If non-empty, masks values in the log output
# @example do_export_json_section_vars "$org/dev.env.json" '.env.steps."004-aws-iam"'
# @prereq jq, perl
#------------------------------------------------------------------------------
do_export_json_section_vars() {

  json_file="$1"
  shift 1
  test -f "$json_file" || do_log "FATAL the json_file: $json_file does not exist !!! Nothing to do"
  test -f "$json_file" || exit 1

  section="$1"
  test -z "$section" && do_log "FATAL the section in do_export_json_section_vars is empty !!! Nothing to do !!!"
  test -z "$section" && exit 1
  shift 1

  sensitiveness="${1:-}"
  shift 1

  do_log "INFO exporting vars from cnf $json_file: "
  while read -r l; do
    key=$(echo $l | cut -d':' -f1 | tr a-z A-Z)
    val=$(echo $l | cut -d':' -f2)

    #val="${val/#\~/$HOME}" # for some reason does not work !!
    val=$(echo $val | perl -ne 's|~|'$HOME'|g;print')
    eval "$(echo -e 'export '$key=\"\"$val\"\")"

    # does not do_log sensitive values
    if [[ "${sensitiveness}" == "" ]]; then
      do_log "INFO ${key}=${val}"
    else
      do_log "WARNING SENSITIVE ${key}=*****************"
    fi

    # done < <(cat "$json_file"| jq -r "$section"'|keys_unsorted[] as $key|"\($key):\"\(.[$key])\""')
  done < <(cat "$json_file" | jq -r "$section"'|to_entries| map(select(.value | type == "string"))|from_entries|keys_unsorted[] as $key|"\($key):\"\(.[$key])\""')
  # thanks ChatGPT: 'to_entries | map(select(.value | type == "string")) | from_entries'
  # ok cat /opt/spe/spe-infra-conf/prp/dev.env.json | jq -r '.env.steps."004-aws-iam"|to_entries| map(select(.value | type == "string"))|from_entries|keys_unsorted[] as $key|"\($key):\"\(.[$key])\""'
}
# run-bsh ::: v3.7.0
