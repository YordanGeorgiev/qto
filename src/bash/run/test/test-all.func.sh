#!/bin/bash
#------------------------------------------------------------------------------
# @description Runs every do_test_* action, reports pass/fail.
# Invokes each test through execute_step inside a subshell so its _pre/_post
# hooks fire and a single test failure does not abort the suite.
#------------------------------------------------------------------------------

do_test_all() {
  local _tests=(do_test_config do_test_hooks do_test_named_args do_test_custom_args)
  local total=0 passed=0 failed=0
  local failed_names=()
  local t rv

  for t in "${_tests[@]}"; do
    total=$((total + 1))
    do_log "INFO ─── running $t ───"
    # Subshell isolates: execute_step's error_handler calls `exit` on failure,
    # which would otherwise kill this loop. The subshell turns that exit into
    # a non-zero subshell-status that we capture cleanly.
    # NAME default keeps do_test_named_args (which declares NAME as @param
    # required) from validation-failing in the suite's positive run.
    ( NAME="${NAME:-test-all}" FORCE="${FORCE:-false}" execute_step "$t" ) ; rv=$?
    if (( rv == 0 )); then
      passed=$((passed + 1))
      do_log "OK   $t passed"
    else
      failed=$((failed + 1))
      failed_names+=("$t")
      do_log "WARN $t failed (exit $rv)"
    fi
  done

  do_log "INFO ════════════════════════════════════════"
  do_log "INFO test_all summary: $passed/$total passed, $failed failed"
  if (( failed > 0 )); then
    do_log "ERROR failing tests: ${failed_names[*]}"
    return 11
  fi
  do_log "OK test_all — all $total tests passed"
}
# run-bsh ::: v3.8.2
