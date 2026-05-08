#!/bin/bash
#------------------------------------------------------------------------------
# @description Project configuration loader — file-free.
# @description Auto-derives ORG, APP, PROJ, VAR_DIR, ZIP_*_DIR, and
# @description PROJ_SYMLINK_MANIFEST from APP_PATH / PROJ_PATH set by run.sh.
# @description No external config files are sourced.
# @example do_load_config
#------------------------------------------------------------------------------
do_load_config() {
  # Auto-derive project identity. APP_PATH and PROJ_PATH are set by run.sh
  # before this function runs. Examples:
  #   APP_PATH=/opt/csi/run-bsh              -> ORG=csi, APP=run-bsh
  #   PROJ_PATH=/opt/csi/run-bsh/run-bsh-utl -> PROJ=run-bsh-utl
  # If a caller has already exported any of these, we respect their values.
  if [[ -n "${APP_PATH:-}" ]]; then
    : "${ORG:=$(basename "$(dirname "$APP_PATH")")}"
    : "${APP:=$(basename "$APP_PATH")}"
    export ORG APP
  fi
  if [[ -n "${PROJ_PATH:-}" ]]; then
    : "${PROJ:=$(basename "$PROJ_PATH")}"
    export PROJ
  fi

  # /var-rooted output directories.
  : "${VAR_DIR:=${VAR_BASE_PATH:-/var}}"
  : "${ZIP_ALL_DIR:=${VAR_DIR}/${ORG}/${APP}/${APP}-all/dat/zip}"
  : "${ZIP_DIR:=${VAR_DIR}/${ORG}/${APP}/${APP}-dat/dat/zip}"
  : "${ZIP_PROJ_DIR:=${VAR_DIR}/${ORG}/${APP}/${PROJ}/dat/zip}"
  export VAR_DIR ZIP_ALL_DIR ZIP_DIR ZIP_PROJ_DIR

  # Default per-project symlink manifest: dat/log -> /var counterpart.
  if [[ -z "${PROJ_SYMLINK_MANIFEST+x}" && -n "${PROJ_PATH:-}" ]]; then
    PROJ_SYMLINK_MANIFEST=(
      "${PROJ_PATH}/dat/log|${VAR_BASE_PATH:-/var}/${ORG}/${APP}/${PROJ}/dat/log"
    )
    export PROJ_SYMLINK_MANIFEST
  fi
}
# run-bsh ::: v3.8.0
