#!/bin/bash
#------------------------------------------------------------------------------
# @description standard helper to parse named CLI arguments (--flag value) into environment variables.
# @description Actions can call this inside their own _args() hook to avoid boilerplate.
#------------------------------------------------------------------------------
do_parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --*)
        # Convert --my-arg to MY_ARG
        local key="${1#--}"
        key="${key//-/_}"
        key="${key^^}"
        
        local val=""
        # Check if next arg exists and isn't another flag
        if [[ -n "${2:-}" && ! "$2" == --* ]]; then
          val="$2"
          shift 2
        else
          # Boolean flag (e.g. --overwrite)
          val="true"
          shift 1
        fi
        
        export "$key"="$val"
        do_log "DEBUG Set variable from CLI: $key=$val"
        ;;
      *)
        # Skip positional arguments
        shift
        ;;
    esac
  done
}
# run-bsh ::: v3.7.0
