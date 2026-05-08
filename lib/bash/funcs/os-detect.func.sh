#!/bin/bash
#------------------------------------------------------------------------------
# @description Detect the current OS/shell environment and resolve tool paths.
# @description On Git Bash (Windows), tools under the project bin/ dir are
# @description preferred and automatically resolved with the .exe suffix.
# @description On Linux/WSL, system tools are used as-is.
# @example do_which_os               # prints: linux | wsl | windows-gitbash
# @example do_set_os_env             # sets OS_TYPE, EXE, WIN_BIN_DIR exports
# @example cmd=$(do_resolve_tool curl)
# @example do_set_sudo_vars          # sets SUDO and SUDO_YSG based on OS
#------------------------------------------------------------------------------

# Returns the OS type string: linux | wsl | windows-gitbash | unknown
# Lightweight — safe to call from any script without side effects.
do_which_os() {
  local uname_s
  uname_s=$(uname -s 2>/dev/null || echo "unknown")
  case "$uname_s" in
    MINGW*|MSYS*|CYGWIN*)
      echo "windows-gitbash" ;;
    Linux*)
      if grep -qi microsoft /proc/version 2>/dev/null; then
        echo "wsl"
      else
        echo "linux"
      fi ;;
    Darwin*)
      echo "macos" ;;
    *)
      echo "unknown" ;;
  esac
}

# Sets and exports: OS_TYPE, EXE, WIN_BIN_DIR
# Also prepends project bin/ to PATH on Windows.
do_set_os_env() {
  OS_TYPE=$(do_which_os)
  WIN_BIN_DIR="${PROJ_PATH:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)}/bin"

  case "$OS_TYPE" in
    windows-gitbash)
      EXE=".exe"
      export PATH="${WIN_BIN_DIR}:${PATH}"
      ;;
    *)
      EXE=""
      ;;
  esac

  export OS_TYPE EXE WIN_BIN_DIR
}

# Sets SUDO and SUDO_YSG based on OS and current user.
#   Already root                       : SUDO=""     SUDO_YSG=""
#   Linux/WSL + RELAY_USER exists      : SUDO="sudo" SUDO_YSG="sudo -u ${RELAY_USER}"
#   Linux/WSL + RELAY_USER missing/bad : SUDO="sudo" SUDO_YSG=""   (run as current user)
#   Windows                            : SUDO=""     SUDO_YSG=""
#
# Fallback when RELAY_USER doesn't exist on this box is essential: otherwise
# every ${SUDO_YSG} <cmd> expands to 'sudo -u ysg <cmd>' and fails silently
# with "unknown user: ysg" on boxes where that account isn't provisioned
# (e.g. on tnk/csi <REDACTED> the primary user is <REDACTED>, not ysg).
do_set_sudo_vars() {
  local _os
  _os=$(do_which_os)

  # Already root — sudo is unnecessary and sudo -u <user> may fail
  if [[ "$(id -u)" -eq 0 ]]; then
    SUDO=""
    SUDO_YSG=""
    export SUDO SUDO_YSG
    return
  fi

  case "$_os" in
    windows-gitbash)
      SUDO=""
      SUDO_YSG=""
      ;;
    *)
      SUDO="sudo"
      local _relay_user="${RELAY_USER:-ysg}"
      if id -u "$_relay_user" >/dev/null 2>&1; then
        SUDO_YSG="sudo -u ${_relay_user}"
      else
        # User doesn't exist on this box — fall back to current user (no wrapper)
        SUDO_YSG=""
      fi
      ;;
  esac
  export SUDO SUDO_YSG
}

# Resolve a tool name to the correct binary for the current OS.
# On Windows Git Bash: checks project bin/<tool>.exe first, falls back to system.
# On Linux/WSL: returns the tool name unchanged.
# Usage: local zip_cmd; zip_cmd=$(do_resolve_tool zip)
do_resolve_tool() {
  local tool="$1"
  local os_type
  os_type=$(do_which_os)

  if [[ "$os_type" == "windows-gitbash" ]]; then
    local bin_dir="${WIN_BIN_DIR:-${PROJ_PATH:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)}/bin}"
    local bin_exe="${bin_dir}/${tool}.exe"
    if [[ -f "$bin_exe" ]]; then
      echo "$bin_exe"
      return 0
    fi
    echo "${tool}.exe"
  else
    echo "$tool"
  fi
}
# run-bsh ::: v3.7.0
