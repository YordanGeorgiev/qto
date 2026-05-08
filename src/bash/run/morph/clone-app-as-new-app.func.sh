#!/bin/bash
#------------------------------------------------------------------------------
# @description Fork a run.sh-based app to a brand-new APP name in one shot.
# @description Copies SRC_APP_PATH -> TGT_APP_PATH, drops the source's .git,
# @description renames every inner module dir from ${src-app}-<kind> to
# @description ${tgt-app}-<kind>, morphs both kebab and snake_case occurrences
# @description of the app name across all text files, re-points the `run`
# @description symlinks, and (optionally) git-init's + force-pushes to
# @description GIT_REMOTE.
# @description
# @description Refuses to overwrite an existing TGT_APP_PATH.
# @description ORG/APP/PROJ/PROJ_KIND of the new app are derived automatically
# @description by run.sh from the new path layout — no config file edits.
# @param SRC_APP_PATH (required) - Existing app dir (e.g. /opt/csi/run-bsh)
# @param TGT_APP_PATH (required) - New app dir to create; must NOT exist
# @param GIT_REMOTE   (optional) - SSH/HTTPS URL. If set, init + force-push.
# @example SRC_APP_PATH=/opt/csi/run-bsh TGT_APP_PATH=/opt/csi/doc-gen \
# @example   GIT_REMOTE=git@github.com:csitea/doc-gen.git \
# @example   ./run -a do_clone_app_as_new_app
#------------------------------------------------------------------------------
do_clone_app_as_new_app() {
  do_require_var SRC_APP_PATH "${SRC_APP_PATH:-}"
  do_require_var TGT_APP_PATH "${TGT_APP_PATH:-}"
  local git_remote="${GIT_REMOTE:-}"

  if [[ ! -d "$SRC_APP_PATH" ]]; then
    do_log "FATAL SRC_APP_PATH does not exist: $SRC_APP_PATH"
    export EXIT_CODE=1; return 1
  fi
  if [[ -e "$TGT_APP_PATH" ]]; then
    do_log "FATAL TGT_APP_PATH already exists, refusing to overwrite: $TGT_APP_PATH"
    export EXIT_CODE=1; return 1
  fi

  local src_app tgt_app src_snake tgt_snake
  src_app="$(basename "$SRC_APP_PATH")"
  tgt_app="$(basename "$TGT_APP_PATH")"
  src_snake="${src_app//-/_}"
  tgt_snake="${tgt_app//-/_}"

  do_log "INFO  Copy ${SRC_APP_PATH} -> ${TGT_APP_PATH}"
  cp -r "$SRC_APP_PATH" "$TGT_APP_PATH"
  rm -rf "$TGT_APP_PATH/.git"

  do_log "INFO  Rename inner modules: ${src_app}-* -> ${tgt_app}-*"
  local d kind
  for d in "$TGT_APP_PATH/${src_app}"-*; do
    [[ -d "$d" ]] || continue
    kind="$(basename "$d")"
    kind="${kind#${src_app}-}"
    mv "$d" "$TGT_APP_PATH/${tgt_app}-${kind}"
  done

  STR_TO_SRCH="$src_app" STR_TO_REPL="$tgt_app" TGT_PATH="$TGT_APP_PATH" do_morph_path
  if [[ "$src_snake" != "$src_app" ]]; then
    STR_TO_SRCH="$src_snake" STR_TO_REPL="$tgt_snake" TGT_PATH="$TGT_APP_PATH" do_morph_path
  fi

  do_log "INFO  Re-link 'run' symlinks under each ${tgt_app}-<kind>"
  for d in "$TGT_APP_PATH/${tgt_app}"-*; do
    [[ -d "$d" && -e "$d/src/bash/run/run.sh" ]] || continue
    ln -sfn src/bash/run/run.sh "$d/run"
  done

  if [[ -n "$git_remote" ]]; then
    do_log "INFO  git init + force-push to ${git_remote}"
    (
      cd "$TGT_APP_PATH"
      git init -b master
      git add -A
      git commit -m "Initial commit — ${tgt_app}, forked from ${src_app}"
      git remote add origin "$git_remote"
      git push --force -u origin master
    )
  else
    do_log "INFO  GIT_REMOTE not set — skipping git init/push."
    do_log "INFO  To wire up later:"
    do_log "INFO    cd ${TGT_APP_PATH} && git init -b master && git add -A && git commit -m init && git remote add origin <url> && git push -u origin master"
  fi

  export EXIT_CODE=0
}
# run-bsh ::: v3.8.2
