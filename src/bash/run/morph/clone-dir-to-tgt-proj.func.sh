#!/bin/env bash
#------------------------------------------------------------------------------
# @description rsync a sub-directory from the local source module to the
# @description same-kind module in the target app.
# @param SRC_PATH (required) - Path inside the source module.
# @param TGT_ORG (required) - Target organization name.
# @param TGT_APP (required) - Target application name.
# @param SKIP_GLOBS (optional) - Space-separated glob patterns to exclude.
# @param RSYNC_DELETE_OFF (optional) - If set, rsync will not use --delete.
# @example SRC_PATH=/opt/bas/bas-wpb/bas-wpb-utl/src/bash/ TGT_ORG=csi TGT_APP=csi-wpb ./run -a do_clone_dir_to_tgt_proj
#------------------------------------------------------------------------------
do_clone_dir_to_tgt_proj() {
  do_require_var SRC_PATH "${SRC_PATH:-}"
  do_require_var TGT_ORG  "${TGT_ORG:-}"
  do_require_var TGT_APP  "${TGT_APP:-}"
  SKIP_GLOBS="${SKIP_GLOBS:-}"

  if [ ! -d "${SRC_PATH}" ]; then
    do_log "FATAL: ${SRC_PATH} is not a directory or does not exist."
    export EXIT_CODE=1
    return
  fi

  [[ "${SRC_PATH}" != */ ]] && SRC_PATH="${SRC_PATH}/"
  echo "Source path: ${SRC_PATH}"

  do_split_mod_path "${APP}" "${SRC_PATH%/}" || { export EXIT_CODE=1; return 1; }
  local src_proj_path="${PROJ_ROOT}"
  local proj_kind="${PROJ_KIND}"
  local src_relative_path="${PROJ_REL_PATH}"
  [[ -n "${src_relative_path}" && "${src_relative_path}" != */ ]] && src_relative_path="${src_relative_path}/"
  echo "SRC_PROJ_PATH       : ${src_proj_path}"
  echo "Project kind        : ${proj_kind}"
  echo "Source relative path: ${src_relative_path}"

  BAS_PATH="${BASE_PATH}/${TGT_ORG}/${TGT_APP}/${TGT_APP}-${proj_kind}"
  TGT_BAS_PATH="${BAS_PATH}/${src_relative_path}"
  TGT_BAS_PATH="${TGT_BAS_PATH%/}"
  echo "Target base path: ${TGT_BAS_PATH}"

  mkdir -p "${TGT_BAS_PATH}"
  cd "${BAS_PATH}"
  if [ "$(git status --porcelain | grep '^\(??\| M\)' | wc -l)" -ne 0 ]; then
    do_log "FATAL: There are uncommitted changes in ${TGT_BAS_PATH} !!!
            Please commit or stash them before replicating."
    export EXIT_CODE=1
    return
  fi

  git pull --rebase

  IFS=' ' read -r -a exclude_patterns <<<"$SKIP_GLOBS"
  exclude_args=()
  for pattern in "${exclude_patterns[@]}"; do
    exclude_args+=("--exclude=$pattern")
  done

  RSYNC_DELETE_OFF="${RSYNC_DELETE_OFF:-}"
  if [ -n "${RSYNC_DELETE_OFF}" ]; then
    echo "RSYNC_DELETE_OFF is set to '${RSYNC_DELETE_OFF}'"
    echo "Will NOT delete files in ${TGT_BAS_PATH} not existing in ${SRC_PATH}"
  else
    echo "Will delete files in ${TGT_BAS_PATH} not existing in ${SRC_PATH}"
    exclude_args+=("--delete")
  fi

  rsync -av "${exclude_args[@]}" --exclude='.git/' "${SRC_PATH}" "${TGT_BAS_PATH}/"

  git add .
  git commit -m "$GIT_MSG"
  git push

  export EXIT_CODE=0
}
# run-bsh ::: v3.8.2
