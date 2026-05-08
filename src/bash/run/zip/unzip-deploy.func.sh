#!/bin/bash
# version=3.6.7

#------------------------------------------------------------------------------
# @description Unzip a project archive (built from /) and rsync its contents
# @description back to their original absolute paths under DEPLOY_ROOT.
# @description The zip is expected to contain paths relative to / — e.g.
# @description   opt/nda/app-edw/app-edw-utl/src/bash/run/foo.sh
# @description The archive is extracted to /tmp/unzip_deploy_<timestamp>/,
# @description then the following is run:
# @description   rsync -rl --delete /tmp/unzip_deploy_<ts>/ <DEPLOY_ROOT>/
# @description so every file lands at its original absolute path.
# @description On success the temp dir is removed automatically.
# @description On failure it is kept for inspection.
# @description Set KEEP_TMP=1 to always retain it (useful after DRY_RUN).
# @param ZIP_FILE    (required) - Path to the zip archive to deploy
# @param DEPLOY_ROOT (optional) - Root to deploy into (default: /)
# @param DRY_RUN     (optional) - Set to 1 to show what would change without writing
# @param KEEP_TMP    (optional) - Set to 1 to keep /tmp/unzip_deploy_<ts>/ after success
# @prereq unzip rsync
# @example ZIP_FILE=/media/usb/samsung-usb/var/nda/app-edw/app-edw-all/dat/zip/app-edw-utl.3.6.4.zip ./run -a do_unzip_deploy
# @example ZIP_FILE=/var/nda/app-edw/app-edw-all/dat/zip/app-edw-utl.3.6.4.zip DRY_RUN=1 ./run -a do_unzip_deploy
# @example ZIP_FILE=... DEPLOY_ROOT=/mnt/staging ./run -a do_unzip_deploy
# @example ZIP_FILE=... KEEP_TMP=1 ./run -a do_unzip_deploy
# @arg --zip-file    ZIP_FILE
# @arg --deploy-root DEPLOY_ROOT
# @arg --dry-run     DRY_RUN
# @arg --keep-tmp    KEEP_TMP
#------------------------------------------------------------------------------

do_unzip_deploy() {
  do_require_bin unzip rsync || return 11
  do_require_var ZIP_FILE "${ZIP_FILE:-}" || return 11

  local zip_file="${ZIP_FILE}"
  local deploy_root="${DEPLOY_ROOT:-/}"
  local dry="${DRY_RUN:-0}"
  local keep_tmp="${KEEP_TMP:-0}"

  # normalize: strip trailing slash so we can re-add it consistently
  deploy_root="${deploy_root%/}/"

  if [[ ! -f "$zip_file" ]]; then
    do_log "FATAL ZIP_FILE not found: $zip_file"
    return 11
  fi

  local ts
  ts=$(date '+%Y%m%d_%H%M%S')
  local tmp_dir="/tmp/unzip_deploy_${ts}"

  do_log "INFO zip_file    : $zip_file"
  do_log "INFO deploy_root : $deploy_root"
  do_log "INFO tmp_dir     : $tmp_dir"
  do_log "INFO dry_run     : $dry"
  do_log "INFO keep_tmp    : $keep_tmp"

  # --- 1. extract ---
  mkdir -p "$tmp_dir"
  do_log "INFO Extracting $zip_file -> $tmp_dir/"

  local unzip_out unzip_rc
  unzip_out=$(unzip -q "$zip_file" -d "$tmp_dir" 2>&1); unzip_rc=$?
  if [[ $unzip_rc -ne 0 ]]; then
    do_log "ERROR unzip failed (rc=${unzip_rc}): $unzip_out"
    do_log "INFO  Keeping $tmp_dir for inspection"
    return 11
  fi
  do_log "OK   Extracted $(find "$tmp_dir" -type f | wc -l) files"

  # --- 2. rsync ---
  local -a rsync_opts=(-rl --delete)
  [[ "$dry" == "1" ]] && rsync_opts+=(--dry-run --itemize-changes)

  do_log "INFO rsync ${rsync_opts[*]} ${tmp_dir}/ ${deploy_root}"

  local rsync_out rsync_rc
  rsync_out=$(rsync "${rsync_opts[@]}" "${tmp_dir}/" "${deploy_root}" 2>&1); rsync_rc=$?
  while IFS= read -r line; do [[ -n "$line" ]] && do_log "INFO   $line"; done <<< "$rsync_out"

  if [[ $rsync_rc -ne 0 ]]; then
    do_log "ERROR rsync failed (rc=${rsync_rc}) — keeping $tmp_dir for inspection"
    return 11
  fi

  do_log "OK   rsync complete"

  # --- 3. cleanup ---
  if [[ "$keep_tmp" == "1" || "$dry" == "1" ]]; then
    do_log "INFO Keeping $tmp_dir (keep_tmp=${keep_tmp} dry_run=${dry})"
  else
    rm -rf "$tmp_dir"
    do_log "OK   Removed $tmp_dir"
  fi

  return 0
}
# doc-hub ::: v1.0.0
# run-bsh ::: v3.8.2
