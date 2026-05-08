#!/bin/bash
#------------------------------------------------------------------------------
# @description  Framework boot helper — detects and exports BASE_PATH and
# @description  VAR_BASE_PATH. Called from run.sh main_exec before config load.
# @description
# @description  Resolution precedence (each half decided independently):
# @description    1. Explicit env var — if caller already exported, honour it.
# @description    2. Write-probe on /opt (/var) — use it if writable.
# @description    3. Fallback — $HOME/opt ($HOME/var), created on first use.
# @description
# @description  Generic — contains no project-specific names. Any run.sh-based
# @description  project gets the same behaviour.
# @example      BASE_PATH=$HOME/opt ./run -a <action>        # explicit override
# @example      ./run -a <action>                             # auto-detect
#------------------------------------------------------------------------------
do_detect_base_paths() {
  BASE_PATH="${BASE_PATH:-$(_do_probe_writable_root /opt  "$HOME/opt")}"
  VAR_BASE_PATH="${VAR_BASE_PATH:-$(_do_probe_writable_root /var "$HOME/var")}"
  export BASE_PATH VAR_BASE_PATH
}

# Returns the first writable candidate path. Creates the fallback if used.
# Never prompts, never sudos, fails silently if neither is writable (the
# caller will see the error when it tries to use the returned path).
_do_probe_writable_root() {
  local primary="$1" fallback="$2" probe
  if [[ -d "$primary" ]]; then
    probe="$primary/.probe-$$-$RANDOM"
    if : > "$probe" 2>/dev/null; then
      rm -f "$probe"
      echo "$primary"
      return 0
    fi
  fi
  mkdir -p "$fallback" 2>/dev/null || true
  echo "$fallback"
}
# run-bsh ::: v3.8.0
