#!/bin/bash
#------------------------------------------------------------------------------
# @description Validate that required binary/tool is installed and available on PATH.
# @description Provides exact one-liner install commands when tools are missing.
# @description Prevents silent failures or cryptic errors halfway through long-running actions.
# @param bin_names (required) - One or more binary names to check (positional arguments)
# @example do_require_bin jq
# @example do_require_bin jq curl pandoc
# @output Logs FATAL with install instructions for each missing tool
#------------------------------------------------------------------------------
do_require_bin() {
  # Map of known tools to their install commands
  _install_hint() {
    case "$1" in
      jq)      echo "sudo apt-get install -y jq" ;;
      curl)    echo "sudo apt-get install -y curl" ;;
      pandoc)  echo "sudo apt-get install -y pandoc" ;;
      lynx)    echo "sudo apt-get install -y lynx" ;;
      w3m)     echo "sudo apt-get install -y w3m" ;;
      git)     echo "sudo apt-get install -y git" ;;
      python3) echo "sudo apt-get install -y python3" ;;
      pip)     echo "sudo apt-get install -y python3-pip" ;;
      pip3)    echo "sudo apt-get install -y python3-pip" ;;
      node)    echo "sudo apt-get install -y nodejs" ;;
      npm)     echo "sudo apt-get install -y npm" ;;
      docker)  echo "sudo apt-get install -y docker.io" ;;
      zip)     echo "sudo apt-get install -y zip" ;;
      unzip)   echo "sudo apt-get install -y unzip" ;;
      sed)     echo "sudo apt-get install -y sed" ;;
      awk)     echo "sudo apt-get install -y gawk" ;;
      perl)    echo "sudo apt-get install -y perl" ;;
      make)    echo "sudo apt-get install -y make" ;;
      rsync)   echo "sudo apt-get install -y rsync" ;;
      xmllint) echo "sudo apt-get install -y libxml2-utils" ;;
      *)       echo "sudo apt-get install -y $1" ;;
    esac
  }

  if [[ $# -eq 0 ]]; then
    do_log "ERROR do_require_bin called with no arguments"
    return 11
  fi

  local missing=()
  for bin_name in "$@"; do
    if ! command -v "$bin_name" &>/dev/null; then
      missing+=("$bin_name")
    fi
  done

  if [[ ${#missing[@]} -gt 0 ]]; then
    do_log "FATAL Missing required tool(s): ${missing[*]}"
    for bin_name in "${missing[@]}"; do
      do_log "INFO Install $bin_name with: $(_install_hint "$bin_name")"
    done
    if [[ ${#missing[@]} -gt 1 ]]; then
      local all_pkgs="${missing[*]}"
      do_log "INFO Install all at once: sudo apt-get install -y ${all_pkgs}"
    fi
    return 11
  fi
}
# run-bsh ::: v3.8.0
