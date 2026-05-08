#!/bin/bash
#------------------------------------------------------------------------------
# @description  Boot-time symlink health check. Called from run.sh between
# @description  do_require_bins and do_run_actions.
# @description
# @description  Reads the project's symlink manifest from PROJ_SYMLINK_MANIFEST,
# @description  an array of "link|target" pairs declared in the project's
# @description  cnf/bash/project.conf.sh (or similar). Generic — contains no
# @description  project-specific paths or names.
# @description
# @description  Silent when all symlinks are correct. Warns (never aborts) on
# @description  missing/wrong/dangling — the user is told to run
# @description  ./run -a do_setup_symlinks to repair.
# @description
# @description  Never mutates the filesystem at boot. Boot stays fast and
# @description  non-surprising; repairs are an explicit user action.
#------------------------------------------------------------------------------
do_verify_symlinks() {
  # Manifest is optional — projects without symlink requirements silently skip.
  local -a manifest=( "${PROJ_SYMLINK_MANIFEST[@]:-}" )
  # Strip the single empty element bash leaves when the array is unset
  [[ ${#manifest[@]} -eq 1 && -z "${manifest[0]}" ]] && manifest=()
  [[ ${#manifest[@]} -eq 0 ]] && return 0

  local spec link expected_target _ignore_gi _ignore_entry actual any_broken=0
  for spec in "${manifest[@]}"; do
    [[ -z "$spec" ]] && continue
    IFS='|' read -r link expected_target _ignore_gi _ignore_entry <<< "$spec"
    if [[ ! -L "$link" ]]; then
      do_log "WARN symlink missing : $link (expected → $expected_target)"
      any_broken=1
    else
      actual=$(readlink "$link")
      if [[ "$actual" != "$expected_target" ]]; then
        do_log "WARN symlink wrong   : $link → $actual (expected → $expected_target)"
        any_broken=1
      elif [[ ! -d "$expected_target" && ! -f "$expected_target" ]]; then
        do_log "WARN symlink dangling: $link → $expected_target (target does not exist)"
        any_broken=1
      fi
    fi
  done

  if [[ $any_broken -eq 1 ]]; then
    do_log "WARN To repair: ./run -a do_setup_symlinks"
  fi
  return 0
}
# run-bsh ::: v3.7.0
