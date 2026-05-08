#!/bin/bash
#------------------------------------------------------------------------------
# @description Demonstrates @arg-driven named-argument parsing. Used by
# test-named-args.tst.sh to verify the framework's named-args + validation.
# @param NAME (required) - Greeting target; rejected by validate_params if unset.
# @arg --name NAME
# @arg --force FORCE
#------------------------------------------------------------------------------

do_test_named_args() {
  local name="${NAME:-Alice}"
  local force="${FORCE:-false}"

  do_log "INFO Hello, ${name}!"
  do_log "INFO test_named_args — name=$name force=$force"
  if [[ "$force" == "true" ]]; then
    do_log "INFO Force mode is ENABLED"
  else
    do_log "INFO Force mode is DISABLED"
  fi
  do_log "OK test_named_args passed"
}
# run-bsh ::: v3.8.2
