#!/bin/env bash
#------------------------------------------------------------------------------
# @description Copy a single file from a source app's same-kind module into
# @description the local target module at TGT_PATH.
# @param TGT_PATH (required) - Path to the target file.
# @param SRC_ORG (required) - Source organization name.
# @param SRC_APP (required) - Source application name.
# @example TGT_PATH=/opt/csi/csi-wpb/csi-wpb-utl/src/bash/run.sh SRC_ORG=bas SRC_APP=bas-wpb ./run -a do_clone_file_from_src_proj
#------------------------------------------------------------------------------
do_clone_file_from_src_proj() {
  do_require_var TGT_PATH "${TGT_PATH:-}"
  do_require_var SRC_ORG  "${SRC_ORG:-}"
  do_require_var SRC_APP  "${SRC_APP:-}"
  SKIP_GLOBS="${SKIP_GLOBS:-}"

  echo "Target path: ${TGT_PATH}"

  do_split_mod_path "${APP}" "${TGT_PATH}" || { export EXIT_CODE=1; return 1; }
  local tgt_proj_path="${PROJ_ROOT}"
  local proj_kind="${PROJ_KIND}"
  local tgt_relative_path="${PROJ_REL_PATH}"
  echo "TGT_PROJ_PATH       : ${tgt_proj_path}"
  echo "Project kind        : ${proj_kind}"
  echo "Target relative path: ${tgt_relative_path}"

  BAS_PATH="${BASE_PATH}/${SRC_ORG}/${SRC_APP}/${SRC_APP}-${proj_kind}"
  echo "Base path for replication: ${BAS_PATH}"

  SRC_BAS_PATH="${BAS_PATH}/${tgt_relative_path}"
  echo "Source base path: ${SRC_BAS_PATH}"

  mkdir -p "$(dirname "${TGT_PATH}")"
  cd "${tgt_proj_path}"
  if [ "$(git status --porcelain | grep '^\(??\| M\)' | wc -l)" -ne 0 ]; then
    do_log "FATAL: There are uncommitted changes in ${TGT_PATH} !!!
            Please commit or stash them before replicating."
    export EXIT_CODE=1
    return
  fi

  git pull --rebase

  cp -v "${SRC_BAS_PATH}" "${TGT_PATH}"

  git add .
  git commit -m "$GIT_MSG"
  git push

  export EXIT_CODE=0
}
# run-bsh ::: v3.8.2
