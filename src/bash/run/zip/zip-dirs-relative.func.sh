#!/bin/bash
#------------------------------------------------------------------------------
# @description Zip the CONTENTS of multiple directories into a single timestamped
# @description archive with paths stored relative to each SRC_DIR (not to BASE_DIR).
# @description Equivalent in interface to do_zip_dirs, but the archive entries
# @description start at the children of each SRC_DIR — i.e. for each SRC_DIR_N
# @description it does the equivalent of `cd SRC_DIR_N && zip -ry $ZIP .`.
# @description Use this when you want to extract the archive at an arbitrary
# @description destination without recreating the original `/opt/<org>/<app>/...`
# @description (or `/var/...`) path tree.
# @description
# @description Output path / zip name / version are derived the same way as
# @description do_zip_dirs (BASE_DIR-relative parsing of opt/<org>/<app>) so the
# @description two actions land their output in the same place by default.
# @description
# @param SRC_DIRS (required) - Comma-separated list of absolute paths whose
#                              CONTENTS will be zipped. Each is cd'd into and
#                              zipped with `.` so entries are stored relative
#                              to that dir.
# @param BASE_DIR (optional) - Path prefix used only for output-path /
#                              version-file derivation (default: /). The zip
#                              entries themselves are NOT relative to BASE_DIR.
# @param DST_DIR  (optional) - Override output directory; default:
#                              <BASE_DIR>/var/<org>/<app>/<app>-all/dat/zip
# @param ZIP_NAME (optional) - Override base name for the zip file; default:
#                              <app>-relative
# @param EXCLUDE_FILE_GLOB (optional) - Extra zip exclusion glob(s);
#                                       whitespace- or colon-separated.
#                                       Matches anywhere in the tree.
# @param EXCLUDE_PATHS     (optional) - Comma-separated paths to exclude
#                                       relative to each SRC_DIR (top-level
#                                       only — e.g. ".version,README.md")
# @example SRC_DIRS=/opt/csi/doc-hub/doc-hub-con ./run -a do_zip_dirs_relative
# @example SRC_DIRS=/opt/csi/doc-hub/doc-hub-con,/var/csi/doc-hub/doc-hub-con/dat ./run -a do_zip_dirs_relative
# @example SRC_DIRS=/opt/csi/doc-hub ZIP_NAME=doc-hub-content ./run -a do_zip_dirs_relative
# @output Creates <DST_DIR>/<ZIP_NAME>.<version>.<timestamp>.zip with archive
# @output entries that START AT EACH SRC_DIR'S CHILDREN (no opt/csi/... prefix).
# @arg --src-dirs       SRC_DIRS
# @arg --exclude-paths  EXCLUDE_PATHS
# @arg --base-dir BASE_DIR
# @arg --dst-dir  DST_DIR
# @arg --zip-name ZIP_NAME
#------------------------------------------------------------------------------
do_zip_dirs_relative() {
  do_require_bin zip unzip perl

  local src_dirs="${SRC_DIRS:?SRC_DIRS is required — comma-separated absolute paths, e.g. SRC_DIRS=/opt/csi/doc-hub/doc-hub-con,/var/csi/doc-hub/doc-hub-con/dat}"
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

  # Validate all directories exist; under do_zip_dirs_relative we do NOT
  # require them to live under BASE_DIR — BASE_DIR is only used to derive
  # the default DST_DIR / version file. The first SRC_DIR is still parsed
  # against BASE_DIR for that derivation; further SRC_DIRs may live anywhere.
  local d
  for d in "${dirs[@]}"; do
    d="${d%/}"
    if [[ ! -d "$d" ]]; then
      do_log "ERROR Directory not found: $d"
      return 11
    fi
  done

  # Derive org and app from the FIRST directory by finding the opt/ or var/
  # anchor after stripping BASE_DIR. Fall back to first dir's basename when
  # the first SRC_DIR does not sit under BASE_DIR (so this action also works
  # for ad-hoc dirs unrelated to the opt/<org>/<app> tree).
  local _first="${dirs[0]%/}"
  local _rel="${_first#${base_dir}}"
  local _org="" _app=""
  if [[ "$_first/" == "${base_dir}"* && "$_rel" =~ ^(opt|var)/([^/]+)/([^/]+) ]]; then
    _org="${BASH_REMATCH[2]}"
    _app="${BASH_REMATCH[3]}"
  else
    _app=$(basename "$_first")
    do_log "WARN First SRC_DIR is not under BASE_DIR=${base_dir} or not in opt|var/<org>/<app>/... layout"
    do_log "WARN Falling back to ZIP_NAME defaulting to '$_app' and DST_DIR=\$PWD"
  fi

  # Output directory: under BASE_DIR/var/<org>/<app>/<app>-all/dat/zip when
  # org/app are known, otherwise $PWD.
  local _default_dst
  if [[ -n "$_org" && -n "$_app" ]]; then
    _default_dst="${base_dir}var/${_org}/${_app}/${_app}-all/dat/zip"
  else
    _default_dst="$PWD"
  fi
  local zip_dir="${DST_DIR:-$_default_dst}"
  local ts
  ts=$(date +"%Y%m%d_%H%M%S")

  # Read version from the application root: <base_dir>opt/<org>/<app>/.version
  local _version=""
  if [[ -n "$_org" && -n "$_app" ]]; then
    local _version_file="${base_dir}opt/${_org}/${_app}/.version"
    if [[ -f "$_version_file" ]]; then
      _version=$(tr -d '[:space:]' < "$_version_file") || true
      do_log "INFO Version (from ${_version_file}): ${_version:-<empty>}"
    else
      do_log "WARN Version file not found: ${_version_file} — zip will be unversioned"
    fi
  fi

  local _basename="${ZIP_NAME:-${_app}-relative}"
  local zip_file="${zip_dir}/${_basename}${_version:+.${_version}}.${ts}.zip"

  sudo mkdir -p "$zip_dir" && sudo chown -R "$(id -un):$(id -gn)" "$zip_dir" 2>/dev/null || \
    mkdir -p "$zip_dir" || {
      do_log "ERROR Cannot create output directory: $zip_dir"
      return 11
    }

  # Build user-supplied exclusion patterns (same shape as do_zip_dirs)
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
  if [[ -n "${EXCLUDE_PATHS:-}" ]]; then
    # EXCLUDE_PATHS is comma-separated, top-level only (relative to SRC_DIR)
    local -a _epaths=()
    local _old_ifs="$IFS"
    IFS=','
    read -ra _epaths <<< "$EXCLUDE_PATHS"
    IFS="$_old_ifs"
    local _ep
    for _ep in "${_epaths[@]}"; do
      # Trim whitespace
      _ep="${_ep#"${_ep%%[![:space:]]*}"}"
      _ep="${_ep%"${_ep##*[![:space:]]}"}"
      [[ -z "$_ep" ]] && continue
      if [[ "$_ep" != ./* && "$_ep" != /* ]]; then
        _ep="./$_ep"
      fi
      _user_excludes+=(-x "$_ep")
    done
  fi

  do_log "INFO ========================================"
  do_log "INFO Zipping (relative) the CONTENTS of:"
  for d in "${dirs[@]}"; do
    do_log "INFO   - ${d%/}/"
  done
  do_log "INFO BASE_DIR: ${base_dir}"
  do_log "INFO Org/App : ${_org:-<n/a>} / ${_app:-<n/a>}"
  do_log "INFO Output  : $zip_file"
  if (( ${#_user_excludes[@]} > 0 )); then
    do_log "INFO User excludes: ${_user_excludes[*]}"
  fi
  [[ -n "${EXCLUDE_PATHS:-}" ]] && do_log "INFO EXCLUDE_PATHS: ${EXCLUDE_PATHS}"
  do_log "INFO ========================================"

  # Make sure we don't append into a pre-existing file with the same name
  rm -f "$zip_file"

  # Core: per SRC_DIR, cd in and zip its contents. Subsequent calls to zip
  # against the same archive append to it. Entries are stored relative to
  # the current dir, i.e. starting at each SRC_DIR's children (no
  # opt/<org>/<app>/... prefix).
  local _i=0
  local _ec=0
  for d in "${dirs[@]}"; do
    d="${d%/}"
    _i=$((_i + 1))
    do_log "INFO [${_i}/${#dirs[@]}] cd $d && zip -ry $(basename "$zip_file") ."
    (
      cd "$d" || exit 11
      # INVARIANT: -y stores symlinks as symlink entries (never follows).
      zip -ry "$zip_file" . \
        -x './__pycache__/*'  \
        -x '*/__pycache__/*'  \
        -x './.venv/*'        \
        -x '*/.venv/*'        \
        -x './dat/log/*'      \
        -x '*/dat/log/*'      \
        -x './dat/tmp/*'      \
        -x '*/dat/tmp/*'      \
        -x './dat/out/*'      \
        -x '*/dat/out/*'      \
        -x './dat/html/*'     \
        -x '*/dat/html/*'     \
        -x './dat/zip/*'      \
        -x '*/dat/zip/*'      \
        -x './node_modules/*' \
        -x '*/node_modules/*' \
        -x './.terraform/*'   \
        -x '*/.terraform/*'   \
        -x './dist/*'         \
        -x '*/dist/*'         \
        -x './build/*'        \
        -x '*/build/*'        \
        -x '*.zip'            \
        -x '*.gpg'            \
        -x '*CLAUDE*'         \
        -x '*PROMPTS*'        \
        -x './doc/img/*'      \
        -x '*/doc/img/*'      \
        -x './doc/pdf/*'      \
        -x '*/doc/pdf/*'      \
        -x './img-prompts/*'  \
        -x '*/img-prompts/*'  \
        "${_user_excludes[@]}"
    )
    _ec=$?
    # zip exit 12 = "nothing to do" (e.g. fully-excluded or empty dir) —
    # treat as a warning so a single empty SRC_DIR doesn't fail the batch.
    if [[ $_ec -ne 0 && $_ec -ne 12 ]]; then
      do_log "ERROR Failed adding contents of $d to zip (zip exit $_ec)"
      return 11
    elif [[ $_ec -eq 12 ]]; then
      do_log "WARN  Nothing to add from $d (zip exit 12) — skipping"
    fi
  done

  if [[ ! -f "$zip_file" ]]; then
    do_log "ERROR No archive produced — every SRC_DIR was empty or fully excluded"
    return 11
  fi

  local file_count
  file_count=$(unzip -l "$zip_file" 2>/dev/null | tail -1 | awk '{print $2}')
  local zip_size
  zip_size=$(du -h "$zip_file" | cut -f1)

  do_log "INFO Files archived : $file_count"
  do_log "INFO Zip size       : $zip_size"
  do_log "OK  Backup created  : $zip_file"

  # Show a few entries to confirm path structure (top-level dir entries)
  do_log "INFO Archive path sample (top-level dirs — relative to each SRC_DIR):"
  unzip -l "$zip_file" 2>/dev/null \
    | awk 'NR>3 && $NF ~ /\/$/ {print $NF}' \
    | awk -F/ 'NF<=2 {print}' \
    | head -10 \
    | while read -r line; do
        do_log "INFO   $line"
      done

  local win_path
  win_path=$(perl -ne 's|^/mnt/([a-z])/|uc($1).":\\"|e;s|/|\\|g;print' <<< "$zip_file")
  do_log "INFO Produced (Unix):    $zip_file"
  do_log "INFO Produced (Windows): ${win_path//\\/\\\\}"
  echo "$zip_file"
  echo "$win_path"
}
# run-bsh ::: v3.8.2
