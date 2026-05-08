#!/bin/env bash
#------------------------------------------------------------------------------
# @description Mirror git changes between two commits from the current module
# @description into a same-kind module in the target app.
# @param SRC_COMMIT_HASH (required) - The source commit hash.
# @param TGT_COMMIT_HASH (required) - The target commit hash to diff against.
# @param TGT_ORG (required) - Target organization name.
# @param TGT_APP (required) - Target application name.
# @example SRC_COMMIT_HASH=abc TGT_COMMIT_HASH=def TGT_ORG=csi TGT_APP=csi-wpb ./run -a do_clone_git_changes
#------------------------------------------------------------------------------
do_clone_git_changes() {
  do_require_var SRC_COMMIT_HASH "${SRC_COMMIT_HASH:-}"
  do_require_var TGT_COMMIT_HASH "${TGT_COMMIT_HASH:-}"
  do_require_var TGT_ORG         "${TGT_ORG:-}"
  do_require_var TGT_APP         "${TGT_APP:-}"

  SRC_BASE_PATH="${PROJ_PATH}"
  echo "Project kind: ${PROJ_KIND}"

  TGT_BASE_PATH="${BASE_PATH}/${TGT_ORG}/${TGT_APP}/${TGT_APP}-${PROJ_KIND}"

  git diff --name-status "${TGT_COMMIT_HASH}" "${SRC_COMMIT_HASH}" | while read status file_path; do
    local SRC_PATH="${SRC_BASE_PATH}/${file_path}"
    local TGT_PATH="${TGT_BASE_PATH}/${file_path}"

    case $status in
    M | A)
      do_log "INFO File $file_path was $status (added or modified). Syncing to target project..."
      export SRC_PATH="${SRC_PATH}"
      export GIT_MSG="Sync: Update due to $status of $file_path"
      ./run -a do_clone_file_to_tgt_proj
      ;;
    D)
      echo "File $file_path was deleted. Removing from target project..."
      if [ -f "${TGT_PATH}" ]; then
        rm -v "${TGT_PATH}"
        cd "${TGT_BASE_PATH}"
        git add "${file_path}"
        git commit -m "${JIRA_TICKET:-} Sync: Remove deleted file $file_path"
        git push
      else
        echo "No target file to delete at ${TGT_PATH}"
      fi
      ;;
    esac
  done
  export EXIT_CODE="0"
}
# run-bsh ::: v3.8.2
