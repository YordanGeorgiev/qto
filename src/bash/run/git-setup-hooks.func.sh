#!/bin/bash
#------------------------------------------------------------------------------
# @description Symlink every hook from cnf/git/hooks/ into .git/hooks/, so that
# @description a fresh clone immediately picks up the canonical pre-commit
# @description (and any other hooks added later under the same dir).
# @description Idempotent: if a hook is already correctly linked, no-op.
# @description Searches for the source dir in repo_root/run-bsh-utl/cnf/git/hooks
# @description first (this project), falling back to repo_root/cnf/git/hooks
# @description (downstream layout) and $PROJ_PATH/cnf/git/hooks.
# @example ./run -a do_git_setup_hooks
#------------------------------------------------------------------------------
do_git_setup_hooks() {
  local repo_root
  repo_root=$(git rev-parse --show-toplevel 2>/dev/null) || {
    do_log "FATAL not inside a git repo"
    return 11
  }

  local hooks_src=""
  local cand
  for cand in \
    "$repo_root/run-bsh-utl/cnf/git/hooks" \
    "$repo_root/cnf/git/hooks" \
    "${PROJ_PATH:-}/cnf/git/hooks" \
  ; do
    if [[ -n "$cand" && -d "$cand" ]]; then
      hooks_src="$cand"
      break
    fi
  done

  if [[ -z "$hooks_src" ]]; then
    do_log "FATAL no cnf/git/hooks/ dir found under $repo_root"
    return 11
  fi

  do_log "INFO source: $hooks_src"
  do_log "INFO target: $repo_root/.git/hooks/"

  # relative path from .git/hooks/ to hooks_src — works for any depth under repo
  local rel="${hooks_src#$repo_root/}"
  rel="../../$rel"

  local installed=0 unchanged=0
  local f name link target
  for f in "$hooks_src"/*; do
    [[ -f "$f" ]] || continue
    name=$(basename "$f")
    link="$repo_root/.git/hooks/$name"
    target="$rel/$name"

    chmod +x "$f"

    if [[ -L "$link" && "$(readlink "$link")" == "$target" ]]; then
      do_log "INFO   $name :: already linked"
      unchanged=$((unchanged + 1))
      continue
    fi

    ln -sfn "$target" "$link"
    do_log "INFO   $name :: linked -> $target"
    installed=$((installed + 1))
  done

  do_log "INFO PHASE :: installed=$installed unchanged=$unchanged"
}
# run-bsh ::: v3.7.0
