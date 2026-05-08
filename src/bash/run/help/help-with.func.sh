#!/bin/bash
#------------------------------------------------------------------------------
# @description Search for help on a topic across function files.
# @description Displays structured metadata (@description, @param, @example) when available,
# @description falls back to raw comment headers for legacy files.
# @param SRCH (required) - The search keyword to match against action names and descriptions
# @example ./run -a do_help_with --search zip
# @example ./run -a do_help_with --search jira
# @example ./run -a do_help_with --search confluence
# @arg --search SRCH
#------------------------------------------------------------------------------
do_help_with() {
  local search_term="${SRCH:-}"

  if [[ -z "$search_term" ]]; then
    do_log "ERROR SRCH variable not set. Usage: SRCH=<topic> ./run -a do_help_with"
    return 11
  fi

  do_log "INFO Searching for help on: \"$search_term\""

  local proj="$PROJ_PATH"
  local total_matches=0

  # --- Search across all func.sh files ---
  while IFS= read -r fpath; do
    local short="${fpath#"${proj}/"}"
    local action_name
    action_name=$(basename "$fpath" .func.sh)
    action_name="do_${action_name//-/_}"

    # Match by filename (action name)
    local matched=0
    if [[ "$fpath" == *"${search_term}"* ]]; then
      matched=1
    fi

    # Match by file content: grep all comment lines (case-insensitive).
    # This is more reliable than do_parse_metadata and finds partial stems
    # (e.g. "analys" matches both "analysis" and "analyze").
    if [[ $matched -eq 0 ]] && grep -qi "$search_term" "$fpath" 2>/dev/null; then
      matched=1
    fi

    [[ $matched -eq 0 ]] && continue

    total_matches=$((total_matches + 1))
    echo ""
    echo "  ══════════════════════════════════════════════════════════════"
    echo "  📄 $short"
    echo "  Action: $action_name"
    echo "  ──────────────────────────────────────────────────────────────"

    # Check for structured metadata
    if type do_has_metadata &>/dev/null && do_has_metadata "$fpath" 2>/dev/null; then
      # --- Structured metadata display ---

      # Description
      local descriptions
      descriptions=$(do_parse_metadata "$fpath" "description" 2>/dev/null)
      if [[ -n "$descriptions" ]]; then
        echo "  Description:"
        while IFS= read -r dline; do
          echo "    ${dline#description=}"
        done <<< "$descriptions"
      fi

      # Parameters
      local params
      params=$(do_parse_metadata "$fpath" "param" 2>/dev/null)
      if [[ -n "$params" ]]; then
        echo ""
        echo "  Parameters:"
        while IFS= read -r pline; do
          local pdef="${pline#param=}"
          # Color required vs optional
          if echo "$pdef" | grep -qi '(required)'; then
            echo "    * $pdef"
          else
            echo "      $pdef"
          fi
        done <<< "$params"
      fi

      # Named Arguments (--flags)
      local arg_flags
      arg_flags=$(do_parse_metadata "$fpath" "arg" 2>/dev/null)
      if [[ -n "$arg_flags" ]]; then
        echo ""
        echo "  Named Arguments:"
        while IFS= read -r aline; do
          local adef="${aline#arg=}"
          local aflag avar
          aflag=$(echo "$adef" | awk '{print $1}')
          avar=$(echo "$adef" | awk '{print $2}')
          printf "    %-20s → %s\n" "$aflag <value>" "$avar"
        done <<< "$arg_flags"
      fi

      # Prerequisites
      local prereqs
      prereqs=$(do_parse_metadata "$fpath" "prereq" 2>/dev/null)
      if [[ -n "$prereqs" ]]; then
        echo ""
        echo "  Prerequisites:"
        while IFS= read -r prline; do
          echo "    - ${prline#prereq=}"
        done <<< "$prereqs"
      fi

      # Examples
      local examples
      examples=$(do_parse_metadata "$fpath" "example" 2>/dev/null)
      if [[ -n "$examples" ]]; then
        echo ""
        echo "  Examples:"
        while IFS= read -r eline; do
          echo "    $ ${eline#example=}"
        done <<< "$examples"
      fi

      # Output
      local outputs
      outputs=$(do_parse_metadata "$fpath" "output" 2>/dev/null)
      if [[ -n "$outputs" ]]; then
        echo ""
        echo "  Output:"
        while IFS= read -r oline; do
          echo "    ${oline#output=}"
        done <<< "$outputs"
      fi

      # See also
      local sees
      sees=$(do_parse_metadata "$fpath" "see" 2>/dev/null)
      if [[ -n "$sees" ]]; then
        echo ""
        echo "  See also:"
        while IFS= read -r sline; do
          echo "    → ${sline#see=}"
        done <<< "$sees"
      fi

    else
      # --- Legacy fallback: show raw comment header ---
      echo "  (legacy format — consider adding @description, @param, @example tags)"
      sed -n '2,/^[^#[:space:]]/{/^#/p}' "$fpath" | sed 's/^#/    /' | head -30
    fi

  done < <(find "$proj/src/bash/run/" "$proj/lib/bash/funcs/" -name "*.func.sh" 2>/dev/null | sort)

  echo ""
  if [[ $total_matches -eq 0 ]]; then
    echo "  No results found for: \"$search_term\""
  fi

  do_log "INFO DONE :: help search complete ($total_matches matches)"
}
# run-bsh ::: v3.8.2
