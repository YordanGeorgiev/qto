#!/bin/bash
#------------------------------------------------------------------------------
# @description Extracts bash commands from README.md code blocks and appends
# @description them to the bash history file.
# @param PROJ_PATH (optional) - The path to the project containing the README.md.
# @example PROJ_PATH=/path/to/project ./run -a do_help_to_history
#------------------------------------------------------------------------------
do_help_to_history() {
  local proj_path="${PROJ_PATH:-$(pwd)}" # Use PROJ_PATH if set, otherwise current directory
  local readme_file="$proj_path/README.md"
  local history_file="$HOME/.bash_history"
  local in_code_block=false

  # Check if README.md exists
  if [[ -f "$readme_file" ]]; then
    while IFS= read -r line; do
      # Check for the start of a bash code block
      if [[ "$line" == '```bash' ]]; then
        in_code_block=true
        continue
      fi
      # Check for the end of a code block
      if [[ "$line" == '```' && "$in_code_block" == true ]]; then
        in_code_block=false
        continue
      fi
      # If we are in a bash code block, filter the line
      if [[ "$in_code_block" == true ]]; then
        # Skip empty lines or lines with only whitespace
        if [[ -z "$line" || "$line" =~ ^[[:space:]]*$ ]]; then
          continue
        fi
        # Skip commented lines (starting with # after optional leading whitespace)
        if [[ "$line" =~ ^[[:space:]]*# ]]; then
          continue
        fi
        # Append filtered line to .bash_history
        echo "$line" >>"$history_file"
      fi
    done <"$readme_file"

    # Reload .bash_history into the current session
    history -r

    # Clear the screen
    clear

    # Display the last 15 commands from .bash_history
    echo "Last 15 commands from history:"
    tail -n 15 "$history_file"
  else
    echo "README.md not found at $proj_path."
  fi
  export EXIT_CODE=0
}

# To use this function, set PROJ
# eof file src/bash/run/help-to-history.func.sh
# run-bsh ::: v3.8.2
