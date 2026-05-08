#!/bin/bash
#------------------------------------------------------------------------------
# @description Verifies do_load_config ran by checking PROJ/ORG/APP are set.
#------------------------------------------------------------------------------

do_test_config() {
  do_log "INFO test_config — PROJ=${PROJ:-} ORG=${ORG:-} APP=${APP:-}"
  if [[ -z "${PROJ:-}" || -z "${ORG:-}" || -z "${APP:-}" ]]; then
    do_log "ERROR PROJ/ORG/APP not all set after do_load_config"
    return 11
  fi
  do_log "OK test_config passed"
}
# run-bsh ::: v3.8.1
