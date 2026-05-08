#!/bin/bash
#------------------------------------------------------------------------------
# @description Parse structured metadata tags from action file headers.
# @description Extracts @description, @param, @example, @output, @prereq tags.
# @param FILE (required) - Path to the .func.sh file to parse
# @param TAG (optional) - Specific tag to extract (default: all)
# @example do_parse_metadata "src/bash/run/zip-jira-ticket.func.sh"
# @example do_parse_metadata "src/bash/run/zip-jira-ticket.func.sh" "param"
#------------------------------------------------------------------------------

# Parse all metadata from a func.sh file header
# Usage: do_parse_metadata <file_path> [tag_name]
# Outputs structured metadata to stdout
do_parse_metadata() {
  local file_path="${1:?Usage: do_parse_metadata <file_path> [tag_name]}"
  local filter_tag="${2:-}"

  if [[ ! -f "$file_path" ]]; then
    echo "ERROR: File not found: $file_path" >&2
    return 11
  fi

  # Extract the comment header block (lines starting with #, stop at first non-comment non-empty line)
  local in_header=0
  local header=""
  while IFS= read -r line; do
    # Skip shebang
    [[ "$line" =~ ^#!/ ]] && continue
    # Skip separator lines
    [[ "$line" =~ ^#-+$ ]] && { in_header=1; continue; }
    # Stop at non-comment line (but allow blank lines within header)
    if [[ ! "$line" =~ ^# ]] && [[ -n "$line" ]]; then
      break
    fi
    if [[ $in_header -eq 1 && "$line" =~ ^# ]]; then
      header+="${line#\#}"$'\n'
    fi
  done < "$file_path"

  if [[ -z "$header" ]]; then
    return 0
  fi

  # Parse tags from header
  # Supported tags: @description, @param, @example, @output, @prereq, @see
  local current_tag=""
  local current_value=""

  _emit_tag() {
    if [[ -n "$current_tag" && -n "$current_value" ]]; then
      # Trim leading/trailing whitespace from value
      current_value="$(echo "$current_value" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
      if [[ -z "$filter_tag" || "$filter_tag" == "$current_tag" ]]; then
        echo "${current_tag}=${current_value}"
      fi
    fi
  }

  while IFS= read -r line; do
    # Remove leading whitespace
    line="$(echo "$line" | sed 's/^[[:space:]]*//')"

    if [[ "$line" =~ ^@([a-zA-Z_]+)[[:space:]]+(.*) ]]; then
      # New tag found — emit previous
      _emit_tag
      current_tag="${BASH_REMATCH[1]}"
      current_value="${BASH_REMATCH[2]}"
    elif [[ "$line" =~ ^@([a-zA-Z_]+)$ ]]; then
      # Tag with no inline value (value on next line)
      _emit_tag
      current_tag="${BASH_REMATCH[1]}"
      current_value=""
    elif [[ -n "$current_tag" && -n "$line" ]]; then
      # Continuation line for current tag
      current_value+=" ${line}"
    fi
  done <<< "$header"

  # Emit last tag
  _emit_tag
}

# Extract just the @description from a file (first description tag only)
# Usage: do_get_description <file_path>
do_get_description() {
  local file_path="${1:?Usage: do_get_description <file_path>}"
  do_parse_metadata "$file_path" "description" | head -1 | sed 's/^description=//'
}

# Extract all @param lines from a file
# Usage: do_get_params <file_path>
# Output format: param=VAR_NAME (required|optional) - Description text
do_get_params() {
  local file_path="${1:?Usage: do_get_params <file_path>}"
  do_parse_metadata "$file_path" "param"
}

# Check if a file uses the new structured metadata format
# Returns 0 if @description tag found, 1 otherwise
do_has_metadata() {
  local file_path="${1:?Usage: do_has_metadata <file_path>}"
  # Use grep -c to avoid pipe/subshell issues in some environments
  local count
  count=$(do_parse_metadata "$file_path" "description" | grep -c "^description=") || count=0
  [[ $count -gt 0 ]]
}
# run-bsh ::: v3.7.0
