#!/bin/bash
#------------------------------------------------------------------------------
# @description  Unified zip action — zip any SRC_DIR into /var/<org>/<org>-<app>/<org>-<app>-all/dat/zip/
# @description  Derives <org> and <org>-<app> from path segments (position 2 and 3 after /).
# @description  Works for /opt/<org>/<org>-<app>, /opt/<org>/<org>-<app>/<proj>,
# @description             /var/<org>/<org>-<app>/<variant>, etc.
# @param        SRC_DIR           (required) absolute path to zip
# @param        DST_DIR           (optional) override output dir — default: /var/<org>/<app>/<app>-all/dat/zip
# @param        EXCLUDE_FILE_GLOB (optional) extra zip exclusion glob(s); whitespace- or colon-separated.
# @param                          Patterns are passed to `zip -x` and augment the built-in exclusions.
# @param                          Non-anchored patterns (no leading `*` or `/`) are auto-prefixed with `*/`
# @param                          so they match anywhere in the tree (e.g. `.git/*` → `*/.git/*`).
# @prereq       zip unzip perl
# @example      SRC_DIR=/opt/csi/app-frw ./run -a do_zip_proj                                       # → /var/csi/app-frw/app-frw-all/dat/zip/app-frw.<ver>.<ts>.zip
# @example      SRC_DIR=/var/csi/app-frw/app-frw-doc ./run -a do_zip_proj                           # → /var/csi/app-frw/app-frw-all/dat/zip/app-frw-doc.<ts>.zip
# @example      SRC_DIR=/opt/nda/app-edw ./run -a do_zip_proj                                       # → /var/nda/app-edw/app-edw-all/dat/zip/app-edw.<ver>.<ts>.zip
# @example      SRC_DIR=/opt/nda/app-edw/app-edw-utl ./run -a do_zip_proj                           # → /var/nda/app-edw/app-edw-all/dat/zip/app-edw-utl.<ver>.<ts>.zip
# @example      SRC_DIR=/var/nda/app-edw/app-edw-dat ./run -a do_zip_proj                           # → /var/nda/app-edw/app-edw-all/dat/zip/app-edw-dat.<ts>.zip
# @example      SRC_DIR=/var/nda/app-edw/app-edw-doc ./run -a do_zip_proj                           # → /var/nda/app-edw/app-edw-all/dat/zip/app-edw-doc.<ts>.zip
# @example      SRC_DIR=/opt/csi/app-frw DST_DIR=/tmp/zips ./run -a do_zip_proj                     # → /tmp/zips/app-frw.<ver>.<ts>.zip
# @example      SRC_DIR=$(pwd) EXCLUDE_FILE_GLOB='.git/*' ./run -a do_zip_proj                      # exclude .git/ in addition to the defaults
# @example      SRC_DIR=$(pwd) EXCLUDE_FILE_GLOB='secrets/* *.pem dat/cache/*' ./run -a do_zip_proj # multiple patterns (whitespace-separated)
#------------------------------------------------------------------------------
do_zip_proj() {
  do_require_bin zip unzip perl

  local src_dir="${SRC_DIR:?SRC_DIR is required — e.g. SRC_DIR=/opt/csi/app-frw ./run -a do_zip_proj}"
  src_dir="${src_dir%/}"

  if [[ ! -d "$src_dir" ]]; then
    do_log "ERROR Source directory not found: $src_dir"
    return 11
  fi

  # Derive org and app from path: /<root>/<org>/<app>[/<variant>...]
  local _stripped="${src_dir#/}"
  local _org _app
  _org=$(echo "$_stripped" | cut -d/ -f2)
  _app=$(echo "$_stripped" | cut -d/ -f3)

  if [[ -z "$_org" || -z "$_app" ]]; then
    do_log "FATAL Cannot parse org/app from: $src_dir"
    do_log "FATAL Expected: /(opt|var)/<org>/<app>[/<variant>]"
    return 1
  fi

  local zip_dir="${DST_DIR:-/var/${_org}/${_app}/${_app}-all/dat/zip}"
  local ts
  ts=$(date +"%Y%m%d_%H%M%S")
  local _basename
  _basename=$(basename "$src_dir")
  local _version
  _version=$(cat "${src_dir}/.version" 2>/dev/null | tr -d '[:space:]') || true
  local zip_file="${zip_dir}/${_basename}${_version:+.${_version}}.${ts}.zip"

  sudo mkdir -p "$zip_dir" && sudo chown -R "$(id -un):$(id -gn)" "$zip_dir" 2>/dev/null || \
    mkdir -p "$zip_dir" || {
      do_log "ERROR Cannot create output directory: $zip_dir"
      return 11
    }

  # Build user-supplied exclusion patterns (whitespace- or colon-separated).
  # Non-anchored patterns (no leading * or /) are auto-prefixed with */ so they
  # match anywhere in the tree, matching the convention of the built-in excludes.
  local -a _user_excludes=()
  if [[ -n "${EXCLUDE_FILE_GLOB:-}" ]]; then
    local -a _patterns=()
    local _old_ifs="$IFS"
    IFS=$' \t\n:'
    read -ra _patterns <<< "$EXCLUDE_FILE_GLOB"
    IFS="$_old_ifs"
    local _pattern
    for _pattern in "${_patterns[@]}"; do
      [[ -z "$_pattern" ]] && continue
      if [[ "$_pattern" != \** && "$_pattern" != /* ]]; then
        _pattern="*/$_pattern"
      fi
      _user_excludes+=(-x "$_pattern")
    done
  fi

  do_log "INFO ========================================"
  do_log "INFO Zipping : $src_dir"
  do_log "INFO Org/App : ${_org} / ${_app}"
  do_log "INFO Output  : $zip_file"
  if (( ${#_user_excludes[@]} > 0 )); then
    do_log "INFO User excludes: ${_user_excludes[*]}"
  fi
  do_log "INFO ========================================"

  cd / || {
    do_log "ERROR Cannot cd to /"
    return 11
  }

  # INVARIANT: -y stores symlinks as symlink entries (never follows into /var).
  # If this flag is removed, the post-zip audit below will refuse the archive.
  zip -ry "$zip_file" "${src_dir#/}" \
    -x '*/.git/*'         \
    -x '*/__pycache__/*'  \
    -x '*/.venv/*'        \
    -x '*/dat/log/*'      \
    -x '*/dat/tmp/*'      \
    -x '*/dat/out/*'      \
    -x '*/dat/html/*'     \
    -x '*/dat/zip/*'      \
    -x '*/node_modules/*' \
    -x '*/.terraform/*'   \
    -x '*/dist/*'         \
    -x '*/build/*'        \
    -x '*.zip'            \
    -x '*.gpg'            \
    -x '*CLAUDE*'         \
    -x '*PROMPTS*'        \
    -x '*/doc/img/*'      \
    -x '*/doc/pdf/*'      \
    -x '*/img-prompts/*'  \
    "${_user_excludes[@]}" || {
    do_log "ERROR Failed to create zip: $zip_file"
    return 11
  }

  # INVARIANT AUDIT: no data file (>0 bytes) may reside under doc/img/ or doc/pdf/.
  # These subtrees are symlinks into /var/ — binaries there mean -y was removed
  # or an exclusion pattern was bypassed. Fail hard, delete the unsafe archive.
  local leak
  leak=$(unzip -l "$zip_file" 2>/dev/null | awk '$1 ~ /^[0-9]+$/ && $1 > 0 {print}' | grep -E 'doc/(img|pdf)/' || true)
  if [[ -n "$leak" ]]; then
    do_log "FATAL /var/ binary leak detected in source zip: $zip_file"
    do_log "FATAL $leak"
    do_log "FATAL Source zips must not contain runtime content. Use do_zip_doc_proj for doc bundles."
    rm -f "$zip_file"
    return 11
  fi
  do_log "OK  invariant audit passed: no /var/-bound binaries in source zip"

  local file_count
  file_count=$(unzip -l "$zip_file" 2>/dev/null | tail -1 | awk '{print $2}')
  local zip_size
  zip_size=$(du -h "$zip_file" | cut -f1)

  do_log "INFO Files archived : $file_count"
  do_log "INFO Zip size       : $zip_size"
  do_log "OK  Backup created  : $zip_file"

  local win_path
  win_path=$(perl -ne 's|^/mnt/([a-z])/|uc($1).":\\"|e;s|/|\\|g;print' <<< "$zip_file")
  do_log "INFO Produced (Unix):    $zip_file"
  do_log "INFO Produced (Windows): ${win_path//\\/\\\\}"
  echo "$zip_file"
  echo "$win_path"
}
# doc-hub ::: v1.0.0
# run-bsh ::: v3.8.2
