#!/bin/bash
#------------------------------------------------------------------------------
# @description Validate that a required environment variable has a value.
# @param var_name (required) - Name of the variable to check
# @param var_val (required) - Value of the variable
# @example do_require_var JIRA_PAT "${JIRA_PAT:-}"
#------------------------------------------------------------------------------
do_require_var() {
  local var_name="${1:-}"
  local var_val="${2:-}"

  if [[ -z "$var_val" ]]; then
    do_log "FATAL The environment variable \"$var_name\" does not have a value !!!"
    do_log "INFO In the calling shell do \"export $var_name=your-$var_name-value\""
    exit 1
  fi
}
# run-bsh ::: v3.7.0
