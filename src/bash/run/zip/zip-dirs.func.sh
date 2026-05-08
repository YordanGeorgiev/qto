#!/bin/bash
#------------------------------------------------------------------------------
# @description Zip multiple directories into a single timestamped archive.
# @description Accepts a comma-separated list of absolute paths via SRC_DIRS.
# @description Paths are stored relative to BASE_DIR so that on the target box
# @description do_unzip_deploy restores them under / (e.g. /opt/csi/doc-hub).
# @description Version is read from <BASE_DIR>opt/<org>/<app>/.version.
# @param SRC_DIRS (required) - Comma-separated list of absolute paths to include
# @param BASE_DIR (optional) - Path prefix to strip; default: / . Set to /mnt/c/Temp/
#                               so that /mnt/c/Temp/opt/csi/doc-hub is stored as opt/csi/doc-hub
# @param DST_DIR (optional) - Override output directory; default: <BASE_DIR>/var/<org>/<app>/<app>-all/dat/zip
# @param ZIP_NAME (optional) - Override base name for the zip file; default: derived from app segment
# @param EXCLUDE_FILE_GLOB (optional) - Extra zip exclusion glob(s); whitespace- or colon-separated
# @example SRC_DIRS=/opt/csi/doc-hub,/var/csi/doc-hub ./run -a do_zip_dirs
# @example BASE_DIR=/mnt/c/Temp/ SRC_DIRS=/mnt/c/Temp/opt/csi/doc-hub,/mnt/c/Temp/var/csi/doc-hub ./run -a do_zip_dirs
# @example SRC_DIRS=/opt/csi/doc-hub,/var/csi/doc-hub DST_DIR=/tmp/zips ./run -a do_zip_dirs
# @example SRC_DIRS=/opt/csi/doc-hub ZIP_NAME=doc-hub-src ./run -a do_zip_dirs
# @output Creates <DST_DIR>/<ZIP_NAME>.<version>.<timestamp>.zip
# @arg --src-dirs SRC_DIRS
# @arg --base-dir BASE_DIR
# @arg --dst-dir DST_DIR
# @arg --zip-name ZIP_NAME
#------------------------------------------------------------------------------
do_zip_dirs() {
  do_require_bin zip unzip perl

  local src_dirs="${SRC_DIRS:?SRC_DIRS is required — comma-separated absolute paths, e.g. SRC_DIRS=/opt/csi/doc-hub,/var/csi/doc-hub}"
  local base_dir="${BASE_DIR:-/}"
  # Normalize: ensure exactly one trailing slash
  base_dir="${base_dir%/}/"

  # Split comma-separated dirs into array
  local -a dirs=()
  IFS=',' read -ra dirs <<< "$src_dirs"

  if [[ ${#dirs[@]} -eq 0 ]]; then
    do_log "ERROR SRC_DIRS is empty"
    return 11
  fi

  # Validate all directories exist and start with BASE_DIR
  local d
  for d in "${dirs[@]}"; do
    d="${d%/}"
    if [[ ! -d "$d" ]]; then
      do_log "ERROR Directory not found: $d"
      return 11
    fi
    if [[ "$d/" != "${base_dir}"* ]]; then
      do_log "ERROR Directory '$d' is not under BASE_DIR '${base_dir}'"
      do_log "ERROR All SRC_DIRS must start with BASE_DIR"
      return 11
    fi
  done

  # Derive org and app from the first directory by finding the opt/ or var/ anchor
  # after stripping BASE_DIR. E.g. /mnt/c/Temp/opt/csi/doc-hub → opt/csi/doc-hub
  local _first="${dirs[0]%/}"
  local _rel="${_first#${base_dir}}"  # strip BASE_DIR prefix
  local _org _app
  if [[ "$_rel" =~ ^(opt|var)/([^/]+)/([^/]+) ]]; then
    _org="${BASH_REMATCH[2]}"
    _app="${BASH_REMATCH[3]}"
  else
    do_log "FATAL Cannot parse org/app from relative path: $_rel"
    do_log "FATAL Expected: (opt|var)/<org>/<app>[/<variant>] after stripping BASE_DIR=${base_dir}"
    return 1
  fi

  # Output directory: under BASE_DIR/var/<org>/<app>/<app>-all/dat/zip
  local zip_dir="${DST_DIR:-${base_dir}var/${_org}/${_app}/${_app}-all/dat/zip}"
  local ts
  ts=$(date +"%Y%m%d_%H%M%S")

  # Read version from the application root: <base_dir>opt/<org>/<app>/.version
  # (e.g. /opt/csi/doc-hub/.version). Single source of truth, no per-subdir lookup.
  local _version=""
  local _version_file="${base_dir}opt/${_org}/${_app}/.version"
  if [[ -f "$_version_file" ]]; then
    _version=$(tr -d '[:space:]' < "$_version_file") || true
    do_log "INFO Version (from ${_version_file}): ${_version:-<empty>}"
  else
    do_log "WARN Version file not found: ${_version_file} — zip will be unversioned"
  fi

  local _basename="${ZIP_NAME:-${_app}}"
  local zip_file="${zip_dir}/${_basename}${_version:+.${_version}}.${ts}.zip"

  sudo mkdir -p "$zip_dir" && sudo chown -R "$(id -un):$(id -gn)" "$zip_dir" 2>/dev/null || \
    mkdir -p "$zip_dir" || {
      do_log "ERROR Cannot create output directory: $zip_dir"
      return 11
    }

  # Build user-supplied exclusion patterns
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
  do_log "INFO Zipping directories:"
  for d in "${dirs[@]}"; do
    do_log "INFO   - ${d%/}"
  done
  do_log "INFO BASE_DIR: ${base_dir}"
  do_log "INFO Org/App : ${_org} / ${_app}"
  do_log "INFO Output  : $zip_file"
  if (( ${#_user_excludes[@]} > 0 )); then
    do_log "INFO User excludes: ${_user_excludes[*]}"
  fi
  do_log "INFO ========================================"

  # cd to BASE_DIR so paths inside the zip are relative to it
  cd "$base_dir" || {
    do_log "ERROR Cannot cd to BASE_DIR: $base_dir"
    return 11
  }

  # Build the list of paths relative to BASE_DIR
  local -a _zip_targets=()
  for d in "${dirs[@]}"; do
    d="${d%/}"
    _zip_targets+=("${d#${base_dir}}")
  done

  # INVARIANT: -y stores symlinks as symlink entries (never follows).
  zip -ry "$zip_file" "${_zip_targets[@]}" \
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

  local file_count
  file_count=$(unzip -l "$zip_file" 2>/dev/null | tail -1 | awk '{print $2}')
  local zip_size
  zip_size=$(du -h "$zip_file" | cut -f1)

  do_log "INFO Files archived : $file_count"
  do_log "INFO Zip size       : $zip_size"
  do_log "OK  Backup created  : $zip_file"

  # Show a few entries to confirm path structure
  do_log "INFO Archive path sample:"
  unzip -l "$zip_file" 2>/dev/null | awk 'NR>3 && $NF ~ /\/$/ {print "INFO   " $NF}' | head -6 | while read -r line; do
    do_log "$line"
  done

  local win_path
  win_path=$(perl -ne 's|^/mnt/([a-z])/|uc($1).":\\"|e;s|/|\\|g;print' <<< "$zip_file")
  do_log "INFO Produced (Unix):    $zip_file"
  do_log "INFO Produced (Windows): ${win_path//\\/\\\\}"
  echo "$zip_file"
  echo "$win_path"
}
# run-bsh ::: v3.8.2
