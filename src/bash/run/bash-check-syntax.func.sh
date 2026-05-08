#!/bin/bash
#------------------------------------------------------------------------------
# @description Parse-check every *.sh / *.func.sh under PROJ_PATH (skipping
#              vendor + .git + dat/ + *.bak). Uses `bash -n` on each file and
#              reports a pass/fail summary. Returns 11 if any file fails.
# @param       SKIP_GLOB (optional) — extra grep -vE pattern to exclude paths.
#                                     Defaults to vendor/dat/.git/.bak.
# @example     ./run -a do_bash_check_syntax
# @example     SKIP_GLOB='legacy|build' ./run -a do_bash_check_syntax
#------------------------------------------------------------------------------

do_bash_check_syntax() {
  do_require_bin bash find || return $?

  local skip_re="${SKIP_GLOB:-/vendor/|/\.git/|/dat/|\.bak[0-9]*$}"
  local total=0 ok=0 fail=0
  local failed_files=()
  local f errmsg

  do_log "INFO scanning ${PROJ_PATH:-$(pwd)} for *.sh / *.func.sh (skipping: $skip_re)"

  while IFS= read -r -d '' f; do
    total=$((total + 1))
    if errmsg=$(bash -n "$f" 2>&1); then
      ok=$((ok + 1))
    else
      fail=$((fail + 1))
      failed_files+=("$f")
      do_log "ERROR bash -n failed: $f"
      while IFS= read -r line; do
        do_log "ERROR  ↳ $line"
      done <<< "$errmsg"
    fi
  done < <(find "${PROJ_PATH:-$(pwd)}" -type f \( -name '*.sh' -o -name '*.func.sh' \) -print0 2>/dev/null \
            | grep -zvE "$skip_re" \
            | sort -z)

  do_log "INFO ════════════════════════════════════════"
  do_log "INFO bash-syntax: $ok/$total OK, $fail failed"

  if (( fail > 0 )); then
    do_log "ERROR failing files:"
    local ff
    for ff in "${failed_files[@]}"; do
      do_log "ERROR   $ff"
    done
    return 11
  fi
  do_log "OK bash-syntax — all $total files parse cleanly"
}
# run-bsh ::: v3.8.1
