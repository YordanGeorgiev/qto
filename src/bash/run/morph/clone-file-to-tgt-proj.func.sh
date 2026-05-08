#!/bin/env bash
#------------------------------------------------------------------------------
# @description Copy a single file from the local source module to the same-kind
# @description module in the target app.
# @param SRC_PATH (required) - Path to the source file.
# @param GIT_MSG (required) - The commit message for the target repository.
# @param TGT_ORG (required) - Target organization name.
# @param TGT_APP (required) - Target application name.
# @param PROJ_KIND_OVERRIDE (optional) - Override the derived project kind.
# @example SRC_PATH=/path/to/file GIT_MSG="msg" TGT_ORG=csi TGT_APP=csi-wpb ./run -a do_clone_file_to_tgt_proj
#------------------------------------------------------------------------------
do_clone_file_to_tgt_proj() {
  do_require_var SRC_PATH "${SRC_PATH:-}"
  do_require_var GIT_MSG  "${GIT_MSG:-}"
  do_require_var TGT_ORG  "${TGT_ORG:-}"
  do_require_var TGT_APP  "${TGT_APP:-}"

  echo "Source path: ${SRC_PATH}"

  do_split_mod_path "${APP}" "${SRC_PATH}" || { export EXIT_CODE=1; return 1; }
  local src_proj_path="${PROJ_ROOT}"
  local extracted_kind="${PROJ_KIND}"
  local src_relative_path="${PROJ_REL_PATH}"

  PROJ_KIND="${PROJ_KIND_OVERRIDE:-${PROJ_KIND:-$extracted_kind}}"
  echo "SRC_PROJ_PATH : ${src_proj_path}"
  echo "Project kind  : ${PROJ_KIND}"

  BAS_PATH="${BASE_PATH}/${TGT_ORG}/${TGT_APP}/${TGT_APP}-${PROJ_KIND}"
  echo "Base path for Git operations: ${BAS_PATH}"

  TGT_PATH="${BAS_PATH}/${src_relative_path}"
  echo "Target path for replication: ${TGT_PATH}"

  mkdir -p "$(dirname "${TGT_PATH}")"

  cd "${BAS_PATH}" || {
    do_log "FATAL: Cannot change to ${BAS_PATH}"
    export EXIT_CODE=1
    return 1
  }
  if [ "$(git status --porcelain | grep '^\(??\| M\)' | wc -l)" -ne 0 ]; then
    do_log "FATAL: There are uncommitted changes in ${BAS_PATH} !!!
            Please commit or stash them before replicating."
    export EXIT_CODE=1
    return 1
  fi

  git pull --rebase || { do_log "WARNING: Git pull failed. Proceeding with replication anyway."; }

  cp -v "${SRC_PATH}" "${TGT_PATH}" || {
    do_log "FATAL: Failed to copy file"
    export EXIT_CODE=1
    return 1
  }

  git add "${TGT_PATH}"
  git commit -m "${GIT_MSG}" || { do_log "WARNING: Git commit failed. No changes to commit."; }
  git push || { do_log "WARNING: Git push failed. Please push changes manually."; }

  export EXIT_CODE=0
}
# run-bsh ::: v3.8.2
