#!/bin/bash
#------------------------------------------------------------------------------
# @description Validate required parameters declared in @param metadata tags
# @description before an action starts. Checks that all (required) env vars are set.
# @param FILE (required) - Path to the .func.sh file whose params to validate
# @example do_validate_params "src/bash/run/zip-jira-ticket.func.sh"
#------------------------------------------------------------------------------

# Validate that all required @param env vars are set
# Usage: do_validate_params <func_file_path>
# Returns 0 if all required params are set, exits with error otherwise
do_validate_params() {
  local file_path="${1:?Usage: do_validate_params <file_path>}"
  local has_errors=0

  if ! do_has_metadata "$file_path"; then
    # No structured metadata — skip validation
    return 0
  fi

  while IFS= read -r param_line; do
    # Format: param=VAR_NAME (required) - Description
    local param_def="${param_line#param=}"
    [[ -z "$param_def" ]] && continue

    # Extract variable name (first word)
    local var_name
    var_name=$(echo "$param_def" | awk '{print $1}')

    # Auto-resolve *_PAT vars from their *_PAT_FILE before checking required.
    # Delegates to do_load_pat, which handles both raw-token and shell-export
    # formats. Silent on failure — the regular "required" check below will
    # surface a clean error if the PAT is still missing afterwards.
    if [[ "$var_name" == *_PAT && -z "${!var_name:-}" ]] && type do_load_pat &>/dev/null; then
      do_load_pat "${var_name%_PAT}" 2>/dev/null || true
    fi

    # Check if marked as required
    if echo "$param_def" | grep -qi '(required)'; then
      # Check if the env var has a value
      local var_val="${!var_name:-}"
      if [[ -z "$var_val" ]]; then
        do_log "ERROR Required parameter $var_name is not set."
        local desc
        desc=$(echo "$param_def" | sed 's/^[^ ]* *(required)[[:space:]]*-*[[:space:]]*//')
        if [[ -n "$desc" ]]; then
          do_log "INFO  ↳ $var_name: $desc"
        fi
        has_errors=1
      fi
    fi
  done < <(do_get_params "$file_path")

  if [[ $has_errors -eq 1 ]]; then
    do_log "FATAL Missing required parameters. See above."
    local action_name
    action_name=$(basename "$file_path" .func.sh)
    action_name="do_${action_name//-/_}"
    do_log "INFO Run: SRCH=${action_name} ./run -a do_help_with  for usage details."
    return 11
  fi

  return 0
}
# run-bsh ::: v3.7.0
