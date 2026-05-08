#!/bin/bash
#------------------------------------------------------------------------------
# @description Fork a single project module from one app/org to another, with
# @description optional kind change. Copies SRC_PROJ_PATH -> TGT_PROJ_PATH,
# @description drops the source's .git, then morphs both kebab and snake_case
# @description occurrences of the module name (most specific) and the parent
# @description app name across all text files and filenames inside the new
# @description project. Re-points the `run` symlink. Refuses to overwrite.
# @description
# @description Does NOT git init or push — wire up the remote yourself after.
# @description
# @param SRC_PROJ_PATH (required) - Existing project module dir
# @param SRC_PROJ_PATH (required)   (e.g. /opt/bnc/bnc-cpt/bnc-cpt-utl)
# @param TGT_PROJ_PATH (required) - New project module dir; must NOT exist
# @param TGT_PROJ_PATH (required)   (e.g. /opt/csi/doc-gen/doc-gen-orc)
# @example SRC_PROJ_PATH=/opt/bnc/bnc-cpt/bnc-cpt-utl \
# @example   TGT_PROJ_PATH=/opt/csi/doc-gen/doc-gen-orc \
# @example   ./run -a do_fork_morph_proj_from_src_proj
#------------------------------------------------------------------------------
do_fork_morph_proj_from_src_proj() {
  do_require_var SRC_PROJ_PATH "${SRC_PROJ_PATH:-}"
  do_require_var TGT_PROJ_PATH "${TGT_PROJ_PATH:-}"

  if [[ ! -d "$SRC_PROJ_PATH" ]]; then
    do_log "FATAL SRC_PROJ_PATH does not exist: $SRC_PROJ_PATH"
    export EXIT_CODE=1; return 1
  fi
  if [[ -e "$TGT_PROJ_PATH" ]]; then
    do_log "FATAL TGT_PROJ_PATH already exists, refusing to overwrite: $TGT_PROJ_PATH"
    export EXIT_CODE=1; return 1
  fi

  local src_mod tgt_mod src_app tgt_app
  local src_mod_snake tgt_mod_snake src_app_snake tgt_app_snake
  src_mod="$(basename "$SRC_PROJ_PATH")"
  tgt_mod="$(basename "$TGT_PROJ_PATH")"
  src_app="$(basename "$(dirname "$SRC_PROJ_PATH")")"
  tgt_app="$(basename "$(dirname "$TGT_PROJ_PATH")")"
  src_mod_snake="${src_mod//-/_}"
  tgt_mod_snake="${tgt_mod//-/_}"
  src_app_snake="${src_app//-/_}"
  tgt_app_snake="${tgt_app//-/_}"

  do_log "INFO  Fork  ${SRC_PROJ_PATH} -> ${TGT_PROJ_PATH}"
  mkdir -p "$(dirname "$TGT_PROJ_PATH")"
  cp -r "$SRC_PROJ_PATH" "$TGT_PROJ_PATH"
  rm -rf "$TGT_PROJ_PATH/.git"

  # Most-specific first: full module name (kebab + snake), then parent app
  # (kebab + snake). Order matters — morphing the app prefix first would
  # swallow the module suffix.
  STR_TO_SRCH="$src_mod"       STR_TO_REPL="$tgt_mod"       TGT_PATH="$TGT_PROJ_PATH" do_morph_path
  if [[ "$src_mod_snake" != "$src_mod" ]]; then
    STR_TO_SRCH="$src_mod_snake" STR_TO_REPL="$tgt_mod_snake" TGT_PATH="$TGT_PROJ_PATH" do_morph_path
  fi
  if [[ "$src_app" != "$tgt_app" ]]; then
    STR_TO_SRCH="$src_app"       STR_TO_REPL="$tgt_app"       TGT_PATH="$TGT_PROJ_PATH" do_morph_path
    if [[ "$src_app_snake" != "$src_app" ]]; then
      STR_TO_SRCH="$src_app_snake" STR_TO_REPL="$tgt_app_snake" TGT_PATH="$TGT_PROJ_PATH" do_morph_path
    fi
  fi

  do_log "INFO  Re-link 'run' symlink in ${TGT_PROJ_PATH}"
  if [[ -e "$TGT_PROJ_PATH/src/bash/run/run.sh" ]]; then
    ( cd "$TGT_PROJ_PATH" && ln -sfn src/bash/run/run.sh run )
  fi

  do_log "INFO  Done. Forked ${src_mod} -> ${tgt_mod}. No git init/push performed."
  do_log "INFO  To wire a remote later:"
  do_log "INFO    cd ${TGT_PROJ_PATH} && git init -b master && git add -A && git commit -m init && git remote add origin <url> && git push -u origin master"

  export EXIT_CODE=0
}
# run-bsh ::: v3.8.2
