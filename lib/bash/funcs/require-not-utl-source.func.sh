#!/bin/bash
#------------------------------------------------------------------------------
# @description  Hard guard — refuses any source path that resolves under the
# @description  private run-bsh-utl project tree. Wired into every Confluence
# @description  publish action so run-bsh-utl content can NEVER reach the
# @description  Alchemists Confluence space.
# @description
# @description  run-bsh-utl is personal automation / consulting tooling; it is
# @description  explicitly excluded from team-shared publishing targets.
# @param        PATH_ARG (required) absolute path to validate
# @return       0 on pass, exits 11 on forbidden source
# @example      do_require_not_utl_source "$doc_md_base"
#------------------------------------------------------------------------------
do_require_not_utl_source() {
  local path="$1"
  if [[ -z "$path" ]]; then
    do_log "ERROR do_require_not_utl_source called with empty path"
    exit 11
  fi
  local real
  real=$(readlink -f -- "$path" 2>/dev/null || echo "$path")
  local forbidden="/opt/csi/run-bsh/run-bsh-utl"
  if [[ "$real" == "$forbidden"* ]]; then
    do_log "FATAL Refusing to publish from run-bsh-utl private repo: $path"
    do_log "FATAL  resolved to: $real"
    do_log "FATAL run-bsh-utl is personal automation — never published to Confluence."
    do_log "FATAL Team-shared docs belong under <REDACTED>"
    exit 11
  fi
  return 0
}
# run-bsh ::: v3.7.0
