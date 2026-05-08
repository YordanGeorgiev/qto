#!/bin/env bash
#------------------------------------------------------------------------------
# @description Push the local source module SRC_PATH to a same-kind module in
# @description the target app (TGT_ORG/TGT_APP).
# @param SRC_PATH (required) - Path to the local source module.
# @param TGT_ORG (required) - Target organization name.
# @param TGT_APP (required) - Target application name.
# @param SKIP_GLOBS (optional) - Space-separated glob patterns to exclude.
# @param RSYNC_DELETE_OFF (optional) - If set, rsync will not use --delete.
# @example SRC_PATH=/opt/bas/bas-wpb/bas-wpb-wui TGT_ORG=csi TGT_APP=csi-wpb ./run -a do_clone_proj_to_tgt_proj
#------------------------------------------------------------------------------
do_clone_proj_to_tgt_proj() {
  do_require_var SRC_PATH "${SRC_PATH:-}"
  do_require_var TGT_ORG  "${TGT_ORG:-}"
  do_require_var TGT_APP  "${TGT_APP:-}"
  SKIP_GLOBS="${SKIP_GLOBS:-}"

  [[ "${SRC_PATH}" != */ ]] && SRC_PATH="${SRC_PATH}/"
  echo "Source path: ${SRC_PATH}"

  local src_leaf
  src_leaf="$(basename "${SRC_PATH%/}")"
  PROJ_KIND="${src_leaf##*-}"
  echo "Project kind: ${PROJ_KIND}"

  BAS_PATH="${BASE_PATH}/${TGT_ORG}/${TGT_APP}/${TGT_APP}-${PROJ_KIND}"
  echo "Base path for Git operations: ${BAS_PATH}"

  mkdir -p "${BAS_PATH}"
  cd "${BAS_PATH}"
  if [ "$(git status --porcelain | grep '^\(??\| M\)' | wc -l)" -ne 0 ]; then
    do_log "FATAL: There are uncommitted changes in ${BAS_PATH} !!!
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
    echo "Will NOT delete files in ${BAS_PATH} not existing in ${SRC_PATH}"
  else
    echo "Will delete files in ${BAS_PATH} not existing in ${SRC_PATH}"
    exclude_args+=("--delete")
  fi

  rsync -av "${exclude_args[@]}" --exclude='.git/' "${SRC_PATH}" "${BAS_PATH}"

  cd "${BAS_PATH}"
  git add .
  git commit -m "$GIT_MSG"
  git push

  export EXIT_CODE=0
}
# run-bsh ::: v3.8.2
