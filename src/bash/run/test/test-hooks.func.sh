#!/bin/bash
#------------------------------------------------------------------------------
# @description Demonstrates pre/post hooks. The framework runs the *_pre and
# *_post functions automatically around the main action.
#------------------------------------------------------------------------------

do_test_hooks_pre() {
  do_log "INFO test_hooks_pre fired"
  export _TEST_HOOKS_PRE_RAN=1
}

do_test_hooks() {
  do_log "INFO test_hooks main"
  if [[ "${_TEST_HOOKS_PRE_RAN:-}" != "1" ]]; then
    do_log "ERROR pre hook did not run"
    return 11
  fi
  do_log "OK test_hooks passed (pre hook fired before main)"
}

do_test_hooks_post() {
  do_log "INFO test_hooks_post fired (cleanup)"
  unset _TEST_HOOKS_PRE_RAN
}
# run-bsh ::: v3.8.1
