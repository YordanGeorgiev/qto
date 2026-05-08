#!/bin/bash
#------------------------------------------------------------------------------
# @description Output messages to both terminal and log file with timestamps and metadata.
# @description Color-codes messages by type (INFO=blue, OK=green, WARNING=yellow, ERROR/FATAL=red).
# @param MESSAGE (required) - Log message prefixed with type: INFO, OK, WARNING, ERROR, FATAL
# @example do_log "INFO Starting process"
# @example do_log "ERROR Something failed"
#------------------------------------------------------------------------------
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
# run-bsh ::: v3.8.0
