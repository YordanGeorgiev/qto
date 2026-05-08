#!/bin/bash
#------------------------------------------------------------------------------
# @description  Splits an absolute path into its module-root, project-kind and
# @description  in-module relative path. The module dir basename follows the
# @description  convention "${APP}-${PROJ_KIND}" (e.g. run-bsh-utl, where
# @description  APP=run-bsh, PROJ_KIND=utl).
# @description
# @description  Exports four globals on success:
# @description    PROJ_NAME      basename of the module dir         (run-bsh-utl)
# @description    PROJ_KIND      trailing token after APP-          (utl)
# @description    PROJ_ROOT      absolute path of the module dir    (/opt/csi/run-bsh/run-bsh-utl)
# @description    PROJ_REL_PATH  path inside the module             (src/bash/foo.sh; empty when PATH == module root)
# @example      do_split_mod_path "run-bsh" "/opt/csi/run-bsh/run-bsh-utl/src/bash/foo.sh"
#------------------------------------------------------------------------------
do_split_mod_path() {
  local app="$1" path="$2"
  if [[ -z "$app" || -z "$path" ]]; then
    do_log "ERROR do_split_mod_path: APP and PATH are required (got app='$app' path='$path')"
    return 1
  fi

  path="${path%/}"

  local re="/(${app}-[A-Za-z0-9_]+)(/|$)"
  if [[ "$path" =~ $re ]]; then
    PROJ_NAME="${BASH_REMATCH[1]}"
  else
    do_log "ERROR do_split_mod_path: no '${app}-<kind>' segment in '$path'"
    return 1
  fi

  PROJ_KIND="${PROJ_NAME#${app}-}"

  if [[ "$path" == */${PROJ_NAME} ]]; then
    PROJ_ROOT="$path"
    PROJ_REL_PATH=""
  elif [[ "$path" == */${PROJ_NAME}/* ]]; then
    PROJ_ROOT="${path%%/${PROJ_NAME}/*}/${PROJ_NAME}"
    PROJ_REL_PATH="${path#${PROJ_ROOT}/}"
  else
    do_log "ERROR do_split_mod_path: cannot anchor '${PROJ_NAME}' inside '$path'"
    return 1
  fi

  export PROJ_NAME PROJ_KIND PROJ_ROOT PROJ_REL_PATH
}
# run-bsh ::: v3.7.0
