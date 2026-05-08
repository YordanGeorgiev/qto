#!/bin/bash
#------------------------------------------------------------------------------
# @description Display help/usage information for the run.sh framework.
# @description Lists all available actions with their descriptions from metadata tags.
# @example ./run --help
# @example ./run -a do_print_help
#------------------------------------------------------------------------------
do_print_help() {
  cat <<EOF_USAGE
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
   run.sh minimalistic framework
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

   Usage:
   $0 -a <<action-name>>
   or
   $0 -a <<do_action_name>>

   Available actions:
EOF_USAGE

  local proj="${PROJ_PATH:-$(cd "$(dirname "$0")/../../.." && pwd)}"

  # Two-column layout: col1 fits the longest api-versioned action name;
  # col2 is capped so descriptions never wrap on wide terminals, or shrink
  # gracefully on narrow ones. tput/COLUMNS are unreliable when piped, so
  # default generously to 180 and only use a detected value when it is wide
  # enough to be meaningful.
  local term_width col1 col2
  col1=62                                   # fits "./run -a do_confluence_offline_fetch_parent_page_tree_api1"
  term_width=$(tput cols 2>/dev/null || echo 0)
  [[ $term_width -lt $(( col1 + 50 )) ]] && term_width=180   # piped/narrow: fall back to generous default
  col2=$(( term_width - col1 - 12 ))        # 12 = tab(8) + leading-space(1) + col1 + sep(2) + margin(1)
  [[ $col2 -lt 30 ]] && col2=30            # hard minimum

  while read -r fnc_file; do
    # Skip pre/post hooks from the main actions list
    [[ "$fnc_file" == *".pre.func.sh" || "$fnc_file" == *".post.func.sh" ]] && continue

    local action_name
    action_name=$(basename "$fnc_file" .func.sh)
    action_name="do_${action_name//-/_}"

    # Try to extract @description from structured metadata
    local desc=""
    if type do_get_description &>/dev/null; then
      desc=$(do_get_description "$fnc_file" 2>/dev/null || echo "")
    fi

    # Fallback: extract old-style "# Purpose:" line
    if [[ -z "$desc" ]]; then
      desc=$(sed -n '/^# Purpose:/ {s/^# Purpose:[[:space:]]*//p;q;}' "$fnc_file" 2>/dev/null)
    fi

    if [[ -n "$desc" ]]; then
      # Truncate at last word boucsiry to avoid mid-word cuts
      if [[ ${#desc} -gt $col2 ]]; then
        local short="${desc:0:$(( col2 - 3 ))}"
        short="${short% *}"   # trim to last complete word
        desc="${short}..."
      fi
      printf "\t %-${col1}s  %s\n" "./run -a $action_name" "$desc"
    else
      printf "\t ./run -a %s;\n" "$action_name"
    fi
  done < <(find "$proj/src/bash/run/" -name "*.func.sh" 2>/dev/null | sort)

  echo ""
  echo "   Actions support named arguments (--flags):"
  echo "     ./run -a do_help_with --search zip"
  echo ""
  echo "   Environment variables still work (backward compatible):"
  echo "     SRCH=zip ./run -a do_help_with"
  echo ""
  echo "   Run all tests:"
  echo "     bash src/bash/tests/run-all-tests.sh"
  echo ""
  echo "   Tip: Use ./run -a do_help_with --search <keyword> for detailed help."
  echo ""
  export EXIT_CODE=0
}
# run-bsh ::: v3.8.2
