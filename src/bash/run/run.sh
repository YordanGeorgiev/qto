#!/bin/bash
#
# Minimalistic run.sh framework
# usage: ./run --help

# Ensure ERR trap is inherited by functions
set -E

# Global Error Handler
error_handler() {
  local exit_code=$?
  local line_no=$1
  local cmd="$2"
  # Suppress FATAL message if the exit code is 11 (intentional validation failure)
  if [[ $exit_code -ne 11 ]]; then
    do_log "FATAL Command '$cmd' failed at line $line_no with status $exit_code."
  fi
  exit $exit_code
}

# Execution Wrapper
execute_step() {
  local func_name=$1
  shift
  local args=("$@")

  # 1. Run PRE hook if exists
  if type "${func_name}_pre" &>/dev/null; then
    do_log "INFO START ::: running PRE hook  :: ${func_name}_pre"
    "${func_name}_pre" "${args[@]}"
    do_log "INFO STOP  ::: running PRE hook  :: ${func_name}_pre"
  fi

  do_log "INFO START ::: running action    :: $func_name"

  # 1. Run ARGS hook if exists (Decentralized parsing)
  if type "${func_name}_args" &>/dev/null; then
    do_log "DEBUG Running ARGS hook for: $func_name"
    "${func_name}_args" "${args[@]}" || return $?
  fi

  # Parse @arg metadata: map --flag value pairs to env vars
  local func_file="${_func_to_file[$func_name]:-}"
  if [[ -n "$func_file" && ${#args[@]} -gt 0 ]]; then
    local _arg_lines
    _arg_lines=$(do_parse_metadata "$func_file" "arg" 2>/dev/null)
    if [[ -n "$_arg_lines" ]]; then
      # Build associative array of flag→var mappings
      declare -A _arg_map
      while IFS= read -r _aline; do
        local _adef="${_aline#arg=}"
        local _aflag _avar
        _aflag=$(echo "$_adef" | awk '{print $1}')
        _avar=$(echo "$_adef" | awk '{print $2}')
        [[ -n "$_aflag" && -n "$_avar" ]] && _arg_map["$_aflag"]="$_avar"
      done <<< "$_arg_lines"
      # Parse CLI args against the map. Boolean support: a known flag
      # followed by end-of-args or another --flag is treated as a true bool.
      local _i=0
      while [[ $_i -lt ${#args[@]} ]]; do
        local _flag="${args[$_i]}"
        if [[ "$_flag" == --* && -n "${_arg_map[$_flag]:-}" ]]; then
          local _var="${_arg_map[$_flag]}"
          local _next=""
          (( _i + 1 < ${#args[@]} )) && _next="${args[$_i + 1]}"
          if [[ -n "$_next" && "$_next" != --* ]]; then
            export "$_var"="$_next"
            do_log "DEBUG Parsed: $_flag $_next → $_var=$_next"
            _i=$((_i + 2))
            continue
          else
            export "$_var"="true"
            do_log "DEBUG Parsed: $_flag (boolean) → $_var=true"
            _i=$((_i + 1))
            continue
          fi
        fi
        _i=$((_i + 1))
      done
      unset _arg_map
    fi
  fi

  # Validate required @param metadata before running (if available)
  if [[ -n "$func_file" ]] && type do_validate_params &>/dev/null; then
    do_validate_params "$func_file"
    local _vp_rc=$?
    if [[ $_vp_rc -ne 0 ]]; then
      return $_vp_rc
    fi
  fi

  # Run the function
  # We temporarily disable the global ERR trap to ensure POST hook can run even on failure
  trap - ERR
  "$func_name" "${args[@]}"
  local exit_status=$?
  trap 'error_handler ${LINENO} "$BASH_COMMAND"' ERR

  if [[ $exit_status -eq 0 ]]; then
    do_log "INFO STOP  ::: running function  :: $func_name"
  else
    do_log "ERROR Action failed with status $exit_status"
  fi

  # 2. Run POST hook if exists (guaranteed cleanup)
  if type "${func_name}_post" &>/dev/null; then
    do_log "INFO START ::: running POST hook :: ${func_name}_post"
    "${func_name}_post" "${args[@]}"
    do_log "INFO STOP  ::: running POST hook :: ${func_name}_post"
  fi

  # If the main action failed, now trigger the error handler
  if [[ $exit_status -ne 0 ]]; then
    error_handler "$LINENO" "$func_name"
  fi

  return $exit_status
}

trap 'error_handler ${LINENO} "$BASH_COMMAND"' ERR

main() {
  do_flush_screen
  do_set_vars "$@"
  ts=$(date "+%Y%m%d_%H%M%S")
  main_log_dir=~/var/log/${PROJ:-run.sh}/
  mkdir -p $main_log_dir
  main_exec "$@" \
    > >(tee $main_log_dir/${RUN_UNIT:-run.sh}.$ts.out.log) \
    2> >(tee $main_log_dir/${RUN_UNIT:-run.sh}.$ts.err.log)
  exit $?
}

main_exec() {
  local args=("$@")
  do_load_functions
  do_detect_base_paths
  do_load_config
  do_require_bins
  do_verify_symlinks
  test -z "${actions:-}" && actions=' do_print_help '
  do_run_actions "$actions" "${args[@]:2}"
  local _run_rc=$?
  do_finalize "$_run_rc"
  return $_run_rc
}

# Framework core dependencies
do_require_bins() {
  # Core run.sh requirements
  do_require_bin perl find sed awk hostname date tee mkdir
}

# Legacy get_function_list — kept for backward compatibility with any
# external callers.  No longer used in the hot path; the optimised
# do_load_functions builds the _func_to_file map from filename conventions.
get_function_list() {
  env -i PATH=/bin:/usr/bin:/usr/local/bin bash --noprofile --norc -c '
      source "'"$1"'"
      typeset -f |
      grep '\''^[^{} ].* () $'\'' |
      awk "{print \$1}" |
      while read -r fnc_name; do
         type "$fnc_name" | head -n 1 | grep -q "is a function$" || continue
            echo "$fnc_name"
            done
            '
}

do_read_cmd_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
    -a | --actions) shift && actions="${actions:-}${1:-} " && shift ;;
    -h | --help) actions=' do_print_help ' && ENV='dev' && shift ;;
    *) shift ;;  # Pass unrecognized arguments to the functions
    esac
  done
}

# Optimised action dispatcher: looks up pre-built _func_to_file map
# instead of spawning find + get_function_list subprocesses per action.
do_run_actions() {
  actions=$1
  local args=("${@:2}")
  actions_found=0
  cd ${PROJ_PATH:-}
  actions="$(echo -e "${actions}" | tr " " "\n" | sed -e '/^$/d')"
  run_funcs=''
  do_log "DEBUG do_run_actions: actions=$actions, args=${args[*]}"
  while read -r arg_action; do
    # Normalise to do_snake_case
    local lookup="$arg_action"
    [[ "$lookup" != do_* ]] && lookup="do_${lookup//-/_}"
    lookup="${lookup//-/_}"

    if [[ -n "${_func_to_file[$lookup]:-}" ]]; then
      actions_found=$((actions_found + 1))
      run_funcs="$(echo -e "${run_funcs}\n$lookup")"
    fi
  done < <(echo "$actions")

  do_log "DEBUG actions_found=$actions_found"
  test $actions_found -eq 0 && {
    do_log "FATAL action(s) requested: \"$actions\" NOT found !!!"
    do_log "FATAL 1. check the spelling of your action"
    do_log "FATAL 2. check the available actions by: ./run --help"
    do_log "FATAL the run failed !"
    exit 1
  }

  run_funcs="$(echo -e "${run_funcs}" | sed -e 's/^[[:space:]]*//;/^$/d')"
  local _final_rc=0
  while read -r run_func; do
    cd ${PROJ_PATH:-}
    execute_step "$run_func" "${args[@]}"
    local _step_rc=$?
    (( _step_rc != 0 )) && _final_rc=$_step_rc
  done < <(echo "$run_funcs")
  return $_final_rc
}


do_flush_screen() {
  printf "\033[2J"
  printf "\033[0;0H"
}

do_log() {
  print_ok() {
    GREEN_COLOR="\033[0;32m"
    DEFAULT_COLOR="\033[0m"
    echo -e "${GREEN_COLOR} ✔ ${1:-} ${DEFAULT_COLOR}"
  }

  print_warning() {
    YELLOW_COLOR="\033[33m"
    DEFAULT_COLOR="\033[0m"
    echo -e "${YELLOW_COLOR} ⚠ ${1:-} ${DEFAULT_COLOR}"
  }

  print_info() {
    BLUE_COLOR="\033[0;34m"
    DEFAULT_COLOR="\033[0m"
    echo -e "${BLUE_COLOR} ℹ ${1:-} ${DEFAULT_COLOR}"
  }


  print_debug() {
    CYAN_COLOR="\033[0;36m"
    DEFAULT_COLOR="\033[0m"
    echo -e "${CYAN_COLOR} ⚙ ${1:-} ${DEFAULT_COLOR}"
  }

  print_fail() {
    RED_COLOR="\033[0;31m"
    DEFAULT_COLOR="\033[0m"
    echo -e "${RED_COLOR} ❌ [NOK] ${1:-}${DEFAULT_COLOR}"
  }

  print_fatal() {
    RED_COLOR="\033[0;31m"
    DEFAULT_COLOR="\033[0m"
    echo -e "${RED_COLOR} 💣 [FATAL] ${1:-}${DEFAULT_COLOR}"
  }

  type_of_msg=$(echo $* | cut -d" " -f1)
  action=$(echo $* | cut -d" " -f2)
  rest_of_msg=$(echo $* | cut -d" " -f3-)

  local display_type="${type_of_msg/WARNING/WARN}"
  local type_padded
  type_padded=$(printf "%-7s" "[$display_type]")

  if [[ "$action" == "START" || "$action" == "STOP" ]]; then
    formatted_action=$(printf "%-5s" "$action")
    msg=" $type_padded $(date "+%Y-%m-%d %H:%M:%S %Z") [${PROJ:-}][@${HOST_NAME:-}] [$$] $formatted_action $rest_of_msg"
  else
    msg=" $type_padded $(date "+%Y-%m-%d %H:%M:%S %Z") [${PROJ:-}][@${HOST_NAME:-}] [$$] $action $rest_of_msg"
  fi

  local _log_dir
  if [[ -n "${LOG_DIR:-}" ]]; then
    _log_dir="$LOG_DIR"
    mkdir -p "$_log_dir" 2>/dev/null || true
  elif [[ -n "${PROJ:-}" && -n "${ORG:-}" && -n "${APP:-}" ]]; then
    _log_dir="${VAR_DIR:-/var}/${ORG}/${APP}/${PROJ}/dat/log/bash"
    if ! mkdir -p "$_log_dir" 2>/dev/null; then
      _log_dir="${PROJ_PATH:-$(pwd)}/dat/log/bash"
      mkdir -p "$_log_dir" 2>/dev/null || true
    fi
  else
    _log_dir="${PROJ_PATH:-$(pwd)}/dat/log/bash"
    mkdir -p "$_log_dir" 2>/dev/null || true
  fi
  log_dir="$_log_dir"
  export LOG_DIR="$log_dir"
  log_file="$log_dir/${PROJ:-run}."$(date "+%Y%m%d")'.log'

  case "$type_of_msg" in
  'FATAL') print_fatal "$msg" | tee -a $log_file ;;
  'ERROR') print_fail "$msg" | tee -a $log_file ;;
  'WARNING'|'WARN') print_warning "$msg" | tee -a $log_file ;;
  'INFO') print_info "$msg" | tee -a $log_file ;;
  'OK')    print_ok    "$msg" | tee -a $log_file ;;
  'DEBUG') print_debug "$msg" | tee -a $log_file ;;
  *) echo "$msg" | tee -a $log_file ;;
  esac
}

do_set_vars() {
  set -u -o pipefail
  do_read_cmd_args "$@"
  unit_run_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
  declare -gx RUN_UNIT="$(cd "${unit_run_dir:-}" && basename "$(pwd)").sh" && export RUN_UNIT
  declare -gx PROJ_PATH="$(cd "${unit_run_dir:-}/../../.." && pwd)" && export PROJ_PATH
  declare -gx APP_PATH="$(cd "${unit_run_dir:-}/../../../.." && pwd)" && export APP_PATH
  declare -gx ORG_APP_PATH="${APP_PATH}" && export ORG_APP_PATH
  declare -gx ORG_PATH="$(cd "${unit_run_dir:-}/../../../../.." && pwd)" && export ORG_PATH
  declare -gx BASE_PATH="$(cd "${unit_run_dir:-}/../../../../../.." && pwd)" && export BASE_PATH
  _above_base=$(dirname "${BASE_PATH}") && declare -gx VAR_DIR="${VAR_DIR:-${_above_base%/}/var}" && export VAR_DIR
  # Detect framework layer: if parent of PROJ_PATH matches *-frw, expose it as FRW_PATH
  _frw_candidate="$(dirname "${PROJ_PATH}")"
  if [[ "$(basename "${_frw_candidate}")" == *-frw ]]; then
    declare -gx FRW_PATH="${_frw_candidate}" && export FRW_PATH
  else
    declare -gx FRW_PATH="" && export FRW_PATH
  fi
  do_ensure_logical_link
  # Path-derived building blocks. Env override wins; otherwise derived from the
  # canonical layout: BASE_PATH/ORG/APP/APP-PROJ_KIND.
  declare -gx ORG="${ORG:-$(basename "${ORG_PATH}")}" && export ORG
  declare -gx APP="${APP:-$(basename "${APP_PATH}")}" && export APP
  declare -gx PROJ="$(basename "${PROJ_PATH:-}")" && export PROJ
  declare -gx PROJ_KIND="${PROJ_KIND:-${PROJ#${APP}-}}" && export PROJ_KIND

  declare -gx USER="${USER:-$(id -un)}" && export USER
  declare -gx HOST_NAME="$(hostname -s)" && export HOST_NAME
  declare -gx LOG_DIR="" && export LOG_DIR
}

do_ensure_logical_link() {
  if [[ "${unit_run_dir:-}" != */src/bash/run ]]; then
    export PROJ_PATH=$(cd $unit_run_dir && echo $(pwd))
  fi
}

do_finalize() {
  local _rc="${1:-$?}"
  do_log "INFO OK $RUN_UNIT's run completed"
  return "$_rc"
}

# Optimised function loader: sources all *.func.sh files once and builds
# a global associative array (_func_to_file) mapping each do_* function
# name to its source file.  Discovery is a single recursive `find` across
# lib/bash/funcs/ and src/bash/run/, so any subdirectory under
# src/bash/run/ (e.g. src/bash/run/zip/, src/bash/run/morph/,
# src/bash/run/test/, src/bash/run/help/) is picked up automatically — no
# need to list subdirs explicitly.  Function names are derived from the
# filename convention (kebab-case.func.sh → do_snake_case) instead of
# spawning a subprocess per file via get_function_list.
# Convention: node-jira-bind.func.sh MUST define do_node_jira_bind().
do_load_functions() {
  declare -gA _func_to_file
  local f fname func_name
  local search_dirs=()

  # Scan only dirs that exist (avoids `find` printing errors for missing trees).
  [[ -d "${PROJ_PATH:-}/lib/bash/funcs" ]] && search_dirs+=("${PROJ_PATH}/lib/bash/funcs")
  [[ -d "${PROJ_PATH:-}/src/bash/run" ]]   && search_dirs+=("${PROJ_PATH}/src/bash/run")
  (( ${#search_dirs[@]} == 0 )) && return

  while IFS= read -r -d "" f; do
    source "$f"
    # Derive function name: kebab-case.func.sh → do_snake_case
    fname="$(basename "$f" .func.sh)"
    # Skip pre/post hooks from primary action registration
    [[ "$fname" == *".pre" || "$fname" == *".post" ]] && continue

    func_name="do_${fname//-/_}"
    # Register only if the function actually exists after sourcing
    if declare -f "$func_name" &>/dev/null; then
      _func_to_file["$func_name"]="$f"
    fi
  done < <(find "${search_dirs[@]}" -type f -name "*.func.sh" -print0 2>/dev/null | sort -z)
}

quit_on(){
  rv=$?
  if [ $rv -ne 0 ]; then
    do_log "FATAL Error: Failed to $1"
    exit $rv
  fi
}

main "$@"

#==============================================================================
# run.sh — minimalistic bash framework
# Version:  3.8.0
# Upstream: https://github.com/csitea/run-bsh
#------------------------------------------------------------------------------
# Version history (newest first):
#   3.8.0  2026-04-30  Sync framework primitives from app-edw-utl: write-probe
#                      in do_detect_base_paths (more reliable than -w on some
#                      FUSE/NFS filesystems); path-derived LOG_DIR formula in
#                      do_log (both lib/bash/funcs/log.func.sh and run.sh
#                      inline copy) — removes hardcoded /var/csi/run-bsh/
#                      run-bsh-utl literal so logs land at
#                      \${VAR_DIR}/\${ORG}/\${APP}/\${PROJ}/dat/log/bash for
#                      whichever project clones this framework; +docker hint
#                      in do_require_bin install map.
#   3.7.0  2026-04-30  Forked back to csitea/run-bsh as a minimal bootstrap.
#                      Slimmed: dropped Make, Docker, Confluence/Jira/GCP
#                      actions; nested under run-bsh-utl/. Imported from
#                      run-bsh-utl: auto-discovered actions, named-args + PRE/
#                      POST hooks, do_load_config, do_detect_base_paths,
#                      do_verify_symlinks, do_help_with, test fixtures.
#   3.6.4  2026-04-30  Sync point with run-bsh-utl (full feature set, downstream).
#   2.x    2024-08     RUN_UNIT var resolution, OS-distro vars hardening
#                      (debian/suse/fedora), do_set_vars_v204 era.
#   1.1    2024-02     do_log split into a truly re-usable helper; DIR -> PATH
#                      naming refactor across the framework (<REDACTED>).
#   1.0.3  2023-01-11  First tagged release: limited support to invoke run from
#                      non-symlink <<PRODUCT_DIR>>/run + do_zip_me + per-distro
#                      set-vars-on-<<os>> hooks.
#
# When copying this file into a downstream project: bump the version above and
# append a new entry describing the local change. Keep the banner intact.
#==============================================================================
# run-bsh ::: v3.8.2
