#!/bin/env bash
#------------------------------------------------------------------------------
# @description Pull the same-kind project from a source app (SRC_ORG/SRC_APP)
# @description into the local target module root TGT_PATH.
# @param TGT_PATH (required) - Path to the local target module root.
# @param SRC_ORG (required) - Source organization name.
# @param SRC_APP (required) - Source application name.
# @param SKIP_GLOBS (optional) - Space-separated glob patterns to exclude.
# @param RSYNC_DELETE_OFF (optional) - If set, rsync will not use --delete.
# @example TGT_PATH=/opt/org/org-app/org-app-utl SRC_ORG=bas SRC_APP=bas-wpb ./run -a do_clone_proj_from_src_proj
#------------------------------------------------------------------------------
do_clone_proj_from_src_proj() {
  do_require_var TGT_PATH "${TGT_PATH:-}"
  do_require_var SRC_ORG  "${SRC_ORG:-}"
  do_require_var SRC_APP  "${SRC_APP:-}"
  SKIP_GLOBS="${SKIP_GLOBS:-}"

  TGT_PATH="${TGT_PATH%/}"
  echo "Target path: ${TGT_PATH}"

  local tgt_leaf="${TGT_PATH##*/}"
  PROJ_KIND="${tgt_leaf##*-}"
  echo "Project kind: ${PROJ_KIND}"

  BAS_PATH="${BASE_PATH}/${SRC_ORG}/${SRC_APP}/${SRC_APP}-${PROJ_KIND}"
  echo "Base path for replication: ${BAS_PATH}"

  SRC_BAS_PATH="${BAS_PATH%/}/"
  echo "Source base path: ${SRC_BAS_PATH}"

  mkdir -p "${TGT_PATH}"
  cd "${TGT_PATH}"
  if [ "$(git status --porcelain | grep '^\(??\| M\)' | wc -l)" -ne 0 ]; then
    do_log "FATAL: There are uncommitted changes in ${TGT_PATH} !!!
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
    echo "Will NOT delete files in ${TGT_PATH} not existing in ${SRC_BAS_PATH}"
  else
    echo "Will delete files in ${TGT_PATH} not existing in ${SRC_BAS_PATH}"
    exclude_args+=("--delete")
  fi

  rsync -av "${exclude_args[@]}" --exclude='.git/' "${SRC_BAS_PATH}" "${TGT_PATH}/"

  git add .
  git commit -m "$GIT_MSG"
  git push

  export EXIT_CODE=0
}
# run-bsh ::: v3.8.2
