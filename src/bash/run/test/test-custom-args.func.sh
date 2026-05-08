#!/bin/bash
#------------------------------------------------------------------------------
# @description Demonstrates a custom getopts _args hook. Used by
# test-named-args.tst.sh Test 4 to verify short-flag parsing via getopts.
#------------------------------------------------------------------------------

do_test_custom_args_args() {
  do_log "DEBUG test_custom_args _args hook running"
  while getopts "n:f" opt; do
    case $opt in
      n) export NAME="$OPTARG" ;;
      f) export FORCE="true" ;;
      *) return 1 ;;
    esac
  done
}

do_test_custom_args() {
  local name="${NAME:-Bob}"
  local force="${FORCE:-false}"
  do_log "INFO test_custom_args — name=$name force=$force"
  echo "Custom Parse Result: Name=$name, Force=$force"
  do_log "OK test_custom_args passed"
}
# run-bsh ::: v3.8.2
